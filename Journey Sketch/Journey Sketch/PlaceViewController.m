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
@import GooglePlaces;

@interface PlaceViewController ()
@property NSString * currentPushDay;
@property CoreDataClass * coreData;
@property Place * placeData;
@property NSString * currentPushID;
@property NSString * currentPushName;
@property NSString * currentPushAddress;
@property (weak, nonatomic) IBOutlet UITextView *text;
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
    self.view.userInteractionEnabled = YES;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [self loadFirstPhotoForPlace:self.currentPushID];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [[event allTouches] anyObject];
    if ([_text isFirstResponder] && [touch view] != _text) {
        [_text resignFirstResponder];
    }
}

- (void)loadFirstPhotoForPlace:(NSString *)placeID {
    [[GMSPlacesClient sharedClient]
     lookUpPhotosForPlaceID:placeID
     callback:^(GMSPlacePhotoMetadataList *_Nullable photos,
                NSError *_Nullable error) {
         if (error) {
             // TODO: handle the error.
             NSLog(@"Error: %@", [error description]);
         } else {
             if (photos.results.count > 0) {
                 GMSPlacePhotoMetadata *firstPhoto = photos.results.firstObject;
                 [self loadImageForMetadata:firstPhoto];
             }
         }
     }];
}

- (void)loadImageForMetadata:(GMSPlacePhotoMetadata *)photoMetadata {
    [[GMSPlacesClient sharedClient]
     loadPlacePhoto:photoMetadata
     constrainedToSize:self.image.bounds.size
     scale:self.image.window.screen.scale
     callback:^(UIImage *_Nullable photo, NSError *_Nullable error) {
         if (error) {
             // TODO: handle the error.
             NSLog(@"Error: %@", [error description]);
         } else {
             self.image.image = photo;
         }
     }];
}

- (IBAction)saveText:(id)sender {
    NSManagedObject * temp_place = [self.coreData getOneDataWithAttribute:@"name" inStringValue:self.currentPushName inEntity:@"Place"];
    [self.coreData setOneDataWithAttribute:@"information" inValue:self.text.text inUniqueEntityObject:temp_place];
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
    if(self.placeData.information){
        [self.text setText:self.placeData.information];
    }
    
    self.currentPushID = self.placeData.placeID;
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
