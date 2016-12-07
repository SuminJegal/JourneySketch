//
//  Place+CoreDataProperties.m
//  Journey Sketch
//
//  Created by 제갈수민 on 2016. 12. 7..
//  Copyright © 2016년 제갈수민. All rights reserved.
//

#import "Place+CoreDataProperties.h"

@implementation Place (CoreDataProperties)

+ (NSFetchRequest<Place *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Place"];
}

@dynamic address;
@dynamic attribution;
@dynamic name;
@dynamic placeID;
@dynamic dayHavePlace;

@end
