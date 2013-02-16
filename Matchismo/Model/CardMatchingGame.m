//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Alok K. Shukla on 07/02/13.
//  Copyright (c) 2013 Alok Kumar Shukla. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;
@end

@implementation CardMatchingGame

- (NSMutableArray *) cards{
    if (!_cards)    _cards=[[NSMutableArray alloc] init];
    return _cards;
}
- (id) initWithCardCount:(NSUInteger) cardCount usingDeck:(Deck *)deck{
    self = [super init];
    
    if (self) {
        for (int i=0;i<cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self=nil;
            }else {
                self.cards[i]=card;
            }
        }
    }
    return self;
    
}

- (Card *) cardAtIndex: (NSUInteger) index{
    return (index < [self.cards count] )? self.cards[index]:nil;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

- (void) flipCardAtIndex:(NSUInteger) index{
    Card *card = [self cardAtIndex:index];
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore= [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable=YES;
                        card.unplayable=YES;
                        self.score+=matchScore*MATCH_BONUS;
                        if (matchScore==1) {
                            self.instructions=[NSString stringWithFormat:@"Matched %@ and %@ for 4 points.",card.contents,otherCard.contents];
                        }else if (matchScore==4){
                            self.instructions=[NSString stringWithFormat:@"Matched %@ and %@ for 16 points.",card.contents,otherCard.contents];
                        }
                    
                    }else{
                        otherCard.faceUp=NO;
                        self.score-=MISMATCH_PENALTY;
                        self.instructions=[NSString stringWithFormat:@"%@ and %@ don't match! 2 points penalty!",card.contents,otherCard.contents];
                    }
                    break;
                }
                self.instructions=[NSString stringWithFormat:@"Flipped a %@.", card.contents];
            }
            
            self.score-=FLIP_COST;
        }
        card.faceUp=!card.isFaceUp;
    }
}

- (void) flipCardAtIndexV2:(NSUInteger)index {
    
    Card *card = [self cardAtIndex:index];
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    for (Card *thirdCard in self.cards) {
                        if (thirdCard.isFaceUp && !thirdCard.isUnplayable && ![thirdCard.contents isEqualToString:otherCard.contents]) {
                            int matchScore=[card match:@[otherCard,thirdCard]];
                            if (matchScore) {
                                self.score+=matchScore*MATCH_BONUS;
                                card.unplayable=YES;
                                otherCard.unplayable=YES;
                                thirdCard.unplayable=YES;
                                if (matchScore==16) {
                                    self.instructions=[NSString stringWithFormat:@"Matched %@, %@ and %@ for 16 points.",card.contents,otherCard.contents,thirdCard.contents];
                                }else if (matchScore==8){
                                    self.instructions=[NSString stringWithFormat:@"Matched %@, %@ and %@ for 8 points.",card.contents,otherCard.contents,thirdCard.contents];
                                }
                                else if (matchScore==4){
                                    self.instructions=[NSString stringWithFormat:@"Matched %@, %@ and %@ for 8 points.",card.contents,otherCard.contents,thirdCard.contents];
                                    
                                }
                                else if (matchScore==1){
                                    self.instructions=[NSString stringWithFormat:@"Matched %@, %@ and %@ for a point.",card.contents,otherCard.contents,thirdCard.contents];
                                    
                                }
                            }
                            else{
                                otherCard.faceUp=NO;
                                thirdCard.faceUp=NO;
                                self.score-=MISMATCH_PENALTY;
                                self.instructions=[NSString stringWithFormat:@"%@, %@ and %@ don't match! 2 points penalty!",card.contents,otherCard.contents, thirdCard.contents];
                            }
                            break;
                        }
                        else{
                            self.instructions=[NSString stringWithFormat:@"Flipped a %@ and a %@.", card.contents,otherCard.contents];
                        }
                    }
                                        break;
                    }
                    else{
                        self.instructions=[NSString stringWithFormat:@"Flipped a %@.", card.contents];
                    }
                }
            self.score-=FLIP_COST;
                
            }
        card.faceUp=!card.isFaceUp;
        }
        
    }
    

@end
