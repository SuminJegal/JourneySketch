//
//  CoreDataClass.m
//  Health_On
//
//  Created by Mac on 2014. 10. 19..
//  Copyright (c) 2014년 thyang. All rights reserved.
//



#import "Date+CoreDataClass.h"
#import "Place+CoreDataClass.h"
#import "Trip+CoreDataClass.h"
#import "CoreDataClass.h"

@implementation CoreDataClass
// 초기화 함수
- (instancetype)init
{
    self = [super init];
    if (self) {
        // appDelegate, foodContext 초기화
        id appDelegate = [[UIApplication sharedApplication] delegate];
        dataContext = [appDelegate managedObjectContext];
        // appDelegate에 접근하여 ManagedObjectContext를 가져온다
    }
    return self;
}
/*
 * 기능 : CSV 파일을 읽어 온다
 * 파라메터 : csv 파일 이름
 * 반환 : 없음
 */
//- (void)loadDataCSVWithfileName:(NSString *)fileName
//{
//    // contexts에 Food.csv파일을 일반적인 String으로 집어넣는다
//    
//    NSString* contexts = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:@"tsv"] encoding:NSUTF8StringEncoding error:nil];
//    
//    // contexts에서 \n 까지 읽어서 lines에 넣는다
//    NSArray* lines = [contexts componentsSeparatedByString:@"\n"];
//    
//    for(NSString* line in lines)
//    {
//        
//        if([line isEqualToString:@""]){
//            break;
//        }
//        // indexing
//        int i =0;
//        
//        // 드라마 정보를 넣을 Object 생성
//        Drama * drama = [NSEntityDescription insertNewObjectForEntityForName:@"Drama" inManagedObjectContext:dataContext];
//        
//        
//        
//        
//        // '|'을 기준으로 토큰을 나눈다
//        NSArray* fields = [line componentsSeparatedByString:@"\t"];
//        
//        [drama setName:[fields objectAtIndex:i++]];
//        [drama setAge:[fields objectAtIndex:i++]];
//        [drama setKing:[fields objectAtIndex:i++]];
//        
//        i++;
//        
//        // 등장인물 설정
//        for(int j = 0; j < [[fields objectAtIndex:3] intValue]; j++){
//            NSString* people = [fields objectAtIndex:i++];
//            NSArray* peopleArray = [people componentsSeparatedByString:@"/"];
//            
//            // 극중 인물과 연결된 드라마 설정
//            Person* person_instance = (Person*)[self getOneDataWithAttribute:@"name" inStringValue:[peopleArray objectAtIndex:0] inEntity:@"Person"];
//            
//            if(person_instance){
//                [person_instance addDramaObject:(Drama*)drama];
//            }else{
//                // 인물에 대한 Entity 추가
//                Person * person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:dataContext];
//                // 배우에 대한 Entity 추가
//                Actor* actor = [NSEntityDescription insertNewObjectForEntityForName:@"Actor" inManagedObjectContext:dataContext];
//                
//                [person setName:[peopleArray objectAtIndex:0]];
//                [person setKing:[fields objectAtIndex:2]];
//                
//                [actor setName:[peopleArray objectAtIndex:1]];
//                 [actor addPersonObject:person];
//                 [actor addDramaObject:drama];
//                
//                [drama addPeopleObject:(Person*)person];
//            }
//           
//        }
//        
//        [drama setValue:[fields objectAtIndex:i++] forKey:@"about"];
//        [drama setValue:[fields objectAtIndex:i++] forKey:@"link"];
//        [drama setOnairyear:[fields objectAtIndex:i]];
//        
//    }
//    NSError* error;
//    [dataContext save:&error];
////    NSLog(@"Food Contexts are Loaded");        // mStatus의 글자를 변경한다
//}

#pragma mark - Getter

- (void)createOneEntity:(NSString *)entitiForName
{
    [NSEntityDescription insertNewObjectForEntityForName:entitiForName inManagedObjectContext:dataContext];
}


/*
 * 기능 : 특정 엔터티(Entity) 내에 있는 값들 중에 특정 분류(Attribute)안에 있는 값(Value)을 가져온다
 * 파라메터 : 찾고자 하는 필드값(String), 찾고자 하는 값(String), 찾을 엔터티 이름(String)
 * 반환값 : ManagedObject 형태의 데이터 한개
 * 특징 : 찾고자 하는 값이 NSString 타입이며 같은 게 여러개일 경우 첫번째 값만 반환한다
 */
