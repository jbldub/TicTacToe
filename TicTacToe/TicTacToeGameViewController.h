//
//  TicTacToeGameViewController.h
//  TicTacToe
//
//  Created by Justin Williams on 10/14/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTBoard.h"

@interface TicTacToeGameViewController : UIViewController<TTTGameDelegate>

- (id)initWithBoard:(TTTBoard*)game;

@end
