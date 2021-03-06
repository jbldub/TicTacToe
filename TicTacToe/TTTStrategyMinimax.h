//
//  TTTStrategyMinimax.h
//  TicTacToe
//
//  Created by Justin Williams on 10/17/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTStrategy.h"

@class TTTPlayer;

@interface TTTStrategyMinimax : NSObject<TTTStrategy>
@property (nonatomic, weak) TTTPlayer* maxPlayer;
- (id)initWithPlayer:(TTTPlayer*)player;
@end
