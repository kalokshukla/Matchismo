//
//  PlayingCard.m
//  Matchismo
//
//  Created by Alok K. Shukla on 07/02/13.
//  Copyright (c) 2013 Alok Kumar Shukla. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int) match:(NSArray *)otherCards{
    int score=0;
    if (otherCards.count==1) {
        id otherCard = [otherCards lastObject];
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherPlayingCard = (PlayingCard *) otherCard;
            if ([otherPlayingCard.suit isEqualToString:self.suit]) {
                score=1;
            }else if (otherPlayingCard.rank== self.rank ){
                score=4;
            }
        }
        
    }
    else if (otherCards.count == 2) {
        PlayingCard *secondCard = [otherCards objectAtIndex:0];
        PlayingCard *thirdCard = [otherCards objectAtIndex:1];
        if (self.rank == secondCard.rank && self.rank==thirdCard.rank) {
            score=16;
        }
        else if (self.rank == secondCard.rank||self.rank==thirdCard.rank||secondCard.rank==thirdCard.rank){
            score=8;
        }
        else if([self.suit isEqualToString:secondCard.suit]&&[self.suit isEqualToString:thirdCard.suit]){
            score=4;
        }
        else if([self.suit isEqualToString:secondCard.suit]||[self.suit isEqualToString:thirdCard.suit]||[secondCard.suit isEqualToString:thirdCard.suit]){
            score=1;
        }
    }
    return score;
}

- (NSString *)contents{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (void)setSuit:(NSString *)suit
{
    if ([@[@"♥",@"♦",@"♠",@"♣"] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}
+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [self rankStrings].count-1; }
@end
