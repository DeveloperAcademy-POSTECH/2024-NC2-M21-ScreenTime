//
//  ScreenTimeActinityReport.swift
//  ScreenTimeReport
//
//  Created by kyungsoolee on 6/14/24.
//

// MARK: - Device Activity Report 관련 데이터 모델이 정의되어 있는 파일입니다.
import Foundation
import ManagedSettings

struct ActivityReport {
    let totalDuration: TimeInterval
    let apps: [AppDeviceActivity]
}

struct AppDeviceActivity: Identifiable {
    var id: String
    var displayName: String
    var duration: TimeInterval
    var numberOfPickups: Int
    var token: ApplicationToken?
    var limitedTime: TimeInterval = 0
    
    mutating func updateLimitedTime(newTime: TimeInterval) {
        self.limitedTime = newTime
    }
}

extension TimeInterval {
    /// TimeInterval 타입 값을 00:00 형식의 String으로 변환해주는 메서드
    func toString() -> String {
        let time = NSInteger(self)
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        return String(format: "%0.2dH %0.2dM", hours,minutes)
    }
}
