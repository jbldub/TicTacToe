//
//  TTTConstants.h
//  TicTacToe
//
//  Created by Justin Williams on 10/15/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct TTTPosition {
    int x;
    int y;
} TTTPosition;

TTTPosition TTTPositionMake(int x, int y);
int intFromTTTPosition(TTTPosition pos);
TTTPosition TTTPositionFromInt(int pos);
//NSIndexPath* indexPathFromInt(int pos);

#define BOARD_SIZE  3


