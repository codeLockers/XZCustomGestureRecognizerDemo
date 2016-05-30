//
//  ViewController.m
//  XZCustomGestureRecognizer
//
//  Created by 徐章 on 16/5/30.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "ViewController.h"
#import "XZCustomGestureRecognizer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XZCustomGestureRecognizer *gesture = [[XZCustomGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_Method)];
    [self.view addGestureRecognizer:gesture];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gesture_Method{

    NSLog(@"hahahah");
}

@end
