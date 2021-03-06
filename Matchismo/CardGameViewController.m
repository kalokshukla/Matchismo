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
#import "GameResult.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;
@property (weak, nonatomic) IBOutlet UISwitch *mode;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) GameResult *gameResult;
@end

@implementation CardGameViewController

-(GameResult *)gameResult{
    if (!_gameResult) {
        _gameResult=[[GameResult alloc]init];
    }
    return _gameResult;
}
- (IBAction)dealButtonPressed: (id)sender {
    self.game = nil;
    self.gameResult=nil;

    self.flipCount=0;
    self.mode.enabled=YES;
    [self updateUI];
    if ([self.mode isOn]) {
        self.instructionsLabel.text=@"Toggle the Switch for 2 Card Matching mode.";
    }
    else {
        self.instructionsLabel.text=@"Toggle the Switch for 3 Card Matching mode.";
    }
    
    
    
    
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
    UIImage *cardBackImage = [UIImage imageNamed:@"cardback.png"];
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        if (card.isFaceUp) {
            [cardButton setTitle:card.contents forState:UIControlStateNormal];
            //Need to set image to nil in order to display title properly
            [cardButton setImage:nil forState:UIControlStateNormal];
        } else { //If card is face down, display image
            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
            [cardButton setTitle:nil forState:UIControlStateNormal];
        }

        cardButton.selected=card.isFaceUp;
        cardButton.enabled=!card.isUnplayable;
        cardButton.alpha=card.isUnplayable?0.3:1.0;
    }
    self.scoreLabel.text= [NSString stringWithFormat:@"Score: %d", self.game.score];
    NSString *instructionString = self.game.instructions;
    self.instructionsLabel.text= instructionString;
    
}

- (IBAction)flipCard:(UIButton *)sender {
    if ([self.mode isOn]) {
        [self.game flipCardAtIndexV2:[self.cardButtons indexOfObject:sender]];
        self.mode.enabled=NO;
    }
    else{
        [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
        self.mode.enabled=NO;
    }
    
    self.flipCount++;
    [self updateUI];
    self.gameResult.score=self.game.score;
}

-(void) setFlipCount:(int)flipCount {
    
    _flipCount=flipCount;
    self.flipsLabel.text=[NSString stringWithFormat:@"Flips: %d", self.flipCount ];
}

@end
