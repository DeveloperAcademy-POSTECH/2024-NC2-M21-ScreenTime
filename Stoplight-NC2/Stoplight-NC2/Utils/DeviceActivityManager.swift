//
//  DeviceActivityManager.swift
//  Stoplight-NC2
//
//  Created by kyungsoolee on 6/14/24.
//

import Foundation
import DeviceActivity
import ManagedSettings

// MARK: - 모니터링 관련 동작을 제어하는 클래스
class DeviceActivityManager: ObservableObject {
    static let shared = DeviceActivityManager()
    private init() {}
    
    /// DeviceActivityCenter는 설정한 스케줄에 대한 모니터링을 제어해주는 클래스
    /// 모니터링 시작 및 중단 등의 동작 처리를 위해 인스턴스를 생성
    let deviceActivityCenter = DeviceActivityCenter()
    
    // MARK: - Device Activity 활동 모니터링을 시작하는 메서드
    func handleStartDeviceActivityMonitoring(
        startTime: DateComponents,
        endTime: DateComponents,
        deviceActivityName: DeviceActivityName = .daily,
        warningTime: DateComponents = DateComponents(minute: 5)
    ) {
        let schedule: DeviceActivitySchedule
        
        if deviceActivityName == .daily {
            schedule = DeviceActivitySchedule(
                intervalStart: startTime,
                intervalEnd: endTime,
                repeats: true,
                warningTime: warningTime // warningTime을 활용하여, 특정 이벤트 시점 전에 알림 주기 가능
            )
            
            do {
                /// deviceActivityName 인자로 받은 이름의 Device Activity에 대해 schedule로 입력받은 기간의 모니터링 시작
                try deviceActivityCenter.startMonitoring(deviceActivityName, during: schedule)
                
                /// 현재 모니터링중인 DeviceActivityName과 스케줄 확인 로그
//                print("\n\n🐵 Device Activity 활동 모니터링 시작 로그 🐵")
//                print("[모니터링 시작] \(deviceActivityCenter.activities.description)")
//                print("[스케줄] \(schedule)")
//                print("\n\n")
            } catch {
                print("Unexpected error: \(error).")
            }
        }
    }
    
    // MARK: - Device Activity 활동 모니터링을 중단하는 메서드
    func handleStopDeviceActivityMonitoring() {
        /// 모든 모니터링을 중단합니다.
        deviceActivityCenter.stopMonitoring()
        
        /// 모니터링 중단 로그
//        print("\n\n🐵 Device Activity 활동 모니터링 중단 로그 🐵")
//        print("[모니터링 중단] \(deviceActivityCenter.activities.description)")
//        print("\n\n")
    }
}

// MARK: - Schedule Name List
extension DeviceActivityName {
    static let daily = Self("daily")
}

// MARK: - MAnagedSettingsStore List
extension ManagedSettingsStore.Name {
    static let daily = Self("daily")
}
