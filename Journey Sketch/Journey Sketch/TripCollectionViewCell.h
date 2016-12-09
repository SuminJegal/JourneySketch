//
//  TripCollectionViewCell.h
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 3..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;

@end
