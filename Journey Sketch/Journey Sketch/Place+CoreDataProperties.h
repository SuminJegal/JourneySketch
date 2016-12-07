//
//  Place+CoreDataProperties.h
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 7..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import "Place+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Place (CoreDataProperties)

+ (NSFetchRequest<Place *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *attribution;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *placeID;
@property (nullable, nonatomic, retain) Date *dayHavePlace;

@end

NS_ASSUME_NONNULL_END
