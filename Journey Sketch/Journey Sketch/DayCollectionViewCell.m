//
//  DayCollectionViewCell.m
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 5..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import "DayCollectionViewCell.h"

@implementation DayCollectionViewCell



- (void)awakeFromNib{
    [super awakeFromNib];
    [self.deleteButton setHidden:YES];
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)swipe {
    [self.deleteButton setHidden:NO];
}

-(IBAction)clickDeleteButton{
    [self.delegate deleteButtonClick:self];
}


//Cell.h
//@class MyCell;
//@protocol MyCellDelegate
//
//-(void)deleteButtonClick:(MyCell *)cell;
//@end
//@interface MyCell : UICollectionViewCell
//@property (weak , nonatomic) id<MyCellDelegate> delegate;
//@property (weak,nonatomic) IBOutlet *delButton;
//@end Cell.m -(void)awakeFromNib{ [self.delButton setHidden:YES] //add Swipe right to here }
//
//    -(void)handleSwipeRight:(UISwipeGestureRecognizer *)swipe {
//    [self.delButton setHidden:NO];
//    }
//    -(IBAction)clickDelBut{
//        [self.delegate deleteButtonClick:self];
//    } ViewController.m //In cellForItemsAtIndexPath
//    cell.delegate = self. -(void)deleteButtonClick:(MyCell *)cell{ //get indexPath, delete data and reload collectionView here }

@end
