//
//  PlaceViewController.m
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 6..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import "PlaceViewController.h"
#import "Place+CoreDataClass.h"
#import "PlaceMapViewController.h"
#import "CoreDataClass.h"

@interface PlaceViewController ()
@property NSString * currentPushDay;
@property CoreDataClass * coreData;
@property Place * placeData;
@property NSString * currentPushName;
@property NSString * currentPushAddress;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *placeName;
@property (weak, nonatomic) IBOutlet UILabel *placeAddress;
@property (weak, nonatomic) IBOutlet UILabel *placeAttribution;
@property double placeLatitude;
@property double placeLongitude;

@end

@implementation PlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.coreData =  [[CoreDataClass alloc] init];
    self.placeData = [self.coreData getOneDataWithAttribute:@"name" inStringValue:self.currentPushName inEntity:@"Place"];
    [self.navigationController setNavigationBarHidden:NO];
    [self.placeName setText:self.placeData.name];
    [self.placeAddress setText:self.placeData.address];
    [self.placeAttribution setText:self.placeData.attribution];
    self.currentPushAddress = self.placeData.address;
    self.placeLatitude = self.placeData.latitude;
    self.placeLongitude = self.placeData.longitude;
    if([segue.destinationViewController isKindOfClass:[PlaceMapViewController class]]) {
        PlaceMapViewController *ivc = (PlaceMapViewController *)segue.destinationViewController;
        [ivc setValue:self.currentPushName forKey:@"placeName"];
        [ivc setValue:self.currentPushAddress forKey:@"placeAddress"];
        ivc.placeLatitude = self.placeLatitude;
        ivc.placeLongitude = self.placeLongitude;
    }
}


@end
