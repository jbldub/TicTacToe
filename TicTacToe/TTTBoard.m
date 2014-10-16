//
//  TTTBoard.m
//  TicTacToe
//
//  Created by Justin Williams on 10/15/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import "TTTBoard.h"
#import "TTTPlayer.h"

@interface TTTBoard () {
    TTTPlayer* board[BOARD_SIZE][BOARD_SIZE];
}

@end

@implementation TTTBoard

- (BOOL)markBoardWithPlayer:(TTTPlayer*)player position:(TTTPosition)pos {
    
    if ([self validPosition:pos] && !board[pos.x][pos.y]) {
        board[pos.x][pos.y] = player;
        return true;
    }
    
    return false;
}

- (TTTPlayer*)playerAtPosition:(TTTPosition)pos {
    return [self validPosition:pos] ? board[pos.x][pos.y] : nil;
}

- (BOOL)validPosition:(TTTPosition)pos {
    return pos.x >= 0 && pos.x <= BOARD_SIZE && pos.y >= 0 && pos.y <= BOARD_SIZE;
}

@end
