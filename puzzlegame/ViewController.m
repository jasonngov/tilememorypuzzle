//
//  ViewController.m
//  puzzlegame
//
//  Created by Jason on 7/31/18.
//  Copyright © 2018 Jason Ngov. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioServices.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize levelLabel,button1, button2, button3, button4, button5, button6, button7, button8,button9,button10,button11,button12,button13,button14,button15,button16, button17, button18, button19, button20, button21, button22, button23, button24, button25, button26, button27, button28, button29, button30, button31, button32, button33, button34, button35, button36, startButton, timerLabel,  conditionLabel, resetButton, progressBar, scoreLabel, highScoreLabel, addUser;

NSArray* buttons; //preloaded array with list of buttons in game
NSMutableArray* userButtons; //stores user selection of tiles
NSArray* sortedRandomButtons; //stores and sorts randTag and position of random tile in NSArray
NSArray* sortedUserButtons; //sorts NSMutableArray* userButtons
NSString* levelNum; //converts int level into NSString to be displayed as a label on game view
NSString* stringScore;
NSString* highScoreNum = 0;
NSInteger* integerKey;
int level; //stores current level of the game
int buttonCount = 0; //compares  the size of sortedRandomButtons and determines when to call showResult method when button is pressed
int numOfTiles; //the number of tiles displayed in each leve1, increases by 1 after each level is complete
int currentRange; //the initial range of the position of the tiles, increase by 3 after each level is complete
int numTries = 0; //preset at 0, iterates by 1 after every wrong tile is pressed, will end game when numTries = 3
int score; // keeps track of current score and actively compares value to high score
int highScore; // displays and stores value of high score

- (void)viewDidLoad {
    [super viewDidLoad];
    //information for progress bar
    [progressBar setProgress: 1.0];
    [progressBar setTransform:CGAffineTransformMakeScale(1.0, 5.0)];
    progressBar.clipsToBounds = YES;
    progressBar.layer.cornerRadius = 8;
    progressTime = 1.0;
    progressIncrement = -.0125;
    [progressBar setHidden: NO];
    
    //formatting levellabel
    levelLabel.clipsToBounds = true;
    levelLabel.layer.cornerRadius = 8;
    
    //formatting scoreLabel and highScoreLabel
    scoreLabel.clipsToBounds = true;
    scoreLabel.layer.cornerRadius = 6;
    highScoreLabel.clipsToBounds = true;
    highScoreLabel.layer.cornerRadius = 6;
    
    //default score for score and high score in the beginning
    score = 0;
    scoreLabel.text = @"Score \n 0";
    highScoreLabel.text = @"High Score \n 0";
    
    //instantiates NSMutableArray to store user selection data (referenced in buttonPressed)
    userButtons = [[NSMutableArray alloc] initWithCapacity: 0];
    
    //timer data
    [timerLabel setHidden: YES];
    timerLabel.text = @"3";
    time = 3;
    increment = -1;
    
    //gives default values to numTiles and currentRange
    numOfTiles = 3;
    currentRange = 16;
    
    
    //fills NSArray* button with initinal button properties (referenced in
    buttons = [NSArray arrayWithObjects:button1, button2,button3,button4,button5,button6,button7,button8,button9,button10,button11,button12,button13,button14,button15,button16,button17, button18, button19, button20, button21, button22, button23, button24, button25, button26, button27, button28, button29, button30, button31, button32, button33, button34, button35, button36, nil];
    
    //disables buttons upon load
    [self disableButtons];
    
    //hide condition label upn load
    [conditionLabel setHidden: YES];
    
    //hides resetButton upon load
    resetButton.hidden = YES;
    
    //sets initial level
    level = 1;
    
    integerKey = [[NSUserDefaults standardUserDefaults]integerForKey:@"Highscore"];
    highScoreLabel.text = [@"High Score \n" stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)integerKey]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)userButtonPressed:(id)sender {
    [self resetButtonPressed:(resetButton)];
    integerKey = 0;
    highScoreLabel.text = [@"High Score \n" stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)integerKey]];
}

