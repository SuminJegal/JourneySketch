//
//  PageViewController.m
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 2..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import "PageViewController.h"
#import "DayCollectionViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DayCollectionViewController *dayView = [self.storyboard instantiateViewControllerWithIdentifier:@"dayView"];
    
    //NSMutableArray* vi = [[NSMutableArray alloc]init];
    
    //vi addObject:(nonnull id);
    NSArray* views = @[dayView];
    [self setViewControllers:views direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
