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
#import "TTTPlayer.h"

static const int kAlpha = INT_MIN;
static const int kBeta = INT_MAX;

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
        moveScore.pos = -1;
        return moveScore;
    }
    
    NSArray* possible = [board possibleMoves];
    if (max) {
        NSNumber *currMove = [NSNumber numberWithInt:-1];
        for (NSNumber* move in possible) {
            TTTBoard* child = [board copy];
            [child markBoardNoOpAtPosition:[move intValue]];
            MoveWithScore moveScore = [self minimaxFromBoard:child max:!max alpha:alpha beta:beta];
            if (moveScore.score > alpha) {
                alpha = moveScore.score;
                currMove = move;
            }
            if (alpha >= beta) {
                return MoveWithScoreMake([currMove intValue], alpha);;
            }
        }
        return MoveWithScoreMake([currMove intValue], alpha);
    }
    else {
        NSNumber *currMove = [NSNumber numberWithInt:-1];
        for (NSNumber* move in possible) {
            TTTBoard* child = [board copy];
            [child markBoardNoOpAtPosition:[move intValue]];
            MoveWithScore moveScore = [self minimaxFromBoard:child max:!max alpha:alpha beta:beta];
            if (moveScore.score < beta) {
                beta = moveScore.score;
                currMove = move;
            }
            if (alpha >= beta) {
                return MoveWithScoreMake([currMove intValue], beta);
            }
        }
        return MoveWithScoreMake([currMove intValue], beta);
    }
    
}

- (int)evaluateBoard:(TTTBoard*)board {
    int score = 0;
    for (NSArray* scoreTuple in [TTTBoard winningScores]) {
        score += [self evaluateWinningTuple:scoreTuple forBoard:board];
    }
    return score;
}

- (int)evaluateWinningTuple:(NSArray*)tuple forBoard:(TTTBoard*)board {
    int countX = 0, countO = 0;
    for (NSNumber* pos in tuple) {
        int position = [pos intValue];
        TTTPlayer* player = [board playerAtPosition:position];
        if (player && player.type == TTTPlayerTypeX) {
            countX++;
        } else if (player && player.type == TTTPlayerTypeO) {
            countO++;
        }
    }
    TTTPlayerType type = self.maxPlayer.type;
    // if countO is equal to 0 and countX isn't we are interested in this score
    if (countO == 0 && countX != 0) {
        int factor = type == TTTPlayerTypeX ? 1 : -1;
        return factor * pow(10, countX);
    }
    // if countX is equal to 0 and countO isn't we are interested in this score
    else if (countX == 0 && countO != 0) {
        int factor = type == TTTPlayerTypeO ? 1 : -1;
        return factor * pow(10, countO);
    }
    // otherwise we have at least one of each in this row and it's no use
    else {
        return 0;
    }
}



@end
