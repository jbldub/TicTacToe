//
//  TTTStrategyMinimax.m
//  TicTacToe
//
//  Created by Justin Williams on 10/17/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import "TTTStrategyMinimax.h"
#import "TTTConstants.h"
#import "TTTBoard.h"

static const int kAlpha = -1000;
static const int kBeta = 1000;

typedef struct TTTPositionWithScore {
    TTTPosition pos;
    int score;
} TTTPositionWithScore;

TTTPositionWithScore TTTPositionWithScoreMake(TTTPosition pos, int score) {
    TTTPositionWithScore posWithScore;
    posWithScore.pos = pos;
    posWithScore.score = score;
    return posWithScore;
}

typedef struct MoveWithScore {
    int pos;
    int score;
} MoveWithScore;

MoveWithScore MoveWithScoreMake(int pos, int score) {
    MoveWithScore moveWithScore;
    moveWithScore.pos = pos;
    moveWithScore.score = score;
    return moveWithScore;
}

@interface TTTStrategyMinimax ()
@property (nonatomic, weak) TTTPlayer* maxPlayer;
@end


@implementation TTTStrategyMinimax

- (id)initWithPlayer:(TTTPlayer*)player {
    self = [super init];
    
    if (self) {
        _maxPlayer = player;
    }
    
    return self;
}

- (int)optimalPositionFromBoard:(TTTBoard*)board {
    
    // set default value to invalid position in case there are no options for player
    MoveWithScore moveScore;
    moveScore.pos = -1;
    
    moveScore = [self minimaxFromBoard:board max:true alpha:kAlpha beta:kBeta];
    
    return moveScore.pos;
}
    
- (MoveWithScore)minimaxFromBoard:(TTTBoard*)board max:(BOOL)max alpha:(int)alpha beta:(int)beta {
    
    if ([board gameEnded]) {
        MoveWithScore moveScore;
        moveScore.score = [self evaluateBoard:board];
        return moveScore;
    }
    
    NSArray* possible = [board possibleMoves];
    if (max) {
        NSNumber *lastMove;
        for (NSNumber* move in possible) {
            TTTBoard* child = [board copy];
            [child markBoardAtPosition:[move intValue]];
            MoveWithScore moveScore = [self minimaxFromBoard:child max:!max alpha:alpha beta:beta];
            moveScore.pos = [move intValue];
            if (moveScore.score > alpha) {
                alpha = moveScore.score;
            }
            if (alpha >= beta) {
                return moveScore;
            }
        }
        return MoveWithScoreMake([lastMove intValue], alpha);
    }
    else {
        NSNumber *lastMove;
        for (NSNumber* move in possible) {
            TTTBoard* child = [board copy];
            [child markBoardAtPosition:[move intValue]];
            MoveWithScore moveScore = [self minimaxFromBoard:child max:!max alpha:alpha beta:beta];
            moveScore.pos = [move intValue];
            if (moveScore.score < alpha) {
                beta = moveScore.score;
            }
            if (alpha >= beta) {
                return moveScore;
            }
        }
        return MoveWithScoreMake([lastMove intValue], beta);
    }
    
}

- (int)evaluateBoard:(TTTBoard*)board {
    TTTPlayer* player = board.winningPlayer;
    if ( !player ) {
        return 0;
    } else if (player == self.maxPlayer) {
        return 10;
    } else {
        return -10;
    }
}



@end
