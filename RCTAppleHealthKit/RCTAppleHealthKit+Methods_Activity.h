//
//  RCTAppleHealthKit+Methods_Activity.h
//  RCTAppleHealthKit
//
//  Created by Alexander Vallorosi on 4/27/17.
//  Copyright © 2017 Alexander Vallorosi. All rights reserved.
//
#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Activity)

- (void)activity_getActiveEnergyBurned:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)activity_getAppleExerciseTime:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)activity_saveAppleExerciseTime:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)activity_saveActiveEnergyBurned:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)activity_getWorkout:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
