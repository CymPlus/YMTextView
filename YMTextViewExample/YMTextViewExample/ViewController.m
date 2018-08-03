//
//  ViewController.m
//  YMTextViewExample
//
//  Created by cym_bj on 2018/8/3.
//  Copyright © 2018年 cym_bj. All rights reserved.
//

#import "ViewController.h"
#import "YMTextView.h"
@interface ViewController ()
@property (nonatomic,strong)YMTextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView=[[YMTextView alloc]init];
    self.textView.frame=CGRectMake(10, 100, 300, 100);
    self.textView.maxNumb=200;
    self.textView.isAutoHeigth=YES;
    self.textView.frameHeight=100;
    self.textView.backgroundColor=[UIColor orangeColor];
    self.textView.rowSpace=5;
    self.textView.isFinishKeyboard=YES;
    [self.view addSubview:self.textView];
}


@end
