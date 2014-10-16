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
@property (nonatomic, strong) TTTGame* game;
@property (nonatomic, weak) TTTPlayer* activePlayer;
@property (nonatomic, strong) NSAttributedString* playerXAttributedString;
@property (nonatomic, strong) NSAttributedString* playerOAttributedString;
@end

@implementation TicTacToeGameViewController

- (id)initWithGame:(TTTGame*)game {
    self = [super init];
    if (self) {
        _game = game;
        _game.delegate = self;
        
        NSDictionary* playerXAttributes = @{ NSForegroundColorAttributeName : [UIColor redColor] };
        NSDictionary* playerOAttributes = @{ NSForegroundColorAttributeName : [UIColor greenColor] };
        
        _playerXAttributedString = [[NSAttributedString alloc] initWithString:@"X" attributes:playerXAttributes];
        _playerOAttributedString = [[NSAttributedString alloc] initWithString:@"O" attributes:playerOAttributes];
        
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self.game start];
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
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTTCollectionViewCell *cell = [self.ticTacToeCollectionView dequeueReusableCellWithReuseIdentifier:@"TTTCollectionViewCell" forIndexPath:indexPath];
    cell.ticTacToeMarker.attributedText = [self labelForPlayerAtIndexPath:indexPath];
    
    return cell;
    
}

- (NSAttributedString*)labelForPlayerAtIndexPath:(NSIndexPath*)indexPath {
    TTTPosition pos;
    pos.x = (int)indexPath.section;
    pos.y = (int)indexPath.row;
    TTTPlayer* player = [self.game playerAtPosition:pos];
    if (player && player.type == TTTPlayerTypeX) {
        return self.playerXAttributedString;
    } else if (player && player.type == TTTPlayerTypeO) {
        return self.playerOAttributedString;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Cell selected at x:%ld y:%ld", indexPath.section, indexPath.row);
    TTTPosition pos;
    pos.x = (int)indexPath.section;
    pos.y = (int)indexPath.row;
    [self.game makeMoveForPlayer:self.activePlayer atPosition:pos];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50, 50);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
