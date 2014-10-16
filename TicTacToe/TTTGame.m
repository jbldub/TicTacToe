//
//  TTTGame.m
//  TicTacToe
//
//  Created by Justin Williams on 10/15/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import "TTTGame.h"
#import "TTTBoard.h"
#import "TTTExpertPlayer.h"

@interface TTTGame()
@property (nonatomic, readwrite) BOOL gameInProgress;
@end

@implementation TTTGame

- (id)initGameWIthPlayer1:(TTTPlayer*)player1 player2:(TTTPlayer*)player2 {
    self = [super init];
    
    if (self) {
        _player1 = player1;
        _player2 = player2;
    }
    
    return self;
}

- (void)start {
    self.gameInProgress = YES;
    self.board = [[TTTBoard alloc] init];
    
    if (!self.activePlayer) {
        self.activePlayer = self.player1;
    }
    
    if ([self.activePlayer isKindOfClass:[TTTExpertPlayer class]]) {
        TTTPosition pos = [(TTTExpertPlayer*)self.activePlayer makeNextMoveOnBoard:self.board];
        [self makeMoveForPlayer:self.activePlayer atPosition:pos];
        
    } else {
        [self.delegate allowUserInputForPlayer:self.activePlayer];
    }
    
}

- (void)setActivePlayer:(TTTPlayer *)activePlayer {
    if (!self.gameInProgress) {
        _activePlayer = activePlayer;
    }
}

- (TTTPlayer*)playerAtPosition:(TTTPosition)pos {
    return [self.board playerAtPosition:pos];
}

- (BOOL)makeMoveForPlayer:(TTTPlayer*)player atPosition:(TTTPosition)location {
    BOOL success = [self.board markBoardWithPlayer:player position:location];

    return success;
}

@end
