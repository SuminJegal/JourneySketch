//
//  CoreDataClass.h
//  Health_On
//
//  Created by Mac on 2014. 10. 19..
//  Copyright (c) 2014년 thyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface CoreDataClass : NSObject
{
    NSManagedObjectContext * dataContext;           // 객체관리자 선언
    NSFetchRequest *request;
}

/*
 * 기능 : CSV 파일을 읽어 온다
 * 파라메터 : csv 파일 이름
 * 반환 : 없음
 */
//- (void)loadDataCSVWithfileName:(NSString*)fileName;

#pragma mark - Create
- (void)createOneEntity:(NSString *)entitiForName;

#pragma mark - Getter

/*
 * 기능 : 특정 엔터티(Entity) 내에 있는 값들 중에 특정 분류(Attribute)안에 있는 값(Value)을 가져온다
 * 파라메터 : 찾고자 하는 필드값(String), 찾고자 하는 값(String), 찾을 엔터티 이름(String)
 * 반환값 : ManagedObject 형태의 데이터 한개
 * 특징 : 찾고자 하는 값이 NSString 타입이며 같은 게 여러개일 경우 첫번째 값만 반환한다
 */
- (NSManagedObject*)getOneDataWithAttribute:(NSString*)attribute inStringValue:(NSString*)value inEntity:(NSString*)entityForName;

/*
 * 기능 : 특정 엔터티(Entity) 내에 있는 값들 중에 특정 분류(Attribute)안에 있는 값(Value)을 가져온다
 * 파라메터 : 찾고자 하는 필드값(NSString), 찾고자 하는 값(NSNumber), 찾을 엔터티 이름(NSString)
 * 반환값 : ManagedObject 형태의 데이터 한개
 * 특징 : 찾고자 하는 값이 NSNumber 타입이며 같은 게 여러개일 경우 첫번째 값만 반환한다
 */
- (NSManagedObject*)getOneDataWithAttribute:(NSString*)attribute inNumberValue:(NSNumber*)value inEntity:(NSString*)entityForName;

/*
 * 기능 : 특정 엔터티(Entity) 내에 있는 값들 중에 특정 분류(Attribute)안에 있는 값(Value)들을 가져온다
 * 파라메터 : 찾고자 하는 필드값(NSString), 찾고자 하는 값(NSNumber), 찾을 엔터티 이름(NSString)
 * 반환값 : 찾은 값들이 들어있는 NSArray타입 형태의 배열
 * 특징 : 찾고자 하는 값이 NSString 타입이며 같은 게 찾은 값들 모두를 배열에 저장해서 반환한다
 */
- (NSArray*)getSomeDataWithAttribute:(NSString *)attribute WithValue:(NSString*)value inEntity:(NSString *)entityForName;


/*
 * 기능 : 특정 엔터티(Entity) 내에 있는 값들 중에 특정 분류(Attribute)안에 있는 값들을 모두 가져온다
 * 파라메터 : 찾고자 하는 필드값(NSString), 찾을 엔터티 이름(NSString)
 * 반환값 : 찾은 값들이 들어있는 NSArray타입 형태의 배열
 * 특징 : 찾고자 하는 값이 NSString 타입이며 같은 게 찾은 값들 모두를 배열에 저장해서 반환한다
 */
- (NSArray*)getSomeDataWithAttribute:(NSString *)attribute inEntity:(NSString *)entityForName;

/*
 * 기능 : 특정 엔터티에 있는 모든 데이터를 가져온다
 * 파라메터 : 찾고자 하는 엔터티(NSString)
 * 반환값 : NSArray 타입의 배열
 */
- (NSArray*)getAllEntityDataWithEntity:(NSString*)entityForName;

