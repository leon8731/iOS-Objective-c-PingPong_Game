//
//  ViewController.h
//  3A517140_吳禮丞_期末專題
//
//  Created by E420_26 on 2020/6/9.
//  Copyright © 2020 E420_26. All rights reserved.
//

#import <UIKit/UIKit.h>

int X;
int Y;
int PlayerMove;
int ComputerScore;
int PlayerScore;
int WinScore;
int HighestScore;
int Pickrow;
BOOL Start;
BOOL UnlimitedMode;

@interface ViewController : UIViewController<UIPickerViewDataSource,
UIPickerViewDelegate>
{
    IBOutlet UIImageView *Ball;
    IBOutlet UIImageView *Player;
    IBOutlet UIImageView *Computer;
    
    IBOutlet UIImageView *BorderTop;
    IBOutlet UIImageView *BorderBottom;
    IBOutlet UIImageView *BorderLeft;
    IBOutlet UIImageView *BorderRight;
    
    IBOutlet UILabel *ComputerScoreLabel;
    IBOutlet UILabel *PlayerScoreLabel;
    
    IBOutlet UIImageView *GameOverView;
    IBOutlet UILabel *WinView;
    IBOutlet UIButton *RetryView;
    
    IBOutlet UITextField *TextBox;
    IBOutlet UIButton *Submit;
    IBOutlet UIPickerView *plurkPicker;
    IBOutlet UILabel *label;
    
    IBOutlet UILabel *HighestScoreView;
    
    NSArray *plurk;
    NSTimer *timer;
    NSTimer *playertimer;
    
    NSString *Scorepath;
    NSString *rContent;
    NSString *wContent;
    
    NSString *Winpath;
    NSString *rContentW;
    NSString *wContentW;
    
    NSString *Ballpath;
    NSString *rContentB;
    NSString *wContentB;
}

-(void)BallMethod;
-(void)ComputerMovement;
-(void)Collision;
-(void)PlayerMethod;
-(void)GameOver;
-(void)HighestScoreLoad;
-(IBAction)Sub:(id)sender;
-(IBAction)Unlimited:(id)sender;
@end

