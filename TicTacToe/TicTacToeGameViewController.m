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

@interface TicTacToeGameViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *ticTacToeCollectionView;
//@property (nonatomic, strong) TTTGame* game;
@property (nonatomic, strong) TTTBoard* board;
@property (nonatomic, weak) TTTPlayer* activePlayer;
@property (nonatomic, strong) NSAttributedString* playerXAttributedString;
@property (nonatomic, strong) NSAttributedString* playerOAttributedString;
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
    
    [self.board startGame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.ticTacToeCollectionView.delegate = self;
    self.ticTacToeCollectionView.dataSource = self;
    self.ticTacToeCollectionView.allowsSelection = NO;
    
    [self.ticTacToeCollectionView registerNib:[UINib nibWithNibName:@"TTTCollectionViewCell" bundle:[NSBundle mainBundle]]
        forCellWithReuseIdentifier:@"TTTCollectionViewCell"];
}

- (void)allowUserInputForPlayer:(TTTPlayer *)player {
    self.ticTacToeCollectionView.allowsSelection = YES;
    self.activePlayer = player;
}

- (void)moveSuccessfulForPlayer:(TTTPlayer *)player atPosition:(TTTPosition)pos {
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:pos.y inSection:pos.x];
    NSArray* array = @[indexPath];
//    TTTCollectionViewCell *cell = [self.ticTacToeCollectionView dequeueReusableCellWithReuseIdentifier:@"TTTCollectionViewCell" forIndexPath:indexPath];
//    cell.ticTacToeMarker.attributedText = [self labelForPlayerAtIndexPath:indexPath];
    [self.ticTacToeCollectionView reloadItemsAtIndexPaths:array];
//    [self.board queryNextMove];
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
    return nil;
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
    return CGSizeMake(50, 50);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
