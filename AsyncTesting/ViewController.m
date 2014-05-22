//
//  ViewController.m
//  AsyncTesting
//
//  Created by Anish Basu on 5/21/14.
//  Copyright (c) 2014 Anish Basu. All rights reserved.
//

#import "ViewController.h"
#import "SomeLoader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_apiDidLoad:)
                                                 name:kLoadSuccessfulNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_apiDidFail:)
                                                 name:kLoadFailedNotification
                                               object:nil];
    SomeLoader *loader = [[SomeLoader alloc] init];
    [loader fetchSomeObjectsWithCompletion:^(NSDictionary *result, NSError *error) {
        if (nil == error) {
            NSLog(@"Got back result in completion block");
        }
    }];
    
    [loader alwaysFailWithCompletion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_apiDidLoad:(NSNotification *)notification
{
    
}

- (void)_apiDidFail:(NSNotification *)notification
{
    NSLog(@"Got back notification for failed completion");
}


@end
