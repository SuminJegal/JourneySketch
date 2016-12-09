//
//  ViewController.m
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 10. 24..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)shouldAutorotate {
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.startImage setImage:[UIImage imageNamed:@"startImage.png"]];
    [self.navigationController setNavigationBarHidden:YES];
}


@end
