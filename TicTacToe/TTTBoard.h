//
//  TTTBoard.h
//  TicTacToe
//
//  Created by Justin Williams on 10/15/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTDefines.h"

@class TTTPlayer;

@protocol TTTGameDelegate <NSObject>

- (void)allowUserInputForPlayer:(TTTPlayer*)player;
- (void)moveSuccessfulForPlayer:(TTTPlayer*)player atPosition:(TTTPosition)pos;
- (void)gameWonByPlayer:(TTTPlayer*)player atPositions:(NSArray*)boardPositions;

@end

@interface TTTBoard : NSObject<NSCopying>
- (id)initGameWithPlayer1:(TTTPlayer*)player1 player2:(TTTPlayer*)player2;
- (void)markBoardAtTTTPosition:(TTTPosition)pos;
- (void)markBoardAtPosition:(int)pos;
- (BOOL)markBoardNoOpAtPosition:(int)pos;
- (TTTPlayer*)playerAtTTTPosition:(TTTPosition)pos;
- (TTTPlayer*)playerAtPosition:(int)pos;
- (NSArray*)possibleMoves;
- (void)startGameFirstPlayer:(TTTPlayer*)player;
+ (NSArray*)winningScores;

@property (nonatomic) BOOL gameEnded;
@property (nonatomic, strong) TTTPlayer* player1;
@property (nonatomic, strong) TTTPlayer* player2;
@property (nonatomic, weak) TTTPlayer* activePlayer;
@property (nonatomic, weak) TTTPlayer* winningPlayer;
@property (nonatomic, weak) NSArray* winningRow;
@property (nonatomic, weak) id<TTTGameDelegate> delegate;
@end
