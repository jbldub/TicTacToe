//
//  TTTGame.h
//  TicTacToe
//
//  Created by Justin Williams on 10/15/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTConstants.h"

@class TTTPlayer, TTTBoard;

@protocol TTTGameDelegate <NSObject>

- (void)allowUserInputForPlayer:(TTTPlayer*)player;
- (void)moveSuccessfulForPlayer:(TTTPlayer*)player atPosition:(TTTPosition)pos;

@end

@interface TTTGame : NSObject

@property (nonatomic, strong) TTTPlayer* player1;
@property (nonatomic, strong) TTTPlayer* player2;
@property (nonatomic, weak) TTTPlayer* activePlayer;
@property (nonatomic, strong) TTTBoard* board;
@property (nonatomic, weak) id<TTTGameDelegate> delegate;
@property (nonatomic, readonly) BOOL gameInProgress;

- (id)initGameWIthPlayer1:(TTTPlayer*)player1 player2:(TTTPlayer*)player2;
- (void)start;
- (BOOL)makeMoveForPlayer:(TTTPlayer*)player atPosition:(TTTPosition)location;
- (TTTPlayer*)playerAtPosition:(TTTPosition)pos;

@end


