//
//  TTTStrategy.h
//  TicTacToe
//
//  Created by Justin Williams on 10/15/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTDefines.h"

@class TTTBoard;

@protocol TTTStrategy <NSObject>
- (int)optimalPositionFromBoard:(TTTBoard*)board;
@end
