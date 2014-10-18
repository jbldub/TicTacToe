//
//  TTTExpertPlayer.h
//  TicTacToe
//
//  Created by Justin Williams on 10/15/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import "TTTPlayer.h"
#import "TTTStrategyFactory.h"

@class TTTBoard;

@interface TTTExpertPlayer : TTTPlayer

- (id)initWithName:(NSString *)playerName playerType:(TTTPlayerType)type strategy:(TTTStrategyType)strategy;

- (int)makeNextMoveOnBoard:(TTTBoard*)board;

@end
