//
//  TTTExpertPlayer.m
//  TicTacToe
//
//  Created by Justin Williams on 10/15/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import "TTTExpertPlayer.h"
#import "TTTStrategyFactory.h"
#import "TTTStrategy.h"

@interface TTTExpertPlayer ()

@property (nonatomic, strong) id<TTTStrategy> strategy;

@end

@implementation TTTExpertPlayer

- (id)initWithName:(NSString *)playerName playerType:(TTTPlayerType)type strategy:(TTTStrategyType)strategy {
    self = [super initWithName:playerName playerType:type];
    
    if (self) {
        _strategy = [[TTTStrategyFactory sharedInstance] strategyForType:strategy];
    }
    
    return self;
}

- (TTTPosition)makeNextMoveOnBoard:(TTTBoard *)board {
    return [self.strategy optimalPositionFromBoard:board];
}

@end
