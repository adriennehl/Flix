//
//  trailerViewController.m
//  Flix
//
//  Created by Adrienne Li on 6/25/20.
//  Copyright © 2020 ahli. All rights reserved.
//

#import "trailerViewController.h"
#import "Webkit/WebKit.h"

@interface trailerViewController ()
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet WKWebView *trailerWebView;

@end

@implementation trailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchTrailer];
}

-(void)fetchTrailer{
    
    NSString *fullURL = [NSString stringWithFormat: @"https://api.themoviedb.org/3/movie/%@/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US", self.movie[@"id"]];
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies" message: error.localizedDescription preferredStyle:(UIAlertControllerStyleAlert)];
               UIAlertAction *retryAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   [self fetchTrailer];
                   }];
               UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
               [alert addAction:cancelAction];
               [alert addAction:retryAction];
               
               [self presentViewController:alert animated:YES completion:^{
               }];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               NSArray *results = dataDictionary[@"results"];
               NSString *key = results[0][@"key"];
               NSString *video = [NSString stringWithFormat:@"https://www.youtube.com/watch?v=\%@", key];
               
               NSURL *videoURL = [NSURL URLWithString:video];

               // Place the URL in a URL Request.
               NSURLRequest *request = [NSURLRequest requestWithURL:videoURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
               // Load Request into WebView.
               [self.trailerWebView loadRequest:request];
            }
       }];
    [task resume];
}

- (IBAction)onClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
