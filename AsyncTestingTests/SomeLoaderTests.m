//
//  SomeLoaderTests.m
//  AsyncTesting
//
//  Created by Anish Basu on 5/22/14.
//  Copyright (c) 2014 Anish Basu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <XCAsyncTestCase/XCTestCase+AsyncTesting.h>
#import "SomeLoader.h"

double const kXCAsyncTestWaitTimeout = 5.0;

@interface SomeLoaderTests : XCTestCase
@property (nonatomic, strong) SomeLoader *loader;
@end

@implementation SomeLoaderTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.loader = [[SomeLoader alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_apiDidLoad:)
                                                 name:kLoadSuccessfulNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_apiDidFail:)
                                                 name:kLoadFailedNotification
                                               object:nil];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.loader = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super tearDown];
}

- (void)testfetchSomeObjects
{
    [self.loader fetchSomeObjectsWithCompletion:^(NSDictionary *result, NSError *error) {
        XCTAssertNil(error, @"Error returned");
        [self notify:XCTAsyncTestCaseStatusSucceeded];
    }];
    
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:kXCAsyncTestWaitTimeout];
}

- (void)testAlwaysFailWithCompletion
{
    [self.loader alwaysFailWithCompletion:^(NSDictionary *result, NSError *error) {
        XCTAssertNotNil(error, @"Should have returned error");
        [self notify:XCTAsyncTestCaseStatusSucceeded];
    }];
    
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:kXCAsyncTestWaitTimeout];
}

- (void)testFetchSomeObjectsWithNotification
{
    [self.loader fetchSomeObjectsWithCompletion:nil];
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:kXCAsyncTestWaitTimeout];
}


#pragma mark - NSNotifications

- (void)_apiDidLoad:(NSNotification *)notification
{
    [self notify:XCTAsyncTestCaseStatusSucceeded];
}

- (void)_apiDidFail:(NSNotification *)notification
{
    [self notify:XCTAsyncTestCaseStatusSucceeded];
}


@end