- (NSManagedObject*)getOneDataWithAttribute:(NSString *)attribute inStringValue:(NSString *)value inEntity:(NSString *)entityForName
{
    
    request = [[NSFetchRequest alloc] init];
    
    // 원하는 Entity를 받아온다
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityForName inManagedObjectContext:dataContext];
    
    // 찾고 싶은 값의 조건을 설정한다
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K == %@",attribute ,value];
    
    [request setEntity:entity];
    [request setPredicate:pred];
    
    NSError* error;
    
    // 조건에 맞는 값들을 배열에 저장한다
    NSArray *objects = [dataContext executeFetchRequest:request error:&error];
    
    // 받아온 값이 없을 경우 NSLog 출력
    if([objects count] == 0)
    {
        return nil;
    //    NSLog(@"No %@ Data in %@", value, entityForName);
    }
    
    
    // 받아온 배열의 첫번째 값을 반환한다
    return objects[0];
}

/*
 * 기능 : 특정 엔터티(Entity) 내에 있는 값들 중에 특정 분류(Attribute)안에 있는 값(Value)을 가져온다
 * 파라메터 : 찾고자 하는 필드값(NSString), 찾고자 하는 값(NSNumber), 찾을 엔터티 이름(NSString)
 * 반환값 : ManagedObject 형태의 데이터 한개
 * 특징 : 찾고자 하는 값이 NSNumber 타입이며 같은 게 여러개일 경우 첫번째 값만 반환한다
 */
- (NSManagedObject*)getOneDataWithAttribute:(NSString *)attribute inNumberValue:(NSNumber *)value inEntity:(NSString *)entityForName
{
    
    request = [[NSFetchRequest alloc] init];
    
    // 원하는 Entity를 받아온다
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityForName inManagedObjectContext:dataContext];
    
    // 찾고 싶은 값의 조건을 설정한다
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K == %@",attribute ,value];
    
    [request setEntity:entity];
    [request setPredicate:pred];
    
    NSError* error;
    // 조건에 맞는 값들을 배열에 저장한다
    NSArray *objects = [dataContext executeFetchRequest:request error:&error];
    
    // 받아온 값이 없을 경우 NSLog 출력
    if([objects count] == 0)
    {
   //    NSLog(@"No %@ Data in %@", value, entityForName);
    }
    
    
    // 받아온 배열의 첫번째 값을 반환한다
    return objects[0];
}

/*
 * 기능 : 특정 엔터티(Entity) 내에 있는 값들 중에 특정 분류(Attribute)안에 있는 값(Value)들을 가져온다
 * 파라메터 : 찾고자 하는 필드값(NSString), 찾고자 하는 값(NSNumber), 찾을 엔터티 이름(NSString)
 * 반환값 : 찾은 값들이 들어있는 NSArray타입 형태의 배열
 * 특징 : 찾고자 하는 값이 NSString 타입이며 같은 게 찾은 값들 모두를 배열에 저장해서 반환한다
 */
- (NSArray*)getSomeDataWithAttribute:(NSString *)attribute WithValue:(NSString*)value inEntity:(NSString *)entityForName
{
    request = [[NSFetchRequest alloc] init];
    
    // 원하는 Entity를 받아온다
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityForName inManagedObjectContext:dataContext];
    
    // 찾고 싶은 값의 조건을 설정한다
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K == %@", attribute, value];
    
    [request setEntity:entity];
    [request setPredicate:pred];
    
    NSError* error;
    // 조건에 맞는 값들을 배열에 저장한다
    NSArray *objects = [dataContext executeFetchRequest:request error:&error];
    
    // 받아온 값이 없을 경우 NSLog 출력
    if([objects count] == 0)
    {
    //    NSLog(@"No %@ Data in %@", value, entityForName);
    }
    
    // 받아온 배열의 첫번째 값을 반환한다
    return objects;
}

/*
 * 기능 : 특정 엔터티(Entity) 내에 있는 값들 중에 특정 분류(Attribute)안에 있는 값들을 모두 가져온다
 * 파라메터 : 찾고자 하는 필드값(NSString), 찾을 엔터티 이름(NSString)
 * 반환값 : 찾은 값들이 들어있는 NSArray타입 형태의 배열
 * 특징 : 찾고자 하는 값이 NSString 타입이며 같은 게 찾은 값들 모두를 배열에 저장해서 반환한다
 */
