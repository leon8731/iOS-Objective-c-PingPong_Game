//
//  ViewController.m
//  3A517140_吳禮丞_期末專題
//
//  Created by E420_26 on 2020/6/9.
//  Copyright © 2020 E420_26. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    Ball.hidden = YES;
    Player.hidden = NO;
    Computer.hidden = NO;
    Start = YES;
    GameOverView.hidden = YES;
    WinView.hidden = YES;
    RetryView.hidden = YES;
    
    ComputerScore = 0;
    PlayerScore = 0;
    
    plurk = [[NSArray alloc] initWithObjects:@"預設",@"美國", @"台灣", @"巴西", @"韓國", @"德國", nil];
    
    plurkPicker.dataSource = self;
    
    plurkPicker.delegate = self;
    
    Scorepath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ScoreFile"];
    
    Winpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/WinFile"];
    
    Ballpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/BallFile"];
    
    rContent = [NSString stringWithContentsOfFile: Scorepath encoding:NSUTF8StringEncoding error: NULL];
    
    rContentW = [NSString stringWithContentsOfFile: Winpath encoding:NSUTF8StringEncoding error: NULL];
    
    rContentB = [NSString stringWithContentsOfFile: Ballpath encoding:NSUTF8StringEncoding error: NULL];
    
    WinScore = [rContentW intValue];
    Pickrow = [rContentB intValue];
    
    //NSString *wContent = [NSString stringWithFormat:@"1"];
    //[wContent writeToFile: Scorepath atomically: YES encoding: NSUTF8StringEncoding error: NULL];
    
    HighestScoreView.text = [NSString stringWithFormat:@"%@",rContent];
    
    [super viewDidLoad];
}

- (IBAction)Sub:(id)sender{
    WinScore = [TextBox.text intValue];

    
    wContentW = [NSString stringWithFormat:@"%d",WinScore];

    [wContentW writeToFile: Winpath atomically: YES encoding: NSUTF8StringEncoding error: NULL];
    
    wContentB = [NSString stringWithFormat:@"%d",Pickrow];

    [wContentB writeToFile: Ballpath atomically: YES encoding: NSUTF8StringEncoding error: NULL];
    
    NSLog(@"設定勝利分數: %d 球的樣式: %d", WinScore, Pickrow);
}

- (IBAction)Unlimited:(id)sender{
    UnlimitedMode = YES;
}

- (void)BallMethod{
    
    if (Pickrow == 1) {
        Ball.image = [UIImage imageNamed:@"America.png"];
    }
    else if (Pickrow == 2) {
        Ball.image = [UIImage imageNamed:@"Taiwan.png"];
    }
    else if (Pickrow == 3) {
        Ball.image = [UIImage imageNamed:@"Brazil.png"];
    }
    else if (Pickrow == 4) {
        Ball.image = [UIImage imageNamed:@"Korea.png"];
    }
    else if (Pickrow == 5) {
        Ball.image = [UIImage imageNamed:@"Germany.png"];
    }
    else {
        Ball.image = [UIImage imageNamed:@"Ball.png"];
    }
    
    Ball.center = CGPointMake(Ball.center.x + X, Ball.center.y + Y);
    
    if (Ball.center.x < 24) {
        X = 0 - X;
    }
    
    if (Ball.center.x > 390) {
        X = 0 - X;
    }
    
    [self ComputerMovement];
    [self Collision];
    
    if (CGRectIntersectsRect(Ball.frame, BorderTop.frame)) {
        Ball.center = CGPointMake(191, 432);
        PlayerScore = PlayerScore + 1;
        PlayerScoreLabel.text = [NSString stringWithFormat:@"%i",PlayerScore];
    }
    
    if (CGRectIntersectsRect(Ball.frame, BorderBottom.frame)) {
        Ball.center = CGPointMake(191, 432);
        ComputerScore = ComputerScore + 1;
        ComputerScoreLabel.text = [NSString stringWithFormat:@"%i",ComputerScore];
    }
    
    if(WinScore < 1){
        WinScore = 5;
    }
        
    if (UnlimitedMode == YES) {
        if (ComputerScore == 5) {
            [self GameOver];
        }
    }else{
        
        if ((ComputerScore == WinScore) || (PlayerScore == WinScore)) {
            [self GameOver];
        }
        
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (Start == YES) {
        Start = NO;
        Ball.hidden = NO;
        Player.hidden = NO;
        Computer.hidden = NO;
        GameOverView.hidden = YES;
        WinView.hidden = YES;
        RetryView.hidden = YES;
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(BallMethod) userInfo:nil repeats:YES];
        
        playertimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(PlayerMethod) userInfo:nil repeats:YES];
        
        Y = arc4random() % 11;
        
        X = arc4random() % 11;
        
        if (Y < 5) {
            Y = 5;
        }
        if (X < 5) {
            X = 5;
        }
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view]; //返回在view觸摸的位置
    
    if (point.x < Player.center.x) {
        PlayerMove = -30;
    }
    else if (point.x > Player.center.x) {
        PlayerMove = 30;
    }
    
    
    
    
}


