//
//  SearchViewController.m
//  Flix
//
//  Created by Adrienne Li on 6/26/20.
//  Copyright © 2020 ahli. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCellTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong) NSArray *filteredData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSString *searchItem;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.searchBar.delegate = self;
}

-(void)fetchMovies{
    
    // create request for search
    NSString *query = [NSString stringWithFormat: @"https://api.themoviedb.org/3/search/movie?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&query=%@&page=1&include_adult=false", self.searchItem];
    query = [query stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *url = [NSURL URLWithString:query];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies" message: error.localizedDescription preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *retryAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self fetchMovies];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
            [alert addAction:cancelAction];
            [alert addAction:retryAction];
            
            [self presentViewController:alert animated:YES completion:^{
            }];
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            self.filteredData = dataDictionary[@"results"];
            [self.tableView reloadData];
        }
    }];
    [task resume];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    
    NSDictionary *movie = self.filteredData[indexPath.row];
    
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"overview"];
    cell.ratingLabel.text = [NSString stringWithFormat: @"%@", movie[@"vote_average"]];
    
    if (movie[@"poster_path"] != [NSNull null]){
        NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
        NSString *posterURLString = movie[@"poster_path"];
        NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
        
        
        // pretty much a string, but checks for valid URL
        NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
        cell.posterView.image = [UIImage imageNamed: @"camera_icon.png"];
        cell.posterView.alpha = 0;
        [cell.posterView setImageWithURL:posterURL];
        [UIView animateWithDuration:1.5 animations:^{
            cell.posterView.alpha = 1.0;
        }];
    }
    else {
        cell.posterView.image = [UIImage imageNamed: @"camera_icon.png"];
    };
    
    //customize selection style
    UIView *backgroundView = [[UIView alloc] init];
    UIColor *myColor = [UIColor colorWithRed: 180.0/255.0 green: 238.0/255.0 blue:150.0/255.0 alpha: 1.0];
    backgroundView.backgroundColor = myColor;
    cell.selectedBackgroundView = backgroundView;
    
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length != 0) {
        self.searchItem = searchText;
    }
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self fetchMovies];
    [self.searchBar resignFirstResponder];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    NSDictionary *movie = self.filteredData[indexPath.row];
    
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie;
}


@end
