//
//  TicTacToeGameViewController.h
//  TicTacToe
//
//  Created by Justin Williams on 10/14/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTGame.h"

@interface TicTacToeGameViewController : UIViewController<TTTGameDelegate>

- (id)initWithGame:(TTTGame*)game;

@end
