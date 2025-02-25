//
//  FoodDeliveryModuleHeader.m
//  LiveActivityExample
//
//  Created by Zeeshan Mazhar2 on 25/02/2025.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(FoodDelivery, NSObject)

RCT_EXTERN_METHOD(startActivity)
RCT_EXTERN_METHOD(endActivity)
RCT_EXTERN_METHOD(updateActivity:(NSString *)name driverName:(NSString *)driverName deliveryTime:(NSString *)deliveryTime)

@end
