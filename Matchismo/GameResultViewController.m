//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Alok K. Shukla on 20/02/13.
//  Copyright (c) 2013 Alok Kumar Shukla. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;
@property (weak, nonatomic) IBOutlet UIButton *dateSort;
@property (weak, nonatomic) IBOutlet UIButton *durationSort;
@property (weak, nonatomic) IBOutlet UIButton *scoreSort;

@end

@implementation GameResultViewController

- (void) updateUI{
    
    NSString *displayText= @"";
    NSMutableArray *modifiedResults = [[GameResult allGameResults] mutableCopy];
    if (self.dateSort.isSelected) {
        [modifiedResults sortUsingSelector:@selector(compareDates:result:)];
    } else if (self.durationSort.isSelected){
        [modifiedResults sortUsingSelector:@selector(compareDurations:result:)];
    } else if (self.scoreSort.isSelected){
        [modifiedResults sortUsingSelector:@selector(compareScores:result:)];
    }
    
    for (GameResult *result in modifiedResults) {
        displayText=[displayText stringByAppendingFormat:@"Score: %d (%@, %0g)\n", result.score, result.end, round(result.duration)];
    }
    //for (GameResult *result in modifiedResults){
    
    //}
    self.display.text=displayText;
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void) setup{
    // something that cant wat till viewDidLoad()
}

- (void) awakeFromNib {
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}



@end
