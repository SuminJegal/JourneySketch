//
//  Date+CoreDataProperties.m
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 8..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import "Date+CoreDataProperties.h"

@implementation Date (CoreDataProperties)

+ (NSFetchRequest<Date *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Date"];
}

@dynamic nextday;
@dynamic today;
@dynamic hasNext;
@dynamic dayHavePlace;
@dynamic tripHaveDate;

@end
