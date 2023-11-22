//
//  UploadWidgetLiveActivity.swift
//  UploadWidget
//
//  Created by Gavin Xiang on 2023/11/21.
//  Copyright © 2023 PlanetArt. All rights reserved.
//

import ActivityKit
import WidgetKit
import SwiftUI

@objcMembers
@available(iOS 16.1, *)
@objc public class UploadWidgetManager: NSObject {
    static let shared = UploadWidgetManager()
    private override init() { super.init() }
    
//    @EnvironmentObject private var vm : DynamicIslandViewModel
//    @StateObject private var vm = DynamicIslandViewModel()
    private var vm = DynamicIslandViewModel()
    
//    var activity: Activity<UploadWidgetAttributes>? = nil
    
    public func start() {
//        let attributes = UploadWidgetAttributes(name: "World")
//        let contentState = UploadWidgetAttributes.ContentState.smiley
//        do {
//            if #available(iOS 16.2, *) {
//                let activityContent = ActivityContent(state: contentState, staleDate: nil)
//                self.activity = try Activity<UploadWidgetAttributes>.request(attributes: attributes, content: activityContent)
//            } else {
//                 // Fallback on earlier versions
//                self.activity = try Activity<UploadWidgetAttributes>.request(attributes: attributes, contentState: contentState)
//            }
//        } catch let error {
//            print("[UploadWidget]:\(error.localizedDescription)")
//        }
        vm.setActiviy()
    }
    
    public func update() {
//        let contentState = UploadWidgetAttributes.ContentState.starEyes
//        Task {
//            if #available(iOS 16.2, *) {
//                let activityContent = ActivityContent(state: contentState, staleDate: nil)
//                await activity?.update(activityContent)
//            } else {
//                await activity?.update(using: contentState)
//            }
//        }
    }
    
    public func end() {
//        Task {
//            await activity?.end()
//        }
        vm.stopActivityAnyway()
    }
}

//NOTE: Replace UploadWidgetAttributes with ActivityAttributesDynamicIsland

//struct UploadWidgetAttributes: ActivityAttributes {
//    public struct ContentState: Codable, Hashable {
//        // Dynamic stateful properties about your activity go here!
//        var emoji: String
//    }
//
//    // Fixed non-changing properties about your activity go here!
//    var name: String
//}

@available(iOS 16.1, *)
struct UploadWidgetLiveActivity: Widget {
    
    @State private var selectedDataType : DynamicIslandViewType.DataType = .delivery
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ActivityAttributesDynamicIsland.self) { context in
            // Lock screen/banner UI goes here
            VStack {
//                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)
            .onAppear {
                setViewType(rawValue: context.attributes.dataType)
            }

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading").opacity(0)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing").opacity(0)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    // Text("Bottom \(context.state.emoji)")
                    switch selectedDataType {
                    case .taxi:
                        TaxiExpandedView(
                            taxi: Taxi(rawValue: context.state.state)!,
                            percent: context.state.percent,
                            minute: Int(context.state.value),
                            subTitle: context.state.description)
                    case .delivery:
                        DeliveryExpandedView(
                            delivery: Delivery(rawValue: context.state.state)!,
                            percent: context.state.percent,
                            minute: Int(context.state.value),
                            subTitle: context.state.description)
                    }
                    // more content
                }
            } compactLeading: {
//                Text("L")
                HStack{
                    Image(systemName: selectedDataType == .delivery ? "bag.fill" : "car.fill")
                        .foregroundColor(selectedDataType == .delivery ? .orange : .purple)
                    Text(selectedDataType == .delivery ? "Order" : "Taxi")
                }
            } compactTrailing: {
//                Text("T \(context.state.emoji)")
                HStack(spacing: 3){
                    Image(systemName: "clock")
                    
                    Text("\(Int(context.state.value))m")
                }
                .font(.subheadline)
                .padding(.horizontal, 4)
                .padding(.vertical,3)
                .background(selectedDataType == .delivery ? .orange : .purple)
                .cornerRadius(4)
            } minimal: {
//                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "https://www.freeprintsapp.com"))//custom url
            .keylineTint(Color.red)
        }
    }
    
    func setViewType(rawValue: Int){
        switch rawValue {
        case DynamicIslandViewType.DataType.taxi.rawValue: selectedDataType = .taxi
            case DynamicIslandViewType.DataType.delivery.rawValue: selectedDataType = .delivery
        default:
            break
        }
    }
}

//extension UploadWidgetAttributes {
//    fileprivate static var preview: UploadWidgetAttributes {
//        UploadWidgetAttributes(name: "World")
//    }
//}
//
//extension UploadWidgetAttributes.ContentState {
//    fileprivate static var smiley: UploadWidgetAttributes.ContentState {
//        UploadWidgetAttributes.ContentState(emoji: "😀")
//     }
//
//     fileprivate static var starEyes: UploadWidgetAttributes.ContentState {
//         UploadWidgetAttributes.ContentState(emoji: "🤩")
//     }
//}
//
//@available(iOS 17.0, *)
//#Preview("Notification", as: .content, using: UploadWidgetAttributes.preview) {
//   UploadWidgetLiveActivity()
//} contentStates: {
//    UploadWidgetAttributes.ContentState.smiley
//    UploadWidgetAttributes.ContentState.starEyes
//}
