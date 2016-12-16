//
//  DayCollectionViewCell.h
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 5..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DayCellDelegate
-(void)deleteButtonClick:(UICollectionViewCell *)cell;
@end

@interface DayCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak , nonatomic) id<DayCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end