- (NSArray*)getSomeDataWithAttribute:(NSString *)attribute inEntity:(NSString *)entityForName
{
    request = [[NSFetchRequest alloc] init];
    
    // 원하는 Entity를 받아온다
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityForName inManagedObjectContext:dataContext];

    [request setEntity:entity];
    
    NSError* error;
    // 조건에 맞는 값들을 배열에 저장한다
    NSArray *objects = [dataContext executeFetchRequest:request error:&error];
    
    // 받아온 값이 없을 경우 NSLog 출력
    if([objects count] == 0)
    {
        //    NSLog(@"No %@ Data in %@", value, entityForName);
    }
    
    // 받아온 배열의 첫번째 값을 반환한다
    return objects;
}

/*
 * 기능 : 특정 엔터티에 있는 모든 데이터를 가져온다
 * 파라메터 : 찾고자 하는 엔터티(NSString)
 * 반환값 : NSArray 타입의 배열
 */
- (NSArray*)getAllEntityDataWithEntity:(NSString*)entityForName
{
    request = [[NSFetchRequest alloc] init];
    
    // Entity가 쿼리가 되도록 설정
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityForName inManagedObjectContext:dataContext];
    [request setEntity:entity];
    
    NSError* error;
    // Query on managedObjectContext with generated fetchRequest
    NSArray* fetchedFoods = [dataContext executeFetchRequest:request error:&error];
    
    return fetchedFoods;
}

#pragma mark - Setter
/*
 * 기능 : 특정 엔터티에 원하는 값을 저장한다
 * 파라메터 : 저장하고 싶은 필드값(NSString), 저장할 값(NSNumber), 저장 할 엔터티 이름(NSString)
 * 반환값 : 없음
 */
- (void)setOneDataWithAttribute:(NSString *)attribute inValue:(NSString *)value inEntity:(NSString *)entityForName
{
    // 저장을 원하는 Entity를 받아온다
    NSManagedObject* newAttribue = [NSEntityDescription insertNewObjectForEntityForName:entityForName inManagedObjectContext:dataContext];
    
    NSError* error;
    
    // 받아온 Entity중 원하는 key값에 해당하는 새로운 value를 설정한다
    [newAttribue setValue:value forKey:attribute];
    
    [dataContext save:&error];

    
//    NSLog(@"Saved");
}

/*
 * 기능 : 특정 엔터티에 원하는 값 두개를 저장한다
 * 파라메터 : 저장하고 싶은 필드값1(NSString), 저장할 값1(NSNumber), 저장 할 엔터티 이름(NSString), 저장하고 싶은 필드값2(NSString), 저장할 값2(NSNumber)
 * 반환값 : 없음
 */
- (void)setTwoDataWithAttribute:(NSString *)attribute inValue:(NSString *)value inEntity:(NSString *)entityForName WithOtherAttribute:(NSString *)otherAttribute inOtherValue:(NSString *)otherValue
{
    // 저장을 원하는 Entity를 받아온다
    NSManagedObject* newAttribue = [NSEntityDescription insertNewObjectForEntityForName:entityForName inManagedObjectContext:dataContext];
    
    NSError* error;
    
    // 받아온 Entity중 원하는 key값에 해당하는 새로운 value를 설정한다
    [newAttribue setValue:value forKey:attribute];
    [newAttribue setValue:otherValue forKey:otherAttribute];
    
    [dataContext save:&error];
    
    
    //    NSLog(@"Saved");
}

/*
 * 기능 : Date에 여행시작 날짜에 대한 값을 넣고 해당 Date를 가지고 있는 Trip만들기
 * 파라메터 : 저장하고 싶은 날짜(NSDate)
 * 반환값 : 없음
 */
- (void)setNewDateInNewTrip:(NSString *)date withNextDay:nextDate
{
    NSManagedObject* newDateAttribute = [NSEntityDescription insertNewObjectForEntityForName:@"Date" inManagedObjectContext:dataContext];
    
    NSError* error;
    
    [newDateAttribute setValue:date forKey:@"today"];
    [newDateAttribute setValue:nextDate forKey:@"nextday"];
    [newDateAttribute setValue:NO forKey:@"hasNext"];
    
    NSManagedObject* newTripAttribute = [NSEntityDescription insertNewObjectForEntityForName:@"Trip" inManagedObjectContext:dataContext];
    
    [newTripAttribute setValue:date forKey:@"tripNumber"];
    
    
    Trip* trip_instance = (Trip*)[self getOneDataWithAttribute:@"tripNumber" inStringValue:date inEntity:@"Trip"];
    if(trip_instance){
        [trip_instance addTripHaveDateObject:(Date*)newDateAttribute];
    }
    [dataContext save:&error];
    
}


