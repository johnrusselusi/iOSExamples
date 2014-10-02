//
//  BNRCoursesViewController.m
//  Nerdfeed
//
//  Created by John Russel Usi on 10/2/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "BNRCoursesViewController.h"
#import "BNRWebViewController.h"

@interface BNRCoursesViewController () <NSURLSessionDataDelegate>

@property (nonatomic, strong)NSURLSession *session;
@property (nonatomic, copy)NSArray *courses;

@end

@implementation BNRCoursesViewController

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

  NSDictionary *course = self.courses[indexPath.row];
  NSURL *URL = [NSURL URLWithString:course[@"url"]];
  
  self.webViewController.title = course[@"title"];
  self.webViewController.URL = URL;
  [self.navigationController pushViewController:self.webViewController
                                       animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{

  return [self.courses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{

  UITableViewCell *cell =
          [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                          forIndexPath:indexPath];
  
  NSDictionary *course = self.courses[indexPath.row];
  cell.textLabel.text = course[@"title"];
  
  return cell;
}

- (instancetype)initWithStyle:(UITableViewStyle)style{

  self = [super initWithStyle:style];
  
  if (self) {
    self.navigationItem.title = @"BNRCourses";
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    
    _session = [NSURLSession sessionWithConfiguration:config
                                             delegate:self
                                        delegateQueue:nil];
    [self fetchFeed];
  }
  
  return self;
}

- (void)fetchFeed{

  NSString *requestString = @"https://bookapi.bignerdranch.com/private/courses.json";
  NSURL *url = [NSURL URLWithString:requestString];
  NSURLRequest *req = [NSURLRequest requestWithURL:url];
  
  NSURLSessionDataTask *dataTask =
    [self.session dataTaskWithRequest:req
                    completionHandler:
     ^(NSData *data, NSURLResponse *response, NSError *error){
     
       NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:0
                                                                    error:nil];
       self.courses = jsonObject[@"courses"];
       NSLog(@"%@", self.courses);
       
       dispatch_async(dispatch_get_main_queue(), ^{
         [self.tableView reloadData];
       });
     }];
  
  [dataTask resume];
}

- (void)viewDidLoad{

  [super viewDidLoad];
  
  [self.tableView registerClass:[UITableViewCell class]
         forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:
(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler{

  NSURLCredential *cred =
  [NSURLCredential credentialWithUser:@"BigNerdRanch"
                             password:@"AchieveNerdvana"
                          persistence:NSURLCredentialPersistenceForSession];
  
  completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
}

@end
