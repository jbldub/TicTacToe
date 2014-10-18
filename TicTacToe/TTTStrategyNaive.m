//
//  TTTStrategyNaive.m
//  TicTacToe
//
//  Created by Justin Williams on 10/15/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import "TTTStrategyNaive.h"
#import "TTTBoard.h"

@implementation TTTStrategyNaive

- (TTTPosition)optimalPositionFromBoard:(TTTBoard *)board player:(id)player{
    return TTTPositionMake(0, 0);
}

@end
