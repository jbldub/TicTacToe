//
//  TTTStrategyFactory.m
//  TicTacToe
//
//  Created by Justin Williams on 10/15/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import "TTTStrategyFactory.h"
#import "TTTStrategy.h"
#import "TTTStrategyNaive.h"
#import "TTTStrategyMinimax.h"

@implementation TTTStrategyFactory

+ (id)sharedInstance {
    static TTTStrategyFactory *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[TTTStrategyFactory alloc] init];
    });
    return sharedSingleton;
}

- (id<TTTStrategy>)strategyForType:(TTTStrategyType)type player:(TTTPlayer *)player {
    id<TTTStrategy> strategy = nil;
    switch (type) {
        case TTTStrategyTypeNaive:
            strategy = [[TTTStrategyNaive alloc] init];
            break;
        case TTTSTrategyTypeMiniMax:
            strategy = [[TTTStrategyMinimax alloc] initWithPlayer:player];
            break;
        default:
            break;
    }
    
    return strategy;
}

@end
