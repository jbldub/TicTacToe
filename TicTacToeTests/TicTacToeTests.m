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
@property (nonatomic, strong) TTTPlayer* player1;
@property (nonatomic, strong) TTTExpertPlayer* player2;
@end

@implementation TicTacToeTests

- (void)setUp {
    [super setUp];
    self.player1 = [[TTTPlayer alloc] initWithName:@"Player 1 Test" playerType:TTTPlayerTypeX];
    self.player2 = [[TTTExpertPlayer alloc] initWithName:@"Player 2 Test" playerType:TTTPlayerTypeO strategy:TTTSTrategyTypeMiniMax];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBlockWin {
    TTTBoard* board = [[TTTBoard alloc] initGameWithPlayer1:self.player1 player2:self.player2];
    board.activePlayer = self.player1;
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
    int pos = [self.player2 makeNextMoveOnBoard:board];
    XCTAssertTrue(pos == 7, @"AI should block X winning move");
}

- (void)testBlockWinAndGetWin {
    TTTBoard* board = [[TTTBoard alloc] initGameWithPlayer1:self.player1 player2:self.player2];
    board.activePlayer = self.player1;
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
    int pos = [self.player2 makeNextMoveOnBoard:board];
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
    [board markBoardNoOpAtPosition:[self.player2 makeNextMoveOnBoard:board]];
    XCTAssertTrue(self.player2 == board.winningPlayer, @"AI should choose winning move");
}

- (void)testPerformanceAI {
    // This is an example of a performance test case.
    TTTBoard* board = [[TTTBoard alloc] initGameWithPlayer1:self.player1 player2:self.player2];
    board.activePlayer = self.player2;
    [self measureBlock:^{
        int pos = [self.player2 makeNextMoveOnBoard:board];
        [board markBoardNoOpAtPosition:pos];
    }];
}


@end