//
//#pragma mark - Setter
//
///*
// * 기능 : 특정 엔터티에 원하는 값을 저장한다
// * 파라메터 : 저장하고 싶은 필드값(NSString), 저장할 값(NSNumber), 저장 할 엔터티 이름(NSString)
// * 반환값 : 없음
// */
- (void)setOneDataWithAttribute:(NSString*)attribute inValue:(NSString*)value inEntity:(NSString*)entityForName;
/*
 * 기능 : 특정한 엔터티 객체에 원하는 값을 저장한다
 * 파라메터 : 저장하고 싶은 필드값(NSString), 저장할 값(NSNumber), 저장 할 엔터티 객체(NSManagedObject)
 * 반환값 : 없음
 */
- (void)setOneDataWithAttribute:(NSString *)attribute inValue:(NSString *)value inUniqueEntityObject:(NSManagedObject *)entity;
/*
 * 기능 : 특정 엔터티에 원하는 값 두개를 저장한다
 * 파라메터 : 저장하고 싶은 필드값1(NSString), 저장할 값1(NSNumber), 저장 할 엔터티 이름(NSString), 저장하고 싶은 필드값2(NSString), 저장할 값2(NSNumber)
 * 반환값 : 없음
 */
- (void)setTwoDataWithAttribute:(NSString *)attribute inValue:(NSString *)value inEntity:(NSString *)entityForName WithOtherAttribute:(NSString *)otherAttribute inOtherValue:(NSString *)otherValue;
/*
 * 기능 : Date에 여행시작 날짜에 대한 값을 넣고 해당 Date를 가지고 있는 Trip만들기
 * 파라메터 : 저장하고 싶은 날짜(NSDate)
 * 반환값 : 없음
 */
- (void)setNewDateInNewTrip:(NSString *)date withNextDay:nextDate;

/*
 * 기능 : PlaceId, name, address, attribution, latitude, longitude을 받아 Place엔터티 만들기
 * 파라메터 : PlaceId,name,address,attribution(NSString), latitude,longitude(double)
 * 반환값 : 없음
 */
- (void)setPlaceIdInNewPlace:(NSString *)placeId withName:(NSString *)name withAddress:(NSString *)address withAttribution:(NSString *)attribution withLatitude:(double)latitude withLongitude:(double)longitude InDay:(NSString *)day;
//
//
///*
// * 기능 : 오늘 날짜에 아침, 점심, 저녁, 야식 엔터티(Entity)중 한 엔터티에 음식을 저장한다
// * 파라메터 : 저장할 음식의 ID(NSNumber), 저장할 엔터티 이름(NSString)
// * 반환값 : 없음
// */
//- (void)setOneDataWithDateinFoodId:(NSNumber*)foodId inEntity:(NSString*)entityForName;
//
///*
// * 기능 : 특정 날짜에 아침, 점심, 저녁, 야식 엔터티(Entity)중 한 엔터티에 음식을 저장한다
// * 파라메터 : 저장할 음식의 ID(NSNumber), 저장할 엔터티 이름(NSString), 저장할 날짜(NSString)
// * 반환값 : 없음
// */
//- (void)setOneDataWithDateinFoodId:(NSNumber*)foodId inEntity:(NSString*)entityForName WithDate:(NSString*)date;
//
//#pragma mark - Remove
///*
// * 기능 : 특정 엔터티의 모든 데이터를 삭제한다
// * 파라메터 : 삭제를 원하는 엔터티(NSString)
// * 반환값 : 없음
// */
//- (void)removeAllEntityDataWithEntity:(NSString*)entityForName;
//
//
///*
// * 기능 : 특정 엔터티에 원하는 값을 삭제한다
// * 파라메터 : 삭제를 원하는 분류(NSString), 삭제할 값(NSString), 특정 엔터티(NSString)
// * 반환값 : 없음
// */
//- (void)removeOneEntityDataWithAttribute:(NSString *)attribute WithValue:(NSString*)value inEntity:(NSString *)entityForName;
//
//- (void)removeAllFoodWithDate:(NSString*)date WithEntity:(NSString *)entityForName;
@end
