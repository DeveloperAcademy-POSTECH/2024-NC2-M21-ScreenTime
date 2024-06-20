//
//  Stoplight_NC2App.swift
//  Stoplight-NC2
//
//  Created by kyungsoolee on 6/13/24.
//

import SwiftUI

@main
struct ScreenTime_BarebonesApp: App {
    @StateObject var familyControlsManager = FamilyControlsManager.shared
    @StateObject var viewModel = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            VStack {
                if !familyControlsManager.hasScreenTimePermission {
                    PermissionView()
                } else {
                    ReportView()
                }
            }
            .onReceive(familyControlsManager.authorizationCenter.$authorizationStatus) { newValue in
                DispatchQueue.main.asyncAfter(deadline: .now()/* + 0.6*/) {
                    familyControlsManager.updateAuthorizationStatus(authStatus: newValue)
                }
            }
            .environmentObject(familyControlsManager)
            .environmentObject(viewModel)
        }
    }
}
