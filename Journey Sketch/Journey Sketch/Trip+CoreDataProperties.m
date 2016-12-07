//
//  Trip+CoreDataProperties.m
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 7..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import "Trip+CoreDataProperties.h"

@implementation Trip (CoreDataProperties)

+ (NSFetchRequest<Trip *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Trip"];
}

@dynamic tripNumber;
@dynamic tripHaveDate;

@end
