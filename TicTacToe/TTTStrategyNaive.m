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

- (int)optimalPositionFromBoard:(TTTBoard *)board {
    NSArray* available = [board possibleMoves];
    int randomIndex = arc4random_uniform((uint)available.count);
    return [[available objectAtIndex:randomIndex] intValue];
}

@end
