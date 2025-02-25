//
//  FoodDeliveryModule.swift
//  LiveActivityExample
//
//  Created by Zeeshan Mazhar2 on 25/02/2025.
//

import Foundation
import ActivityKit

struct FoodDeliveryAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Properties to store the activity state
        var leadingName: String
        var deliveryTime: String
    }

    // Properties that define the overall activity
    var name: String
}

@objc(FoodDelivery)
class FoodDelivery: NSObject {
  
  @objc(startActivity)
  func startActivity() {
    print("startActivity Method called")
    do {
      if #available(iOS 16.1, *) {
        let foodDeliveryAttributes = FoodDeliveryAttributes(name: "Food Delivery")
        let foodDeliveryContentState = FoodDeliveryAttributes.ContentState(leadingName: "Driver Name", deliveryTime: "Order Placed")
        let activity = try Activity<FoodDeliveryAttributes>.request(
          attributes: foodDeliveryAttributes,
          contentState: foodDeliveryContentState,
          pushType: nil
        )
      } else {
        print("Dynamic Island and live activities not supported")
      }
    } catch {
      print("Error starting activity: \(error.localizedDescription)")
    }
  }
  
  @objc(updateActivity:driverName:deliveryTime:)
  func updateActivity(_ name: String, driverName: String, deliveryTime: String) {
      do {
          if #available(iOS 16.1, *) {
              let foodDeliveryContentState = FoodDeliveryAttributes.ContentState(leadingName: driverName, deliveryTime: deliveryTime) // Use driverName and deliveryTime parameters
              Task {
                  for activity in Activity<FoodDeliveryAttributes>.activities {
                      await activity.update(using: foodDeliveryContentState)
                  }
              }
          }
      } catch {
          print("Error updating activity: \(error.localizedDescription)")
      }
  }
  
  @objc(endActivity)
  func endActivity() {
    Task {
      for activity in Activity<FoodDeliveryAttributes>.activities {
        await activity.end()
      }
    }
  }
}
