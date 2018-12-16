//
//  ViewController.h
//  puzzlegame
//
//  Created by Jason on 7/31/18.
//  Copyright © 2018 Jason Ngov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    //timer constraints
    NSTimer *timer;
    NSTimer* progressTimer;
    float progressTime;
    float progressIncrement;
    int time;
    int increment;
    BOOL isRunning;
}
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;
@property (weak, nonatomic) IBOutlet UIButton *button10;
@property (weak, nonatomic) IBOutlet UIButton *button11;
@property (weak, nonatomic) IBOutlet UIButton *button12;
@property (weak, nonatomic) IBOutlet UIButton *button13;
@property (weak, nonatomic) IBOutlet UIButton *button14;
@property (weak, nonatomic) IBOutlet UIButton *button15;
@property (weak, nonatomic) IBOutlet UIButton *button16;
@property (weak, nonatomic) IBOutlet UIButton *button17;
@property (weak, nonatomic) IBOutlet UIButton *button18;
@property (weak, nonatomic) IBOutlet UIButton *button19;
@property (weak, nonatomic) IBOutlet UIButton *button20;
@property (weak, nonatomic) IBOutlet UIButton *button21;
@property (weak, nonatomic) IBOutlet UIButton *button22;
@property (weak, nonatomic) IBOutlet UIButton *button23;
@property (weak, nonatomic) IBOutlet UIButton *button24;
@property (weak, nonatomic) IBOutlet UIButton *button25;
@property (weak, nonatomic) IBOutlet UIButton *button26;
@property (weak, nonatomic) IBOutlet UIButton *button27;
@property (weak, nonatomic) IBOutlet UIButton *button28;
@property (weak, nonatomic) IBOutlet UIButton *button29;
@property (weak, nonatomic) IBOutlet UIButton *button30;
@property (weak, nonatomic) IBOutlet UIButton *button31;
@property (weak, nonatomic) IBOutlet UIButton *button32;
@property (weak, nonatomic) IBOutlet UIButton *button33;
@property (weak, nonatomic) IBOutlet UIButton *button34;
@property (weak, nonatomic) IBOutlet UIButton *button35;
@property (weak, nonatomic) IBOutlet UIButton *button36;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UITextView *scoreLabel;
@property (weak, nonatomic) IBOutlet UITextView *highScoreLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UIButton *addUser;


- (IBAction)userButtonPressed:(id)sender;
- (IBAction)buttonPressed:(id)sender;
- (IBAction)startButtonPressed:(id)sender;
- (IBAction)resetButtonPressed:(id)sender;
- (void)updateTimer;
- (void)countdown;
- (void)randomTiles;


@end

