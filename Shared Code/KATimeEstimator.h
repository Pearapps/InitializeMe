//
//  KATimeEstimator.h
//  Phoenix
//
//  Created by Kenneth Parker Ackerson on 5/29/16.
//  Copyright © 2016 Kenneth Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KATimeEstimator : NSObject

- (nonnull instancetype)initWithNumberOfProperties:(NSInteger)numberOfProperties;

- (NSInteger)estimatedSecondsSaved;

@end
