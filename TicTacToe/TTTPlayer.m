//
//  TTTPlayer.m
//  TicTacToe
//
//  Created by Justin Williams on 10/14/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import "TTTPlayer.h"

@implementation TTTPlayer

- (id)initWithName:(NSString *)playerName playerType:(TTTPlayerType)type {
    self = [super init];
    
    if (self) {
        _playerName = playerName;
        _type = type;
    }
    
    return self;
}

- (BOOL)automatedPlayer {
    return NO;
}

@end
