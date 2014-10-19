//
//  StartScreenViewController.m
//  TicTacToe
//
//  Created by Justin Williams on 10/14/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import "StartScreenViewController.h"
#import "TicTacToeGameViewController.h"
#import "TTTPlayer.h"
#import "TTTExpertPlayer.h"
#import "TTTBoard.h"

@interface StartScreenViewController () <UITextFieldDelegate>

@end

@implementation StartScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.player1TextField.delegate = self;
    self.player2TextField.delegate = self;
}

- (IBAction)startGameButtonPressed:(UIButton*)sender {
    
    TTTPlayer* player1 = [[TTTPlayer alloc] initWithName:self.player1TextField.text playerType:TTTPlayerTypeX];
    TTTPlayer* player2;
    
    if (sender.tag == 0) {
        player2 = [[TTTPlayer alloc] initWithName:self.player2TextField.text playerType:TTTPlayerTypeO];
    } else if (sender.tag == 1) {
        player2 = [[TTTExpertPlayer alloc] initWithName:self.player2TextField.text playerType:TTTPlayerTypeO strategy:TTTSTrategyTypeMiniMax];
    }
    
    TTTBoard* board = [[TTTBoard alloc] initGameWithPlayer1:player1 player2:player2];
    TicTacToeGameViewController* gameVC = [[TicTacToeGameViewController alloc] initWithBoard:board];
    
    [self.navigationController pushViewController:gameVC animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.player1TextField) {
        [self.player2TextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

@end
