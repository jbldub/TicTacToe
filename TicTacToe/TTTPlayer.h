//
//  TTTPlayer.h
//  TicTacToe
//
//  Created by Justin Williams on 10/14/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TTTPlayerTypeX,
    TTTPlayerTypeO,
    TTTPlayerTypeEmpty
} TTTPlayerType;

@interface TTTPlayer : NSObject

@property TTTPlayerType type;
@property (nonatomic, strong, readonly) NSString* playerName;
- (id)initWithName:(NSString*)playerName playerType:(TTTPlayerType)type;
- (BOOL)automatedPlayer;
@end
