//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Alok K. Shukla on 07/02/13.
//  Copyright (c) 2013 Alok Kumar Shukla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
@interface CardMatchingGame : NSObject
- (id) initWithCardCount:(NSUInteger) cardCount
               usingDeck:(Deck *)deck;

- (void) flipCardAtIndex:(NSUInteger) index;
- (void) flipCardAtIndexV2:(NSUInteger)index;

- (Card *) cardAtIndex: (NSUInteger) index;

@property (nonatomic, readonly) int score;
@property (nonatomic, strong) NSString *instructions;
@end
