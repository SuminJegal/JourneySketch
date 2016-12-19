//
//  DayCollectionReusableView.h
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 5..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *goToBefore;
@property (weak, nonatomic) IBOutlet UILabel *day;
@end