///*
// * 기능 : 오늘 날짜에 아침, 점심, 저녁, 야식 엔터티(Entity)중 한 엔터티에 음식을 저장한다
// * 파라메터 : 저장할 음식의 ID(NSNumber), 저장할 엔터티 이름(NSString)
// * 반환값 : 없음
// */
//- (void)setOneDataWithDateinFoodId:(NSNumber *)foodId inEntity:(NSString *)entityForName
//{
//    
//    // 저장을 원하는 Entity를 받아온다
//    NSManagedObject* newAttribue = [NSEntityDescription insertNewObjectForEntityForName:entityForName inManagedObjectContext:foodContext];
//    
//    // 받아온 Entity중 원하는 key값에 해당하는 새로운 value를 설정한다
//    [newAttribue setValue:foodId forKey:@"foodId"];
//    [newAttribue setValue:[self.dateUtility getTodayDate] forKey:@"date"];
//    
//    [foodContext save:&error];
//}
//
///*
// * 기능 : 특정 날짜에 아침, 점심, 저녁, 야식 엔터티(Entity)중 한 엔터티에 음식을 저장한다
// * 파라메터 : 저장할 음식의 ID(NSNumber), 저장할 엔터티 이름(NSString), 저장할 날짜(NSString)
// * 반환값 : 없음
// */
//- (void)setOneDataWithDateinFoodId:(NSNumber*)foodId inEntity:(NSString*)entityForName WithDate:(NSString*)date
//{
//    
//    // 저장을 원하는 Entity를 받아온다
//    NSManagedObject* newAttribue = [NSEntityDescription insertNewObjectForEntityForName:entityForName inManagedObjectContext:foodContext];
//    
//    // 받아온 Entity중 원하는 key값에 해당하는 새로운 value를 설정한다
//    [newAttribue setValue:foodId forKey:@"foodId"];
//    [newAttribue setValue:date forKey:@"date"];
//    
//    [foodContext save:&error];
//}
//
//
//
///*
// * 기능 : 원하는 날짜의 아침식사들중 특정 영양소 총 값을 가져온다
// * 파라메터 : 원하는 날짜(NSString), 원하는 영양소(NSString)
// * 반환값 : double 타입의 영양소 총 값
// */
//
//#pragma mark - GetCalories
//-(double)getBreakfastCaloriesWithDate:(NSString*)date WithNutrition:(NSString*)nutrition
//{
//    double breakfastCalories=0;
//    
//    NSArray *objects = [self getSomeDataWithAttribute:@"date" WithValue:date inEntity:@"Breakfast"];
//    for(Breakfast *breakfast in objects)
//    {
//        NSManagedObject *food = [self getOneDataWithAttribute:@"foodId" inNumberValue:[breakfast foodId] inEntity:@"Food"];
//        breakfastCalories += [[food valueForKey:nutrition] doubleValue];
//    }
//    
//    return breakfastCalories;
//    
//}
//
///*
// * 기능 : 원하는 날짜의 점심식사들중 특정 영양소 총 값을 가져온다
// * 파라메터 : 원하는 날짜(NSString), 원하는 영양소(NSString)
// * 반환값 : double 타입의 영양소 총 값
// */
//-(double)getLunchCaloriesWithDate:(NSString*)date WithNutrition:(NSString*)nutrition
//{
//    double lunchCalories=0;
//    
//    NSArray *objects = [self getSomeDataWithAttribute:@"date" WithValue:date inEntity:@"Lunch"];
//    for(Lunch *lunch in objects)
//    {
//        NSManagedObject *food = [self getOneDataWithAttribute:@"foodId" inNumberValue:[lunch foodId] inEntity:@"Food"];
//        lunchCalories += [[food valueForKey:nutrition] doubleValue];
//    }
//    
//    return lunchCalories;
//}
//
///*
// * 기능 : 원하는 날짜의 저녁식사들중 특정 영양소 총 값을 가져온다
// * 파라메터 : 원하는 날짜(NSString), 원하는 영양소(NSString)
// * 반환값 : double 타입의 영양소 총 값
// */
//-(double)getDinnerCaloriesWithDate:(NSString*)date WithNutrition:(NSString*)nutrition
//{
//    double dinnerCalories=0;
//    
//    NSArray *objects = [self getSomeDataWithAttribute:@"date" WithValue:date inEntity:@"Dinner"];
//    for(Dinner *dinner in objects)
//    {
//        NSManagedObject *food = [self getOneDataWithAttribute:@"foodId" inNumberValue:[dinner foodId] inEntity:@"Food"];
//        dinnerCalories += [[food valueForKey:nutrition] doubleValue];
//    }
//    
//    return dinnerCalories;
//    
//}
//
///*
// * 기능 : 원하는 날짜의 야식들중 특정 영양소 총 값을 가져온다
// * 파라메터 : 원하는 날짜(NSString), 원하는 영양소(NSString)
// * 반환값 : double 타입의 영양소 총 값
// */
//- (double)getNightCaloriesWithDate:(NSString*)date WithNutrition:(NSString*)nutrition
//{
//    double nightCalories=0;
//    
//    NSArray *objects = [self getSomeDataWithAttribute:@"date" WithValue:date inEntity:@"Night"];
//    for(Night *night in objects)
//    {
//        NSManagedObject *food = [self getOneDataWithAttribute:@"foodId" inNumberValue:[night foodId] inEntity:@"Food"];
//        nightCalories += [[food valueForKey:nutrition] doubleValue];
//    }
//    
//    return nightCalories;
//}

