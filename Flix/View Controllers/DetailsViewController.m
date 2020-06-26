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
    NSString *smallBaseURLString = @"https://image.tmdb.org/t/p/w45";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSString *smallFullPosterURLString = [smallBaseURLString stringByAppendingString:posterURLString];
    
    // pretty much a string, but checks for valid URL
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    NSURL *smallPosterURL = [NSURL URLWithString:smallFullPosterURLString];
    
    self.posterView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.posterView.layer.borderWidth = 1;
    
    NSURLRequest *requestSmall = [NSURLRequest requestWithURL:smallPosterURL];
    NSURLRequest *requestLarge = [NSURLRequest requestWithURL:posterURL];
    
    __weak DetailsViewController *weakSelf = self;
    
    [self.posterView setImageWithURLRequest:requestSmall
                           placeholderImage: [UIImage imageNamed: @"camera_icon.png"]
                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *smallImage) {
        
        // smallImageResponse will be nil if the smallImage is already available
        // in cache (might want to do something smarter in that case).
        weakSelf.posterView.alpha = 0.0;
        weakSelf.posterView.image = smallImage;
        
        [UIView animateWithDuration:1.5
                         animations:^{
            
            weakSelf.posterView.alpha = 1.0;
            
        } completion:^(BOOL finished) {
            // The AFNetworking ImageView Category only allows one request to be sent at a time
            // per ImageView. This code must be in the completion block.
            [weakSelf.posterView setImageWithURLRequest:requestLarge
                                       placeholderImage:smallImage
                                                success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage * largeImage) {
                weakSelf.posterView.image = largeImage;
            }
                                                failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                NSLog(@"hello2");
            }];
        }];
    }
                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        // do something for the failure condition
        // possibly try to get the large image
        NSLog(@"hello");
    }];
    
    NSString *backdropURLString = self.movie[@"poster_path"];
    if (self.movie[@"backdrop_path"] != [NSNull null]){
        backdropURLString = self.movie[@"backdrop_path"];
    }
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    NSString *smallFullBackdropURLString = [smallBaseURLString stringByAppendingString:backdropURLString];
    
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
    NSURL *smallBackdropURL = [NSURL URLWithString:smallFullBackdropURLString];
    
    NSURLRequest *requestBackdropSmall = [NSURLRequest requestWithURL:smallBackdropURL];
    NSURLRequest *requestBackdropLarge = [NSURLRequest requestWithURL:backdropURL];
    
    [self.backdropView setImageWithURLRequest:requestBackdropSmall
                           placeholderImage: [UIImage imageNamed: @"camera_icon.png"]
                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *smallBackdropImage) {
        
        // smallImageResponse will be nil if the smallImage is already available
        // in cache (might want to do something smarter in that case).
        weakSelf.backdropView.alpha = 0.0;
        weakSelf.backdropView.image = smallBackdropImage;
        
        [UIView animateWithDuration:1.5
                         animations:^{
            
            weakSelf.backdropView.alpha = 1.0;
            
        } completion:^(BOOL finished) {
            // The AFNetworking ImageView Category only allows one request to be sent at a time
            // per ImageView. This code must be in the completion block.
            [weakSelf.backdropView setImageWithURLRequest:requestBackdropLarge
                                       placeholderImage:smallBackdropImage
                                                success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage * largeBackdropImage) {
                weakSelf.backdropView.image = largeBackdropImage;
            }
                                                failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            }];
        }];
    }
                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        // do something for the failure condition
        // possibly try to get the large image
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
