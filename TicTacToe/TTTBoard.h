//
//  TTTBoard.h
//  TicTacToe
//
//  Created by Justin Williams on 10/15/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTConstants.h"

@class TTTPlayer;

@interface TTTBoard : NSObject
- (BOOL)markBoardWithPlayer:(TTTPlayer*)player position:(TTTPosition)pos;
- (TTTPlayer*)playerAtPosition:(TTTPosition)pos;
@end