//#pragma mark - Remove

///*
// * 기능 : 특정 엔터티의 모든 데이터를 삭제한다
// * 파라메터 : 삭제를 원하는 엔터티(NSString)
// * 반환값 : 없음
// */
//- (void)removeAllEntityDataWithEntity:(NSString *)entityForName{
//    request = [[NSFetchRequest alloc] init];
//    
//    // param에서 받아온 Entity이름으로 조건 설정
//    [request setEntity:[NSEntityDescription entityForName:entityForName inManagedObjectContext:foodContext]];
//    
//    // Value는 받아오지 않는다
//    [request setIncludesPropertyValues:NO];
//    
//    error = nil;
//    
//    // 설정한 조건에 맞는 값들을 배열에 저장한다
//    NSArray* datas = [foodContext executeFetchRequest:request error:&error];
//    [request release];
//    
//    // 배열의 모든 값들을 삭제한다
//    for(NSManagedObject *data in datas)
//    {
//        [foodContext deleteObject:data];
//    }
//    
////    NSLog(@"All Objects are deleted");
//    NSError * saveError = nil;
//    [foodContext save:&saveError];
//}
//
///*
// * 기능 : 특정 엔터티에 원하는 값을 삭제한다
// * 파라메터 : 삭제를 원하는 분류(NSString), 삭제할 값(NSString), 특정 엔터티(NSString)
// * 반환값 : 없음
// */
//- (void)removeOneEntityDataWithAttribute:(NSString *)attribute WithValue:(NSString*)value inEntity:(NSString *)entityForName
//{
//    
//    request = [[NSFetchRequest alloc] init];
//    
//    // Predicate 설정, param에서 받아온 searchingName에 맞는 값을 찾도록 조건 설정
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(%@ = %@)", attribute, value];
//    
//    // param에서 받아온 Entity이름과 설정한 Predicate를 건네주어 원하는 값을 찾아 오도록 조건 설정
//    [request setEntity:[NSEntityDescription entityForName:entityForName inManagedObjectContext:foodContext]];
//    [request setPredicate:pred];
//    [request setIncludesPropertyValues:NO];
//    
//    error = nil;
//    
//    // datas 배열에 설정한 조건에 일치하는 값들을 저장한다
//    NSArray* datas = [foodContext executeFetchRequest:request error:&error];
//    [request release];
//    
//    // 배열에 있는걸 하나씩 삭제한다
//    for(NSManagedObject* data in datas)
//    {
//        [foodContext deleteObject:data];
//    }
//    
////    NSLog(@"Object is deleted");
//    
//    NSError* saveError = nil;
//    [foodContext save:&saveError];
//}
//
//- (void)removeAllFoodWithDate:(NSString*)date WithEntity:(NSString *)entityForName
//{
//    NSArray * list = [self getSomeDataWithAttribute:@"date" WithValue:date inEntity:entityForName];
//    
//    for(NSManagedObject* food in list)
//    {
//        [foodContext deleteObject:food];
//    }
//    
//    NSError* saveError = nil;
//    [foodContext save:&saveError];
//}
//
//

@end

