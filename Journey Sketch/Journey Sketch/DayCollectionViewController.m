//
//  DayCollectionViewController.m
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 3..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import "DayCollectionViewController.h"
#import "DayCollectionViewCell.h"
#import "CoreDataClass.h"
#import "Place+CoreDataClass.h"
#import "DayCollectionReusableView.h"
@import GooglePlaces;

@interface DayCollectionViewController ()
@property CoreDataClass * coreData;
@property NSArray * placeData;
@property NSString * currentPushDay;
@property NSString * currentPushName;
@end

@implementation DayCollectionViewController

static NSString * const reuseIdentifier = @"places";

- (void)userDidSwipe:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        //handle the gesture appropriately
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coreData =  [[CoreDataClass alloc] init];
    self.placeData = [self.coreData getSomeDataWithAttribute:@"day" WithValue:self.currentPushDay inEntity:@"Place"];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
   // [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
}*/


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return [self.placeData count]+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UISwipeGestureRecognizer* gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(userDidSwipe:)];
    gestureRecognizer.numberOfTouchesRequired = 1;
    [gestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [cell addGestureRecognizer:gestureRecognizer];
    
    if(indexPath.row == [self.placeData count]){
        [cell.label setText:@"New"];
        [cell.image setImage:[UIImage imageNamed:@"historically-1757930_1280.jpg"]];
    }else{
        Place * place = [self.placeData objectAtIndex:indexPath.row];
        [cell.label setText:place.name];
        [self loadFirstPhotoForPlace:place.placeID inImageView:cell.image];
    }
    
    // Configure the cell
    
    return cell;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    DayCollectionReusableView* reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"dayHeader" forIndexPath:indexPath];
    [reuseView.day setText:self.currentPushDay];
    return reuseView;
    
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == [self.placeData count]){
        UIViewController* view = [self.storyboard instantiateViewControllerWithIdentifier:@"newPlace"];
        
        [view setValue:self.currentPushDay forKey:@"currentPushDay"];
        [self.navigationController pushViewController:view animated:YES];
    }else{
        UIViewController* view = [self.storyboard instantiateViewControllerWithIdentifier:@"oldPlace"];
        
        Place * place_instance = [self.placeData objectAtIndex:indexPath.row];
        self.currentPushName = place_instance.name;
        [view setValue:self.currentPushName forKey:@"currentPushName"];
        [view setValue:self.currentPushDay forKey:@"currentPushDay"];
        [self.navigationController pushViewController:view animated:YES];
    }
}

- (void)loadFirstPhotoForPlace:(NSString *)placeID inImageView:(UIImageView *)image{
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
                 [self loadImageForMetadata:firstPhoto inImageView:image];
             }
         }
     }];
}

- (void)loadImageForMetadata:(GMSPlacePhotoMetadata *)photoMetadata inImageView:(UIImageView *)image{
    [[GMSPlacesClient sharedClient]
     loadPlacePhoto:photoMetadata
     constrainedToSize:image.bounds.size
     scale:image.window.screen.scale
     callback:^(UIImage *_Nullable photo, NSError *_Nullable error) {
         if (error) {
             // TODO: handle the error.
             NSLog(@"Error: %@", [error description]);
         } else {
             image.image = photo;
         }
     }];
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