- (IBAction)buttonPressed:(id)sender {
    UIButton* btn = (UIButton*) (id)sender; //creates a button object for current button pressed
    UIColor* tintColor =  [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.0]; //sets tint color to invisible
    
    //converts current button tag to NSNumber to be filled into userButtons mutableArray
    NSNumber* tag = [NSNumber numberWithInt: [sender tag]]; //created to track user selection relative to the grid
    
    if(btn.selected == NO){
        [userButtons addObject: tag]; //adds position relative to grid to NSMutableArray
        if ([sortedRandomButtons containsObject:tag]) {
            buttonCount++;
            [btn setBackgroundColor: [UIColor colorWithRed:242./255. green:177./255. blue:121./255. alpha:1]]; // background color changed to orange
            btn.selected = YES;
            btn.tintColor = tintColor; //gets rid of tintColor default highlight
        } else {
            numTries++;
            [btn setBackgroundColor:[UIColor colorWithRed: 252./255. green:102./255. blue:105./255. alpha:1]]; //background color changed to red
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            [userButtons removeObject:tag];
            score -= 50; //decreases score if user presses wrong tile
            stringScore = [NSString stringWithFormat:@"%.02d", score]; //displays result of decreased score
            scoreLabel.text = [@"Score \n " stringByAppendingString: stringScore];
            if (numTries >= 3){
                [conditionLabel setHidden: NO];
               // [self revealCorrectTiles];
                [self disableButtons];
                [progressTimer invalidate];
            }
        }
    //compares the buttonCount to the number of random tiles
    if(buttonCount == (int)[sortedRandomButtons count]){
        [self performSelector: @selector(showResult) withObject:nil afterDelay: .35 ]; //calls showResult
        [self disableButtons];
    }
  }
}

//method used when user advances successfully passed each level, delays method calls on randomTiles and countdown
- (void) gamePlaying {
    [self resetGameBoard];
     [self performSelector: @selector(randomTiles) withObject:nil afterDelay: .35 ];
    //[self randomTiles];
    [self performSelector: @selector(countdown) withObject: nil afterDelay: .50];
    
}

- (IBAction)startButtonPressed:(id)sender {
    //hide conditionLabel
    [conditionLabel setHidden: YES];
    
    //unhides reset button, all functionalities enabled
    resetButton.hidden = NO;
    
    //hides startButton
    startButton.hidden = YES;
    startButton.enabled = false;
    
    [self resetGameBoard];
    [self randomTiles]; //randomizes tiles
    
    //countdown begins
    [self countdown];
    [self performSelector: @selector(countdownProgress) withObject:nil afterDelay: 3.0 ];
}

//methods for when startButton is pressed
    - (void) countdown {
        timer = [NSTimer scheduledTimerWithTimeInterval: 1 target: self selector: @selector(updateTimer) userInfo: nil repeats: YES];
    }

    - (void) updateTimer {
        time += increment;
        timerLabel.text = [NSString stringWithFormat:@"%d",time];
        if ([timerLabel.text isEqual: @"0"]){
            [timer invalidate];
            [self resetGameBoard];
            [self enableButtons];
        }
    }

//method to reset gameboard, change btn to default color and disables tap feature
- (void)resetGameBoard {
    for (UIButton* btn in buttons){
        [btn setBackgroundColor:[UIColor colorWithRed:238./255. green:228./255. blue:218./255. alpha:1]];
        btn.selected = NO;
    }
}

//method used by resetButtonPressed and advanceLevel
- (void) resetGame {
    [self resetGameBoard];

    //changes startButton to original color
    startButton.enabled = true;
    [startButton setBackgroundColor: [UIColor colorWithRed: 109./255. green: 216./255. blue: 152./255. alpha: 1]];
    
    //disable buttons
    [self disableButtons];
    
    //resets timer
    [timer invalidate];
    
    time = 3;
    timerLabel.text = @"3";
    
    //must change elements inside NSMutableArray of userButtons
    [userButtons removeAllObjects];
}

