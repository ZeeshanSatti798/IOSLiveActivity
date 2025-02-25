//
//  FoodDeliveryLiveActivity.swift
//  FoodDelivery
//
//  Created by Zeeshan Mazhar2 on 25/02/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

//struct FoodDeliveryAttributes: ActivityAttributes {
//    public struct ContentState: Codable, Hashable {
//        // Properties to store the activity state
//        var leadingName: String
//        var deliveryTime: String
//    }
//
//    // Properties that define the overall activity
//    var name: String
//}

extension Color {
    static let customPurple = Color(red: 151 / 255, green: 25 / 255, blue: 185 / 255)
}

let dynamicValue = 1234

struct FoodDeliveryLiveActivity: Widget {
  @State private var progressValue: Double = 0.6 // Set initial progress value

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FoodDeliveryAttributes.self) { context in
            // Lock screen/banner UI configuration
            ZStack {

                HStack {
                    VStack(alignment: .leading) {
                      Text("LiveActivity")
                        .font(.title3)
                          .foregroundColor(.white)
                      Spacer()
                        Text(context.state.deliveryTime) // Display delivery time dynamically
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(context.state.leadingName) // Display driver name dynamically
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }

                    Spacer()

                    Image("CarImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
//                        .clipShape(Circle())
                }
                .padding()
                .background(Color.black.opacity(0.3))
                .cornerRadius(12)
            }
            .activityBackgroundTint(Color.customPurple.opacity(0)) // Optional tint for compatibility
            .activitySystemActionForegroundColor(Color.white)
            .widgetURL(URL(string: "localhost://widgetOpen?value=\(dynamicValue)"))
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Image("CarImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }
                DynamicIslandExpandedRegion(.trailing) {
                    VStack(alignment: .trailing) {
//                        Text(context.state.deliveryTime) // Display delivery time dynamically
//                            .font(.headline)
                        Text(context.state.leadingName) // Display driver name dynamically
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
//                        Image(systemName: "person.circle")
                      Text(context.state.deliveryTime) // Display delivery time dynamically
                          .font(.headline)
                        Spacer()
                        Image(systemName: "car.fill")
                    }
                    .padding()
                }
            } compactLeading: {
                Text("🚗")
            } compactTrailing: {
                Text(context.state.deliveryTime) // Display dynamic delivery time
            } minimal: {
                Text("2m")
            }
            .widgetURL(URL(string: "localhost://widgetOpen?value=\(dynamicValue)"))
            .keylineTint(Color.customPurple)
        }
    }
}
