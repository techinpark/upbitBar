//
//  Localized.swift
//  upbitBar
//
//  Created by Fernando on 2021/03/09.
//

import Foundation

struct Localized {
    
    static let refresh = NSLocalizedString("app_refresh", comment: "♻️ 새로고침")
    static let setting = NSLocalizedString("app_setting", comment: "⚙️ 설정")
    static let quit = NSLocalizedString("app_quit", comment: "🚪 종료")
    
    /// SettingViewController
    static let settingTitle = NSLocalizedString("setting_title", comment: "Wellcome to upbitBar")
    static let autoLaunch = NSLocalizedString("setting_auto_launch", comment: "Automatically start at Login")
    static let accessToken = NSLocalizedString("access_token_title", comment: "Access Key")
    static let secretToken = NSLocalizedString("secret_token_title", comment: "Secret Key")
    static let refreshTime = NSLocalizedString("refresh_time_title", comment: "Refresh Time")
    
    static let settingQuit = NSLocalizedString("setting_quit", comment: "Quit")
    static let settingHelpFeedback = NSLocalizedString(("setting_help_feedback"), comment: "Help & Feedback")
    static let settingSave = NSLocalizedString("setting_save", comment: "Save")
    
    static let settingAlertTitle = NSLocalizedString("setting_alert_title", comment: "알림")
    static let settingAlertAccessTokenInfoText = NSLocalizedString("setting_alert_accesstoken_info", comment: "")
    static let settingAlertRefreshTokenInfoText = NSLocalizedString("setting_alert_refreshtoken_info", comment: "")
    static let ok = NSLocalizedString("ok", comment: "확인")
    
    static let oneMinutes = NSLocalizedString("one_minutes", comment: "")
    static let fiveMinutes = NSLocalizedString("five_minutes", comment: "")
    static let tenMinutes = NSLocalizedString("ten_minutes", comment: "")
    static let fifteenMinues = NSLocalizedString("fifteen_minutes", comment: "")
}
