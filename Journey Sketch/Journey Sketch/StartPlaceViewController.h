//
//  StartPlaceViewController.h
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 5..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import <GooglePlaces/GooglePlaces.h>

@interface StartPlaceViewController : UIViewController<GMSAutocompleteViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *background;


@end
