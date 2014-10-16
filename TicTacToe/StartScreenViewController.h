//
//  StartScreenViewController.h
//  TicTacToe
//
//  Created by Justin Williams on 10/14/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartScreenViewController : UIViewController
- (IBAction)startGameButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *player1TextField;
@property (weak, nonatomic) IBOutlet UITextField *player2TextField;
@end
