//
//  TicTacToeGameViewController.m
//  TicTacToe
//
//  Created by Justin Williams on 10/14/14.
//  Copyright (c) 2014 Justin Williams. All rights reserved.
//

#import "TicTacToeGameViewController.h"
#import "TTTCollectionViewCell.h"
#import "TTTPlayer.h"

@interface TicTacToeGameViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *ticTacToeCollectionView;
@property (nonatomic, strong) TTTBoard* board;
@property (nonatomic, weak) TTTPlayer* activePlayer;
@property (nonatomic, strong) NSAttributedString* playerXAttributedString;
@property (nonatomic, strong) NSAttributedString* playerOAttributedString;
@property (weak, nonatomic) IBOutlet UILabel *player1Label;
@property (weak, nonatomic) IBOutlet UILabel *player2Label;
@property (weak, nonatomic) IBOutlet UILabel *winnerLabel;
@property (weak, nonatomic) IBOutlet UILabel *player2SymbolLabel;
@property (weak, nonatomic) IBOutlet UILabel *player1SymbolLabel;
- (IBAction)restartButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *restartPlayer1;
@property (weak, nonatomic) IBOutlet UIButton *restartPlayer2;
@end

@implementation TicTacToeGameViewController

- (id)initWithBoard:(TTTBoard*)board {
    self = [super init];
    if (self) {
        _board = board;
        _board.delegate = self;
        
        NSDictionary* playerXAttributes = @{ NSForegroundColorAttributeName : [UIColor redColor] };
        NSDictionary* playerOAttributes = @{ NSForegroundColorAttributeName : [UIColor greenColor] };
        
        _playerXAttributedString = [[NSAttributedString alloc] initWithString:@"X" attributes:playerXAttributes];
        _playerOAttributedString = [[NSAttributedString alloc] initWithString:@"O" attributes:playerOAttributes];
        
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [self showFirstMovePrompt];
    
}

- (void)showFirstMovePrompt {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"First Move" message:@"Who Will Make The First Move" delegate:self cancelButtonTitle:nil otherButtonTitles:self.board.player1.playerName, self.board.player2.playerName, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.board startGameFirstPlayer:self.board.player1];
    } else if (buttonIndex == 1) {
        [self.board startGameFirstPlayer:self.board.player2];
    }
    [self.ticTacToeCollectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.ticTacToeCollectionView.delegate = self;
    self.ticTacToeCollectionView.dataSource = self;
    self.ticTacToeCollectionView.allowsSelection = NO;
    
    self.player1Label.text = self.board.player1.playerName;
    self.player2Label.text = self.board.player2.playerName;
    
    [self.ticTacToeCollectionView registerNib:[UINib nibWithNibName:@"TTTCollectionViewCell" bundle:[NSBundle mainBundle]]
        forCellWithReuseIdentifier:@"TTTCollectionViewCell"];
    
    self.player1SymbolLabel.attributedText = self.board.player1.type == TTTPlayerTypeX ? self.playerXAttributedString : self.playerOAttributedString;
    
    self.player2SymbolLabel.attributedText = self.board.player2.type == TTTPlayerTypeX ? self.playerXAttributedString : self.playerOAttributedString;
    
//    
//    NSMutableAttributedString* player1AttributedString = [[NSMutableAttributedString alloc] initWithString:self.board.player1.playerName attributes:nil];
//    [player1AttributedString appendAttributedString:spaceString];
//    [player1AttributedString appendAttributedString:self.playerXAttributedString];
//    
//    NSMutableAttributedString* player2AttributedString = [[NSMutableAttributedString alloc] initWithString:self.board.player2.playerName attributes:nil];
//    [player2AttributedString appendAttributedString:self.playerOAttributedString];
////    [player2AttributedString appendAttributedString:@""];
//    
//    [self.restartPlayer1 setAttributedTitle:player1AttributedString forState:UIControlStateNormal];
////    self.restartPlayer1.titleLabel.attributedText = player1AttributedString;
//    self.restartPlayer2.titleLabel.attributedText = player2AttributedString;

}

- (void)allowUserInputForPlayer:(TTTPlayer *)player {
    self.ticTacToeCollectionView.allowsSelection = YES;
    self.activePlayer = player;
}

- (void)moveSuccessfulForPlayer:(TTTPlayer *)player atPosition:(TTTPosition)pos {
    [self.ticTacToeCollectionView reloadData];
}

- (void)gameWonByPlayer:(TTTPlayer *)player atPositions:(NSArray *)boardPositions {
    if (!player) {
        self.winnerLabel.text = @"Draw";
    } else {
        self.winnerLabel.text = [NSString stringWithFormat:@"%@ wins!", player.playerName];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return BOARD_SIZE;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTTCollectionViewCell *cell = [self.ticTacToeCollectionView dequeueReusableCellWithReuseIdentifier:@"TTTCollectionViewCell" forIndexPath:indexPath];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.ticTacToeMarker.attributedText = [self labelForPlayerAtIndexPath:indexPath];
    
    return cell;
    
}

- (NSAttributedString*)labelForPlayerAtIndexPath:(NSIndexPath*)indexPath {
    TTTPosition pos;
    pos.x = (int)indexPath.section;
    pos.y = (int)indexPath.row;
    TTTPlayer* player = [self.board playerAtTTTPosition:pos];
    if (player && player.type == TTTPlayerTypeX) {
        return self.playerXAttributedString;
    } else if (player && player.type == TTTPlayerTypeO) {
        return self.playerOAttributedString;
    }
    return [[NSAttributedString alloc] initWithString:@"" attributes:nil];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return BOARD_SIZE;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Cell selected at x:%ld y:%ld", indexPath.section, indexPath.row);
    TTTPosition pos;
    pos.x = (int)indexPath.section;
    pos.y = (int)indexPath.row;
    [self.board markBoardAtPosition:intFromTTTPosition(pos)];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(60, 45);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 50, 0, 50);
}

- (IBAction)restartButtonPressed:(id)sender {
    self.winnerLabel.text = nil;
    [self showFirstMovePrompt];
}
@end
