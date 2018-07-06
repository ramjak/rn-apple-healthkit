//
//  RCTAppleHealthKit+Methods_Activity.m
//  RCTAppleHealthKit
//
//  Created by Alexander Vallorosi on 4/27/17.
//  Copyright © 2017 Alexander Vallorosi. All rights reserved.
//

#import "RCTAppleHealthKit+Methods_Activity.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Activity)

- (void)activity_getActiveEnergyBurned:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *activeEnergyType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    HKUnit *cal = [HKUnit kilocalorieUnit];

    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:activeEnergyType
                                unit:cal
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting active energy burned samples: %@", error);
                                  callback(@[RCTMakeError(@"error getting active energy burned samples", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)activity_saveActiveEnergyBurned:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    double activeEnergyBurned = [RCTAppleHealthKit doubleValueFromOptions:input];
    NSDate *sampleDate = [RCTAppleHealthKit dateFromOptionsDefaultNow:input];
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit kilocalorieUnit]];

    HKQuantity *activeEnergyBurnedQuantity = [HKQuantity quantityWithUnit:unit doubleValue:activeEnergyBurned];
    HKQuantityType *activeEnergyBurnedType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    HKQuantitySample *activeEnergyBurnedSample = [HKQuantitySample quantitySampleWithType:activeEnergyBurnedType quantity:activeEnergyBurnedQuantity startDate:sampleDate endDate:sampleDate];

    [self.healthStore saveObject:activeEnergyBurnedSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"error saving the activeEnergyBurned sample: %@", error);
            callback(@[RCTMakeError(@"error saving the activeEnergyBurned sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @(activeEnergyBurned)]);
    }];
}

- (void)activity_getAppleExerciseTime:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *activeEnergyType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierAppleExerciseTime];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:[NSDate date]];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    HKUnit *minute = [HKUnit minuteUnit];

    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:activeEnergyType
                                unit:minute
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting apple exercise time samples: %@", error);
                                  callback(@[RCTMakeError(@"errorgetting apple exercise time samples", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)activity_saveAppleExerciseTime:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    double exerciseTime = [RCTAppleHealthKit doubleValueFromOptions:input];
    NSDate *sampleDate = [RCTAppleHealthKit dateFromOptionsDefaultNow:input];
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit minuteUnit]];

    HKQuantity *exerciseTimeQuantity = [HKQuantity quantityWithUnit:unit doubleValue:exerciseTime];
    HKQuantityType *exerciseTimeType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierAppleExerciseTime];
    HKQuantitySample *exerciseTimeSample = [HKQuantitySample quantitySampleWithType:exerciseTimeType quantity:exerciseTimeQuantity startDate:sampleDate endDate:sampleDate];

    [self.healthStore saveObject:exerciseTimeSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"error saving the exerciseTime sample: %@", error);
            callback(@[RCTMakeError(@"error saving the exerciseTime sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @(exerciseTime)]);
    }];
}

- (void)activity_getWorkout:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKWorkoutType *type = [HKWorkoutType workoutType];

    HKUnit *unit = [HKUnit kilocalorieUnit];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];

    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:type
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"error getting workout samples: %@", error);
            callback(@[RCTMakeError(@"error getting workout samples", nil, nil)]);
            return;
        }
    }];
}

@end
