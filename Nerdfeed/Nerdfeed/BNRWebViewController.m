//
//  BNRWebViewController.m
//  Nerdfeed
//
//  Created by John Russel Usi on 10/2/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "BNRWebViewController.h"

@implementation BNRWebViewController

- (void)loadView{

  UIWebView *webView = [[UIWebView alloc]init];
  webView.scalesPageToFit = YES;
  self.view = webView;
}

- (void)setURL:(NSURL *)URL{

  _URL = URL;
  if (_URL) {
    
    NSURLRequest *req = [NSURLRequest requestWithURL:_URL];
    [(UIWebView *)self.view loadRequest:req];
  }
}

@end
