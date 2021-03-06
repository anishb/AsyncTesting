//
//  AsyncTestingTests.m
//  AsyncTestingTests
//
//  Created by Anish Basu on 5/21/14.
//  Copyright (c) 2014 Anish Basu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <XCTAsyncTestCase/XCTAsyncTestCase.h>
#import "SomeLoader.h"

double const kXCTestWaitTimeout = 5.0;

@interface AsyncTestingTests : XCTAsyncTestCase
@property (nonatomic, strong) SomeLoader *loader;
@end

@implementation AsyncTestingTests

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
    [self prepare];
    [self.loader fetchSomeObjectsWithCompletion:^(NSDictionary *result, NSError *error) {
        XCTAssertNil(error, @"Error returned");
        [self notify:kXCTUnitWaitStatusSuccess];
    }];
    
    [self waitForStatus:kXCTUnitWaitStatusSuccess timeout:5.0];
}

- (void)testAlwaysFailWithCompletion
{
    [self prepare];
    [self.loader alwaysFailWithCompletion:^(NSDictionary *result, NSError *error) {
        XCTAssertNotNil(error, @"Should have returned error");
        [self notify:kXCTUnitWaitStatusSuccess];
    }];
    
    [self waitForStatus:kXCTUnitWaitStatusSuccess timeout:kXCTestWaitTimeout];
}

- (void)testFetchSomeObjectsWithNotification
{
    [self prepare];
    [self.loader fetchSomeObjectsWithCompletion:nil];
    [self waitForStatus:kXCTUnitWaitStatusSuccess timeout:kXCTestWaitTimeout];
}

#pragma mark - NSNotifications

- (void)_apiDidLoad:(NSNotification *)notification
{
    [self notify:kXCTUnitWaitStatusSuccess];
}

- (void)_apiDidFail:(NSNotification *)notification
{
    [self notify:kXCTUnitWaitStatusSuccess];
}




@end
