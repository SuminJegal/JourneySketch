//
//  StartPlaceViewController.m
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 5..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import "StartPlaceViewController.h"
#import "DayCollectionViewController.h"
#import "CoreDataClass.h"

@interface StartPlaceViewController () 

@property NSString * placeId;
@property NSString * placeName;
@property NSString * placeAddress;
@property NSString * placeAttribution;
@property double placeLatitude;
@property double placeLongitude;
@property NSString * currentPushDay;

@property CoreDataClass * coreData;

@property UISearchController *searchController;
@property GMSAutocompleteResultsViewController *resultsViewController;

@end

@implementation StartPlaceViewController

//// Handle the user's selection.
//- (void)viewController:(GMSAutocompleteViewController *)viewController
//didAutocompleteWithPlace:(GMSPlace *)place {
//    [self dismissViewControllerAnimated:YES completion:nil];
//    // Do something with the selected place.
//    NSLog(@"Place name %@", place.name);
//    NSLog(@"Place address %@", place.formattedAddress);
//    NSLog(@"Place attributions %@", place.attributions.string);
//}
//
//- (void)viewController:(GMSAutocompleteViewController *)viewController
//didFailAutocompleteWithError:(NSError *)error {
//    [self dismissViewControllerAnimated:YES completion:nil];
//    // TODO: handle the error.
//    NSLog(@"Error: %@", [error description]);
//}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.coreData =  [[CoreDataClass alloc] init];
    
    _resultsViewController = [[GMSAutocompleteResultsViewController alloc] init];
    _resultsViewController.delegate = self;
    
    _searchController = [[UISearchController alloc]
                         initWithSearchResultsController:_resultsViewController];
    _searchController.searchResultsUpdater = _resultsViewController;
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, ([[UIScreen mainScreen] bounds].size.height)*0.5-20, [[UIScreen mainScreen] bounds].size.width, 50)];
    
    [subView addSubview:_searchController.searchBar];
    [_searchController.searchBar sizeToFit];
    [self.view addSubview:subView];
    [self.background setImage:[UIImage imageNamed:@"searchPlace.jpg"]];
    // When UISearchController presents the results view, present it in
    // this view controller, not one further up the chain.
    self.definesPresentationContext = YES;
}

// Handle the user's selection.
- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
 didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    [_searchController.searchBar setText:place.name];
    // Do something with the selected place
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    NSLog(@"Place coordinate latitude %f", place.coordinate.latitude);
    NSLog(@"Place coordinate longitude %f", place.coordinate.longitude);
    self.placeId = place.placeID;
    self.placeName = place.name;
    self.placeAddress = place.formattedAddress;
    self.placeAttribution = place.phoneNumber;
    //self.placeAttribution = place.attributions;
    self.placeLatitude = place.coordinate.latitude;
    self.placeLongitude = place.coordinate.longitude;
    
}

- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictionsForResultsController:
(GMSAutocompleteResultsViewController *)resultsController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictionsForResultsController:
(GMSAutocompleteResultsViewController *)resultsController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.coreData setPlaceIdInNewPlace:self.placeId withName:self.placeName withAddress:self.placeAddress withAttribution:self.placeAttribution withLatitude:self.placeLatitude withLongitude:self.placeLongitude InDay:self.currentPushDay];
    if([segue.destinationViewController isKindOfClass:[DayCollectionViewController class]]) {
        DayCollectionViewController *ivc = (DayCollectionViewController *)segue.destinationViewController;
        [ivc setValue:self.currentPushDay forKey:@"currentPushDay"];
    }
}


@end
