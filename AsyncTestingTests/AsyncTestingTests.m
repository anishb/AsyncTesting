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

@interface AsyncTestingTests : XCTestCase
@property (nonatomic, strong) SomeLoader *loader;
@end

@implementation AsyncTestingTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.loader = [[SomeLoader alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.loader = nil;
    [super tearDown];
}

- (void)testfetchSomeObjects
{
    [self.loader fetchSomeObjectsWithCompletion:^(NSDictionary *result, NSError *error) {
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            XCTAssertTrue(NO, @"No error returned");
        //});
    }];
    
    sleep(10.0);
}


@end
