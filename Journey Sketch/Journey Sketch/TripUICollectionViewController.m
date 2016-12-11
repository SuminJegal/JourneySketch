//
//  TripUICollectionViewController.m
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 3..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import "TripUICollectionViewController.h"
#import "TripCollectionViewCell.h"
#import "CoreDataClass.h"
#import "Trip+CoreDataClass.h"

@interface TripUICollectionViewController ()
@property CoreDataClass * coreData;
@property NSArray * tripData;
@property NSString * currentPushDay;
@end

@implementation TripUICollectionViewController

static NSString * const reuseIdentifier = @"eachTrip";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.coreData =  [[CoreDataClass alloc] init];
    self.tripData = [self.coreData getAllEntityDataWithEntity:@"Trip"];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return [self.tripData count]+1;
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TripCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if(indexPath.row == [self.tripData count]){
        [cell.label setText:@"새로운 여행"];
        [cell.subLabel setText:@"눌러서 새로운 여행을 시작하세요"];
        [cell.image setImage:[UIImage imageNamed:@"clouds-1845097_1280.jpg"]];
    }else{
        [cell.label setText:[NSString stringWithFormat:@"%d번째 여행", indexPath.row+1]];
        Trip * trip = [self.tripData objectAtIndex:indexPath.row];
        [cell.subLabel setText:trip.tripNumber];
    }
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == [self.tripData count]){
        UIViewController* view = [self.storyboard instantiateViewControllerWithIdentifier:@"newTrip"];
        
        [self.navigationController pushViewController:view animated:YES];
    }else{
        UIViewController* view = [self.storyboard instantiateViewControllerWithIdentifier:@"dayView"];
        
        Trip * trip_instance = [self.tripData objectAtIndex:indexPath.row];
        NSString * currentPushDay = trip_instance.tripNumber;
        [view setValue:currentPushDay forKey:@"currentPushDay"];
        [self.navigationController pushViewController:view animated:YES];
        
    }
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
