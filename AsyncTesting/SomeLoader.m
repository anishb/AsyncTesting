//
//  SomeLoader.m
//  AsyncTesting
//
//  Created by Anish Basu on 5/21/14.
//  Copyright (c) 2014 Anish Basu. All rights reserved.
//

#import "SomeLoader.h"

NSString *const kLoadSuccessfulNotification = @"SomeLoaderSuccess";
NSString *const kLoadFailedNotification = @"SomeLoaderFailure";

@implementation SomeLoader

- (void)fetchSomeObjectsWithCompletion:(SomeLoaderCompletionHandler)handler
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2.0);
        NSDictionary *result = @{@"foo": @"bar"};
        dispatch_async(dispatch_get_main_queue(), ^{
            if (nil != handler) {
                handler(result, nil);
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoadSuccessfulNotification object:nil];
        });
    });
}

- (void)alwaysFailWithCompletion:(SomeLoaderCompletionHandler)handler
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2.0);
        NSError *error = [NSError errorWithDomain:NSOSStatusErrorDomain
                                             code:343
                                         userInfo:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (handler != nil) {
                handler(nil, error);
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoadFailedNotification object:nil];
        });
    });
}

@end
