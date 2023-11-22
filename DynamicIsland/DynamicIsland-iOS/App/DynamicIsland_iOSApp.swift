//
//  DynamicIsland_iOSApp.swift
//  DynamicIsland-iOS
//
//  Created by Baris OZGEN on 8.10.2022.
//

import SwiftUI

@main
struct DynamicIsland_iOSApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var vm = DynamicIslandViewModel()
    var body: some Scene {
        WindowGroup {
            if #available(iOS 17.0, *) {
                DynamicIslandView()
                    .environmentObject(vm)
                    .onChange(of: scenePhase) { oldPhase, newPhase in
                        switch newPhase {
                        case .background:
                            print("SchenePhase: Background from \(oldPhase)")
                        case .inactive:
                            print("SchenePhase: Inactive from \(oldPhase)")
                        case .active:
                            print("SchenePhase: Active/Foreground from \(oldPhase)")
                        @unknown default:
                            print("SchenePhase: Unknown scene phase \(newPhase) from \(oldPhase)")
                        }
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
                        print("UIApplication.willTerminateNotification")
                        vm.stopActivityAnyway()
                    }
            } else {
                DynamicIslandView()
                    .environmentObject(vm)
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
                        print("UIApplication.willTerminateNotification")
                        vm.stopActivityAnyway()
                    }
            }
        }
    }
}
