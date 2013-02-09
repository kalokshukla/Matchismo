//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Alok K. Shukla on 07/02/13.
//  Copyright (c) 2013 Alok Kumar Shukla. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISwitch *modeSwitch;
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation CardGameViewController
- (IBAction)dealButtonPressed:(id)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[PlayingCardDeck alloc] init]];

    self.flipCount=0;
    [self updateUI];
    self.instructionsLabel.text=@"Matchismo";
    
    
}


-(CardMatchingGame *)game{
    if (!_game) {
        _game=[[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                usingDeck:[[PlayingCardDeck alloc] init]];
    }
    return _game;
}
- (void)setCardButtons:(NSArray *)cardButtons   {
    _cardButtons=cardButtons;
    [self updateUI];
}


- (void) updateUI{
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected=card.isFaceUp;
        cardButton.enabled=!card.isUnplayable;
        cardButton.alpha=card.isUnplayable?0.3:1.0;
    }
    self.scoreLabel.text= [NSString stringWithFormat:@"Score: %d", self.game.score];
    NSString *instructionString = self.game.instructions;
    self.instructionsLabel.text= instructionString;
    
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

-(void) setFlipCount:(int)flipCount {
    
    _flipCount=flipCount;
    self.flipsLabel.text=[NSString stringWithFormat:@"Flips: %d", self.flipCount ];
}

@end
