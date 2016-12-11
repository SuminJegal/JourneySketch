//
//  PlaceMapViewController.m
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 6..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import "PlaceMapViewController.h"

@interface PlaceMapViewController ()

@end

@implementation PlaceMapViewController

- (void)viewDidLoad {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.placeLatitude
                                                            longitude:self.placeLongitude
                                                                 zoom:14];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(self.placeLatitude, self.placeLongitude);
    marker.title = self.placeName;
    marker.snippet = self.placeAddress;
    marker.map = mapView_;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
