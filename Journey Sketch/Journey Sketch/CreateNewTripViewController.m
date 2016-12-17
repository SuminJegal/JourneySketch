//
//  CreateNewTripViewController.m
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 7..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import "CreateNewTripViewController.h"
#import "CoreDataClass.h"

@interface CreateNewTripViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;
@property CoreDataClass * coreData;
@end

@implementation CreateNewTripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coreData =  [[CoreDataClass alloc] init];
    //self.startDate = [[UIDatePicker alloc]init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString * today = [self getStringFromDate:[self.startDate date]];
    NSString * tommorow = [self getStringFromDate:[[self.startDate date] dateByAddingTimeInterval:24*60*60]];
    [self.coreData setNewDateInNewTrip:today withNextDay:tommorow];
    if([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *ivc = (UINavigationController *)segue.destinationViewController;
        UICollectionView *vc = (UICollectionView *)[ivc topViewController];
        [vc setValue:today forKey:@"currentPushDay"];
    }
}

- (NSString *)getStringFromDate:(NSDate *)date{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"yyyy.MM.dd"];
    NSString * string = [dateformatter stringFromDate:date];
    return string;
}

@end
