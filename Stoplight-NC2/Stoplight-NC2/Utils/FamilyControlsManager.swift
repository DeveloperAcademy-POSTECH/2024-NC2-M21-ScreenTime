//
//  FamilyControlsManager.swift
//  Stoplight-NC2
//
//  Created by kyungsoolee on 6/14/24.
//

import Foundation
import FamilyControls

class FamilyControlsManager: ObservableObject {
    static let shared = FamilyControlsManager()
    private init() {}
    
    // MARK: - FamilyControls 권한 상태를 관리하는 객체
    let authorizationCenter = AuthorizationCenter.shared
    
    // MARK: - ScreenTime 권한 상태를 활용하기 위한 멤버 변수
    @Published var hasScreenTimePermission: Bool = false
    
    // MARK: - ScreenTime API 사용 권한 요청
    /// ScreenTime API를 사용하기 위한 권한 요청 메서드
    /// 해당 메서드는 ScreenTime API 사용 권한 및  hasScreenTimePermission 멤버 변수의 상태를 변경
    @MainActor
    func requestAuthorization() {
        if authorizationCenter.authorizationStatus == .approved {
            print("ScreenTime Permission approved")
        } else {
            Task {
                do {
                    try await authorizationCenter.requestAuthorization(for: .individual)
                    hasScreenTimePermission = true
                } catch {
                    print("Failed to enroll Aniyah with error: \(error)")
                    hasScreenTimePermission = false
                }
            }
        }
    }
    
    // MARK: - 스크린타임 권한 조회
    /// 현재 ScreenTime API의 권한 상태 조회 메서드
    func requestAuthorizationStatus() -> AuthorizationStatus {
        authorizationCenter.authorizationStatus
    }

    // MARK: ScreenTime 권한 취소
    /// 권한 상태가 .approve인 상태에서 메서드 호출 시
    ///  ScreenTIme  권한 상태를 .notDetermined로 변경합니다.
    func requestAuthorizationRevoke() {
        authorizationCenter.revokeAuthorization(completionHandler: { result in
            switch result {
            case .success:
                print("Success")
            case .failure(let failure):
                print("\(failure) - failed revoke Permission")
            }
        })
    }
    
    // MARK: - 권한 상태 업데이트
    /// hasScreenTimePermission의 상태를 변경하기 위한 메서드입니다.
    func updateAuthorizationStatus(authStatus: AuthorizationStatus) {
        switch authStatus {
        case .notDetermined:
            hasScreenTimePermission = false
        case .denied:
            hasScreenTimePermission = false
        case .approved:
            hasScreenTimePermission = true
        @unknown default:
            fatalError("요청한 권한설정 타입에 대한 처리는 없습니다")
        }
    }
}
