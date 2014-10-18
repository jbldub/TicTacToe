//
//  TTTStrategyFactory.h
//  TicTacToe
//
//  Created by Justin Williams on 10/15/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTBoard.h"

@protocol TTTStrategy;

typedef enum {
    TTTStrategyTypeNaive,
    TTTSTrategyTypeMiniMax
} TTTStrategyType;

@interface TTTStrategyFactory : NSObject

+ (TTTStrategyFactory *)sharedInstance;
- (id<TTTStrategy>)strategyForType:(TTTStrategyType)type;

@end

