//
//  TicTacToeTests.m
//  TicTacToeTests
//
//  Created by Justin Williams on 10/14/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TTTPlayer.h"
#import "TTTExpertPlayer.h"
#import "TTTBoard.h"

@interface TicTacToeTests : XCTestCase
@property (nonatomic, strong) TTTPlayer* playerUser;
@property (nonatomic, strong) TTTExpertPlayer* playerMinimax;
@property (nonatomic, strong) TTTExpertPlayer* playerNaive;
@end

@implementation TicTacToeTests

- (void)setUp {
    [super setUp];
    self.playerUser = [[TTTPlayer alloc] initWithName:@"User" playerType:TTTPlayerTypeX];
    self.playerMinimax = [[TTTExpertPlayer alloc] initWithName:@"MiniMax" playerType:TTTPlayerTypeO strategy:TTTSTrategyTypeMiniMax];
    self.playerNaive = [[TTTExpertPlayer alloc] initWithName:@"Naive" playerType:TTTPlayerTypeX strategy:TTTStrategyTypeNaive];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBlockWin {
    TTTBoard* board = [[TTTBoard alloc] initGameWithPlayer1:self.playerUser player2:self.playerMinimax];
    board.activePlayer = self.playerUser;
    // X
    [board markBoardNoOpAtPosition:1];
    // O
    [board markBoardNoOpAtPosition:0];
    // X
    [board markBoardNoOpAtPosition:4];
    //
    // O X -
    // - X -
    // - - -
    //
    int pos = [self.playerMinimax makeNextMoveOnBoard:board];
    XCTAssertTrue(pos == 7, @"AI should block X winning move");
}

- (void)testBlockWinAndGetWin {
    TTTBoard* board = [[TTTBoard alloc] initGameWithPlayer1:self.playerUser player2:self.playerMinimax];
    board.activePlayer = self.playerUser;
    // X
    [board markBoardNoOpAtPosition:0];
    // O
    [board markBoardNoOpAtPosition:4];
    // X
    [board markBoardNoOpAtPosition:6];
    //
    // X - -
    // - O -
    // X - -
    //
    int pos = [self.playerMinimax makeNextMoveOnBoard:board];
    [board markBoardNoOpAtPosition:pos];
    XCTAssertTrue(pos == 3, @"AI should block X winning move");
    
    // X
    [board markBoardNoOpAtPosition:2];
    
    //
    // X - X
    // O O -
    // X - -
    //
    // O should seek win
    [board markBoardNoOpAtPosition:[self.playerMinimax makeNextMoveOnBoard:board]];
    XCTAssertTrue(self.playerMinimax == board.winningPlayer, @"AI should choose winning move");
}

- (void)testPerformanceMinimaxAI {
    TTTBoard* board = [[TTTBoard alloc] initGameWithPlayer1:self.playerNaive player2:self.playerMinimax];
    board.activePlayer = self.playerMinimax;
    __weak TicTacToeTests* weakSelf = self;
    [self measureBlock:^{
        [weakSelf.playerMinimax makeNextMoveOnBoard:board];
    }];
}

- (void)testPerformanceNaiveAI {
    TTTBoard* board = [[TTTBoard alloc] initGameWithPlayer1:self.playerNaive player2:self.playerMinimax];
    board.activePlayer = self.playerNaive;
    __weak TicTacToeTests* weakSelf = self;
    [self measureBlock:^{
        [weakSelf.playerNaive makeNextMoveOnBoard:board];
    }];
}


@end
