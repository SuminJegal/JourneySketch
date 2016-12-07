//
//  Trip+CoreDataProperties.h
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 7..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import "Trip+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Trip (CoreDataProperties)

+ (NSFetchRequest<Trip *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *tripNumber;
@property (nullable, nonatomic, retain) NSSet<Date *> *tripHaveDate;

@end

@interface Trip (CoreDataGeneratedAccessors)

- (void)addTripHaveDateObject:(Date *)value;
- (void)removeTripHaveDateObject:(Date *)value;
- (void)addTripHaveDate:(NSSet<Date *> *)values;
- (void)removeTripHaveDate:(NSSet<Date *> *)values;

@end

NS_ASSUME_NONNULL_END
