//
//  DetailsViewController.m
//  Flix
//
//  Created by Adrienne Li on 6/24/20.
//  Copyright © 2020 ahli. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "trailerViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    //Customize Navigation Bar
    self.navigationBar.title = self.movie[@"title"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    
    // pretty much a string, but checks for valid URL
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    self.posterView.alpha = 0;
    [self.posterView setImageWithURL:posterURL];
    self.posterView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.posterView.layer.borderWidth = 1;
    [UIView animateWithDuration:1.5 animations:^{
        self.posterView.alpha = 1.0;
    }];
    
    NSString *backdropURLString = self.movie[@"poster_path"];
    if (self.movie[@"backdrop_path"] != [NSNull null]){
        backdropURLString = self.movie[@"backdrop_path"];
    }
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];

    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
    self.backdropView.alpha = 0;
    [self.backdropView setImageWithURL:backdropURL];
    [UIView animateWithDuration:1.5 animations:^{
        self.backdropView.alpha = 1.0;
    }];
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    self.dateLabel.text = self.movie[@"release_date"];
    self.ratingLabel.text = [NSString stringWithFormat: @"%@", self.movie[@"vote_average"]];
    
    [self.titleLabel sizeToFit];
    [self.synopsisLabel sizeToFit];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    trailerViewController *trailerViewController = segue.destinationViewController;
    trailerViewController.movie = self.movie;
    
}

@end