-(void)ComputerMovement{
    
    if (Computer.center.x > Ball.center.x) {
        Computer.center = CGPointMake(Computer.center.x - 2, Computer.center.y);
    }
    if (Computer.center.x < Ball.center.x) {
        Computer.center = CGPointMake(Computer.center.x + 2, Computer.center.y);
    }
}

-(void)PlayerMethod{
    
    Player.center = CGPointMake(Player.center.x + PlayerMove, Player.center.y);
    
    if (CGRectIntersectsRect(Player.frame, BorderLeft.frame)) {
        PlayerMove = 0;
    }
    
    if (CGRectIntersectsRect(Player.frame, BorderRight.frame)) {
        PlayerMove = 0;
    }
}

-(void)Collision{
    
    if (CGRectIntersectsRect(Ball.frame, Player.frame)) {
        Y = arc4random() % 11;
        if (Y < 8) {
            Y = 8;
        }
        Y = 0 - Y;
    }
    
    if (CGRectIntersectsRect(Ball.frame, Computer.frame)) {
        Y = arc4random() % 11;
        if (Y < 8) {
            Y = 8;
        }
        
    }
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    PlayerMove = 0;
}

-(void)GameOver{
    
    Ball.hidden = YES;
    Player.hidden = YES;
    Computer.hidden = YES;
    GameOverView.hidden = NO;
    WinView.hidden = NO;
    RetryView.hidden = NO;
    
    [timer invalidate];
    [playertimer invalidate];
    
    if (ComputerScore < PlayerScore ) {
        WinView.text = [NSString stringWithFormat:@"You Win!"];
    }
    
    if (ComputerScore > PlayerScore ) {
        WinView.text = [NSString stringWithFormat:@"You Lose!"];
    }
    [self HighestScoreLoad];
}

- (void)HighestScoreLoad{
    
    
    HighestScore = [rContent intValue];
    
    if (PlayerScore > HighestScore) {
        
        wContent = [NSString stringWithFormat:@"%d",PlayerScore];
        // 將字串寫入檔案
        [wContent writeToFile: Scorepath atomically: YES encoding: NSUTF8StringEncoding error: NULL];
        HighestScoreView.text = [NSString stringWithFormat:@"%d",PlayerScore];
        NSLog(@"存擋分數: %d", PlayerScore);
    }else{
        HighestScoreView.text = [NSString stringWithFormat:@"%d",HighestScore];
        NSLog(@"存擋分數: %d", HighestScore);
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    
    //共有幾筆資料,第一組選項由0開始
    
    switch (component) {
            
        case 0:
            
            return [plurk count];
            
            break;
            
            
        default:
            
            return 0;
            
            break;
            
    }
    
}


- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    switch (component) {
            
            //載入幾筆資料
            
        case 0:
            
            return [plurk objectAtIndex:row];
            
            break;
            
            
        default:
            
            return @"Error";
            
            break;
            
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
inComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            [pickerView reloadComponent:0];
    }
    
    Pickrow=row;
    //label.text = [NSString stringWithFormat:@"%d",Pick];
    label.text = [NSString stringWithFormat:@"%@", [plurk objectAtIndex:Pickrow]];

}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
