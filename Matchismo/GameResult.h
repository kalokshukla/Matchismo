//
//  GameResult.h
//  Matchismo
//
//  Created by Alok K. Shukla on 20/02/13.
//  Copyright (c) 2013 Alok Kumar Shukla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

@property (nonatomic, readonly) NSDate *start;
@property (nonatomic, readonly) NSDate *end;
@property (nonatomic, readonly) NSTimeInterval duration;
@property (nonatomic) int score;

+ (NSArray *)allGameResults;
- (NSComparisonResult) compareScores:(GameResult *)game;
- (NSComparisonResult) compareDurations:(GameResult *)game;
- (NSComparisonResult) compareDates:(GameResult *)game;


@end
