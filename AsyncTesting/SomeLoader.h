//
//  SomeLoader.h
//  AsyncTesting
//
//  Created by Anish Basu on 5/21/14.
//  Copyright (c) 2014 Anish Basu. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kLoadSuccessfulNotification;
extern NSString *const kLoadFailedNotification;

typedef void(^SomeLoaderCompletionHandler)(NSDictionary *result, NSError *error);

@interface SomeLoader : NSObject

- (void)fetchSomeObjectsWithCompletion:(SomeLoaderCompletionHandler)handler;
- (void)alwaysFailWithCompletion:(SomeLoaderCompletionHandler)handler;

@end
