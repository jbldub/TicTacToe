//
//  TTTBoard.m
//  TicTacToe
//
//  Created by Justin Williams on 10/15/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import "TTTBoard.h"
#import "TTTPlayer.h"
#import "TTTExpertPlayer.h"

@interface TTTBoard () {
    TTTPlayer* board[BOARD_SIZE*BOARD_SIZE];
}
@property (nonatomic, strong) NSMutableSet* availableMoves;
@end

@implementation TTTBoard

- (id)initGameWithPlayer1:(TTTPlayer*)player1 player2:(TTTPlayer*)player2 {
    self = [super init];
    
    if (self) {
        _player1 = player1;
        _player2 = player2;
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    TTTBoard* newBoard = [[[self class] allocWithZone:zone] init];
    if (newBoard) {
        [newBoard setPlayer1:[self player1]];
        [newBoard setPlayer2:[self player2]];
        [newBoard setActivePlayer:[self activePlayer]];
        [newBoard setAvailableMoves:[self.availableMoves mutableCopy]];
        for (int i = 0; i < BOARD_SIZE * BOARD_SIZE; i++) {
            newBoard->board[i] = board[i];
        }
    }
    
    return newBoard;
}

- (void)startGameFirstPlayer:(TTTPlayer *)player {
    for (int i = 0; i < BOARD_SIZE*BOARD_SIZE; i++) {
        board[i] = nil;
    }
    
    self.activePlayer = player;
    self.winningPlayer = nil;
    self.winningRow = nil;
    
    _availableMoves = [[NSMutableSet alloc] init];
    for (int i = 0; i < BOARD_SIZE*BOARD_SIZE; i++) {
        [_availableMoves addObject:[NSNumber numberWithInteger:i]];
    }
    
    self.gameEnded = NO;
    [self queryNextMove];
}

- (void)queryNextMove {
    if (self.gameEnded) {
        [self.delegate gameWonByPlayer:self.winningPlayer atPositions:self.winningRow];
    }
    else if ([self.activePlayer automatedPlayer]) {
        int pos = [(TTTExpertPlayer*)self.activePlayer makeNextMoveOnBoard:self];
        [self markBoardAtPosition:pos];
    } else {
        [self.delegate allowUserInputForPlayer:self.activePlayer];
    }
}

- (void)markBoardAtTTTPosition:(TTTPosition)pos {
    [self markBoardAtPosition:intFromTTTPosition(pos)];
}

- (void)markBoardAtPosition:(int)pos {
    if (!self.gameEnded && [self validPosition:pos] && !board[pos]) {
        board[pos] = self.activePlayer;
        [self.availableMoves removeObject:[NSNumber numberWithInteger:pos]];
        if (![self evaluateWinner]) {
            self.activePlayer = self.activePlayer == self.player1 ? self.player2 : self.player1;
        }
        [self.delegate moveSuccessfulForPlayer:self.activePlayer atPosition:TTTPositionFromInt(pos)];
    }
    [self queryNextMove];
}

- (void)markBoardNoOpAtPosition:(int)pos {
    if (!self.gameEnded && [self validPosition:pos] && !board[pos]) {
        board[pos] = self.activePlayer;
        [self.availableMoves removeObject:[NSNumber numberWithInteger:pos]];
        if (![self evaluateWinner]) {
            self.activePlayer = self.activePlayer == self.player1 ? self.player2 : self.player1;
        }
    }
}

- (TTTPlayer*)evaluateWinner {
    
    for (NSArray* scoreTuple in [TTTBoard winningScores]) {
        int count = 0;
        for (NSNumber* pos in scoreTuple) {
            if (self.activePlayer == [self playerAtPosition:[pos intValue]]) {
                count++;
            }
            else {
                break;
            }
        }
        if (count == BOARD_SIZE) {
            self.winningPlayer = self.activePlayer;
            self.winningRow = scoreTuple;
            self.gameEnded = YES;
            break;
        }
        
    }
    return self.winningPlayer;
}

- (TTTPlayer*)playerAtTTTPosition:(TTTPosition)pos {
    return [self playerAtPosition:intFromTTTPosition(pos)];
}

- (TTTPlayer*)playerAtPosition:(int)pos {
    return [self validPosition:pos] ? board[pos] : nil;
}

- (BOOL)validTTTPosition:(TTTPosition)pos {
    return pos.x >= 0 && pos.x <= BOARD_SIZE && pos.y >= 0 && pos.y <= BOARD_SIZE;
}

- (BOOL)validPosition:(int)pos {
    return pos >= 0 && pos < (BOARD_SIZE * BOARD_SIZE);
}

- (NSArray*)possibleMoves {
    return [[self.availableMoves allObjects] copy];
}

- (BOOL)gameEnded {
    return self.availableMoves.count == 0 || self.winningPlayer != nil;
}

// build a two dimensional array of winning combinations for easy matching
+ (NSArray*)winningScores {
    static NSMutableArray* _winningScores;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _winningScores = [[NSMutableArray alloc] init];
        // build row winners
        for (int i = 0; i < BOARD_SIZE * BOARD_SIZE; i+= BOARD_SIZE) {
            NSMutableArray *line = [[NSMutableArray alloc] init];
            for (int j = i; j < i + BOARD_SIZE; j++) {
                [line addObject:[NSNumber numberWithInt:j]];
            }
            [_winningScores addObject:line];
        }
        
        // build column winners
        for (int i = 0; i < BOARD_SIZE; i++) {
            NSMutableArray *line = [[NSMutableArray alloc] init];
            for (int j = i; j <= BOARD_SIZE * (BOARD_SIZE -1) + i; j += BOARD_SIZE) {
                [line addObject:[NSNumber numberWithInt:j]];
            }
            [_winningScores addObject:line];
        }
        
        NSMutableArray *winningDiagonal = [[NSMutableArray alloc] init];
        // diagonal
        for (int i = 0; i < BOARD_SIZE * BOARD_SIZE; i+= BOARD_SIZE + 1) {
            [winningDiagonal addObject:[NSNumber numberWithInteger:i]];
        }
        [_winningScores addObject:winningDiagonal];
        
        
        NSMutableArray *winningReverseDiagonal = [[NSMutableArray alloc] init];
        // reverse diagonal
        for (int i = BOARD_SIZE - 1; i <= BOARD_SIZE * (BOARD_SIZE - 1); i += BOARD_SIZE - 1) {
            [winningReverseDiagonal addObject:[NSNumber numberWithInteger:i]];
        }
        [_winningScores addObject:winningReverseDiagonal];
    });
    return _winningScores;
}

- (NSString*)description {
    NSMutableString* desc = [[NSMutableString alloc] init];
    [desc appendString:@"\n"];
    for (int i = 0; i < BOARD_SIZE * BOARD_SIZE; i += BOARD_SIZE) {
        for (int j = i; j < i + BOARD_SIZE; j++) {
            [desc appendString:board[j] ? board[j].type == TTTPlayerTypeO ? @"O" : @"X" : @" "];
            [desc appendString:@"  "];
        }
        [desc appendString:@"\n"];
    }
    return desc;
}

@end