- (IBAction)resetButtonPressed:(id)sender {
    [self resetGame];
    
    //unhides startButton, hides resetButton
    startButton.hidden = NO;
    resetButton.hidden = YES;
    
    //resets level, and resets num of tiles
    levelLabel.text = @"Level 1";
    level = 1;
    numOfTiles = 3;
    currentRange = 16;
    
    //changes button count to 0
    buttonCount = 0;
    
    //conditionLabel hidden
    [conditionLabel setHidden: YES];
    
    //disable buttons
    [self disableButtons];
    
    //resets progress bar
    [self resetCountDownProgress];
    
    //resets numTries
    numTries = 0;
    
    //resets score
    score = 0;
    scoreLabel.text = @"Score \n 0";
}

//method that randomly selects tiles
- (void)randomTiles {
    UIColor* tintColor =  [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    NSMutableArray* randomButtons = [[NSMutableArray alloc] initWithCapacity:0]; //randomButtons initialized to remove poss. duplicates
    
    for (int i = 0; i < numOfTiles; i++){
       int rand = arc4random_uniform(currentRange) + 1;
        
        UIButton* btn = buttons[rand]; //creates btn object that contains random position of button on gameboard
        NSNumber* randTag = [NSNumber numberWithInteger: [btn tag]]; //stores tag of specific btn
        [randomButtons addObject: randTag]; //stores randTag into NSMutableArray

        [btn setBackgroundColor:[UIColor colorWithRed:242./255. green:177./255. blue:121./255. alpha:1]]; //changes background color to orange
        btn.selected = YES;
        btn.tintColor = tintColor;
    }
    
    //checks initially for duplicates, will decrease size if necessary
    int count = numOfTiles;
    for (int i = 0; i < numOfTiles; i++){
        for (int j = i + 1; j < count; j++){
            if (randomButtons[j] == randomButtons[i]){
                [randomButtons removeObjectAtIndex: (NSInteger)j]; //removes duplicated integer
                count = (int)[randomButtons count]; //sets size of NSMutableArray* to count, allows size flexibility for for-loop to loop to.
            }
        }
    }
    
    //checks again for duplicates
    //highly unlikely button will be duplicated for a third time.
    int secondCount = count;
    for (int i = 0; i < count; i++){
        for (int j = i + 1; j < secondCount; j++){
            if (randomButtons[j] == randomButtons[i]){
                [randomButtons removeObjectAtIndex: (NSInteger)j]; //removes duplicated integer
                secondCount = (int)[randomButtons count]; //sets size of NSMutableArray* to secondCount, allows size flexibility for for-loop to loop to.
            }
        }
    }
    
    //sorts temporary random NSMutableArray of buttons
    sortedRandomButtons = [randomButtons sortedArrayUsingComparator:^NSComparisonResult(NSNumber* n1, NSNumber* n2) {
        return [n1 compare:n2];
    }];
    

}
- (void) showResult {
    //sorts userButtons into ascending order
    sortedUserButtons = [userButtons sortedArrayUsingComparator:^NSComparisonResult(NSNumber* n1, NSNumber* n2) {
        return [n1 compare:n2];
    }];
    
    //compares the two sorted arrays
    if ([sortedRandomButtons isEqualToArray:sortedUserButtons]){ //condition checks to see if sorted NSArrays are equal
        level++; //increases level
        numOfTiles++; //increases the number of tiles randomly displayed
            
        //condition that rewards more points when user is passed level 10
        if (level > 15){
            score += 500;
        } else if (level > 10){
            score += 250;
        }
        else {
            score += 100;
        }
        stringScore = [NSString stringWithFormat:@"%.02d", score]; //converts current score into a string
        scoreLabel.text = [@"Score \n " stringByAppendingString: stringScore]; //displays score on Score Label

        //numTries is reset to 0
        numTries = 0;
        
        //ensures currentRange will never be greater than 34
        if (currentRange >= 34){
            currentRange = 35;
        } else {
            currentRange += 3;
        }
        
        //progressBar will slow when numOfTiles is greater than 10 (past Level 7)
        if (numOfTiles > 10){
            progressIncrement = -.01;
        } else if (numOfTiles > 15){    //occurs when user reaches Level 12
            progressIncrement = -.008;
        }
        
        //converts level to NSString and displays on game view
        levelNum = [NSString stringWithFormat:@"%d", level];
        [self advanceLevel];
        [self gamePlaying];
        [self resetCountDownProgress];
        [self performSelector: @selector(countdownProgress) withObject: nil afterDelay: 3.0];
        
    } else {
        [conditionLabel setHidden: NO];
        [conditionLabel setTextColor:[UIColor grayColor]]; //if patterns do not match, conditionLevel changes to gray
        [conditionLabel setText: @"Game Over."]; //conditionLevel displays "Game Over"
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        [self disableButtons];
        [self calculateHighScore];
    }
}

// void method to advanceLevel and display on the view user's currentLevel
- (void) advanceLevel {
    levelLabel.text = [@"Level " stringByAppendingString: levelNum];
    [self calculateHighScore];
    [self resetGame]; //game is reset
    [self disableButtons];
    buttonCount = 0;
}

//method enabling buttons
- (void) enableButtons {
    for (UIButton* btn in buttons){
        btn.enabled = YES;
    }
}

//method disabling buttons
- (void) disableButtons {
    //disables buttons upon load
    for (UIButton* btn in buttons){
        btn.enabled = NO;
    }
}


//calculate high score
- (void) calculateHighScore {
    highScore = (int)integerKey;
    if (score > highScore){
        highScore = score;
        stringScore = [NSString stringWithFormat:@"%.02d", highScore];
        highScoreLabel.text = [@"High Score \n" stringByAppendingString: stringScore];
    } else {
        stringScore = [NSString stringWithFormat:@"%.02d", highScore];
        highScoreLabel.text = [@"High Score \n" stringByAppendingString: stringScore];
    }
    NSInteger a = (NSInteger)highScore;
    [[NSUserDefaults standardUserDefaults]setInteger:a forKey:@"Highscore"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//method to reset progress bar
- (void) resetCountDownProgress {
    [progressTimer invalidate];
    [progressBar setProgress: 1.0 animated: NO];
    [progressBar setProgressTintColor:[UIColor colorWithRed:242./255. green:177./255. blue:121./255. alpha:1]];
    progressTime = 1.0;
    progressIncrement = -0.0125;
    
}
- (void) countdownProgress {
    progressTimer = [NSTimer scheduledTimerWithTimeInterval:.10 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}
- (void) updateProgress {
    progressTime += (progressIncrement);
    [progressBar setProgress: progressTime animated:YES];
    
    //condition to check when progress bar is .350 or lower, will change tint color from orange to red
    if ([progressBar progress] <= .350){
        [progressBar setProgressTintColor: [UIColor colorWithRed: 252./255. green:102./255. blue:105./255. alpha:1]];
    }
    
    //invalidates timer when the progress bar reaches .000
    if ([progressBar progress] == .000){
        [progressTimer invalidate];
    }
    
    //ends the game and disables grid when timer has elasped and pattern not matched
    if ([progressBar progress] == .000 && buttonCount != (int)[sortedRandomButtons count]){
        [progressTimer invalidate];
        [conditionLabel setHidden:NO];
        [self disableButtons];
    }
}
/*
- (void) revealCorrectTiles {
    for (NSNumber* num in sortedRandomButtons){
        int i = (int)num;
        UIButton* btn = buttons[i];
        [btn setBackgroundColor:[UIColor colorWithRed:109./255. green:216./255. blue:152./255. alpha:1]];
    }
 */


@end


