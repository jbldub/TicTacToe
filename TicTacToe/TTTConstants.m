//
//  TTTConstants.m
//  TicTacToe
//
//  Created by Justin Williams on 10/15/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import "TTTConstants.h"

TTTPosition TTTPositionMake(int x, int y) {
    TTTPosition pos;
    pos.x = x;
    pos.y = y;
    return pos;
}

int intFromTTTPosition(TTTPosition pos) {
    return pos.x + pos.y * BOARD_SIZE;
}

TTTPosition TTTPositionFromInt(int pos) {
    int x = pos / BOARD_SIZE;
    int y = pos % BOARD_SIZE;
    return TTTPositionMake(x, y);
}

//NSIndexPath* indexPathFromInt(int pos) {
//    TTTPosition tttPos = TTTPositionFromInt(pos);
//    NSIndexPath index
//    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:tttPos.y inSection:tttPos.x];
//    return indexPath;
//}