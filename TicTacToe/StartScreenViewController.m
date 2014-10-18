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
#import "TTTBoard.h"

@interface StartScreenViewController ()

@end

@implementation StartScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startGameButtonPressed:(id)sender {
    TTTPlayer* player1 = [[TTTPlayer alloc] initWithName:self.player1TextField.text playerType:TTTPlayerTypeX];
    TTTPlayer* player2 = [[TTTPlayer alloc] initWithName:self.player2TextField.text playerType:TTTPlayerTypeO];
    TTTBoard* board = [[TTTBoard alloc] initGameWithPlayer1:player1 player2:player2];
    TicTacToeGameViewController* gameVC = [[TicTacToeGameViewController alloc] initWithBoard:board];
    
    [self.navigationController pushViewController:gameVC animated:YES];
}
@end
