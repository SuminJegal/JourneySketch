//
//  Date+CoreDataProperties.h
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 8..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import "Date+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Date (CoreDataProperties)

+ (NSFetchRequest<Date *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *nextday;
@property (nullable, nonatomic, copy) NSString *today;
@property (nonatomic) BOOL hasNext;
@property (nullable, nonatomic, retain) NSSet<Place *> *dayHavePlace;
@property (nullable, nonatomic, retain) Trip *tripHaveDate;

@end

@interface Date (CoreDataGeneratedAccessors)

- (void)addDayHavePlaceObject:(Place *)value;
- (void)removeDayHavePlaceObject:(Place *)value;
- (void)addDayHavePlace:(NSSet<Place *> *)values;
- (void)removeDayHavePlace:(NSSet<Place *> *)values;

@end

NS_ASSUME_NONNULL_END
