//
//  PermissionViewModel.swift
//  Stoplight-NC2
//
//  Created by kyungsoolee on 6/14/24.
//

import Foundation
import SwiftUI

class PermissionViewModel: ObservableObject {
    @Published var isViewLoaded = false
    @Published var isSheetActive = false
    
    let HEADER_ICON_LABEL = "info.circle.fill"
    
    let DECORATION_TEXT_INFO = (
        imgSrc: "AppSymbol",
        title: "NC2",
        subTitle: "Screen Time API",
        author: "Liver & Harae"
    )
    
    let PERMISSION_BUTTON_LABEL = "시작하기"
    
    let SHEET_INFO_LIST = [
        "🐦‍🔥 NC2 ScreenTime API 🐦‍🔥",
        "일일 앱 사용 시간을 설정하고, 사용 시간이 넘어가게 된다면 사용자에게 알림을 주는 앱입니다."
    ]
}

extension PermissionViewModel {
    func handleTranslationView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                self.isViewLoaded = true
            }
        }
    }
    
    func showIsSheetActive() {
        isSheetActive = true
    }
    
    @MainActor
    func handleRequestAuthorization() {
        FamilyControlsManager.shared.requestAuthorization()
    }
}
