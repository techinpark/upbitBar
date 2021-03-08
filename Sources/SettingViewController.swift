//
//  SettingViewController.swift
//  upbitBar
//
//  Created by Fernando on 2021/03/08.
//

import Cocoa
import Then
import SnapKit
import LaunchAtLogin


class SettingViewController: NSViewController {
    
    private struct Consts {
        static let accessTokenFieldFrame = NSRect(x: 0, y: 0, width: 300, height: 30)
        static let refreshTokenFieldFrame = NSRect(x: 0, y: 40, width: 300, height: 30)
    }
    
    private struct Localized {
        static let autoLaunch = NSLocalizedString("Automatically start at Login", comment: "Automatically start at Login")
        static let accessToken = "Access Token"
        static let refreshToken = "Refresh Token"
        static let refreshTime = "Refresh Time"
    }

    private var keys = UPbitKeys()
    
    private let accessTokenField = NSTextField().then {
        $0.frame = Consts.accessTokenFieldFrame
    }
    
    private let refreshTokenField = NSTextField().then {
        $0.frame = Consts.refreshTokenFieldFrame
    }
    
    private let accessTokenLabel = NSTextField().then {
        $0.stringValue = "Access Token"
        $0.isBezeled = false
        $0.isEditable = false
        $0.backgroundColor = .clear
        $0.sizeToFit()
    }
    
    private let refreshTokenLabel = NSTextField().then {
        $0.stringValue = "Refresh Token"
        $0.isBezeled = false
        $0.isEditable = false
        $0.backgroundColor = .clear
        $0.sizeToFit()
    }
    
    private let refreshTimeLabel = NSTextField().then {
        $0.stringValue = "Refresh Time"
        $0.isBezeled = false
        $0.isEditable = false
        $0.backgroundColor = .clear
        $0.sizeToFit()
    }
    
    private let refreshTimeCheckbox = NSPopUpButton().then {
        $0.addItem(withTitle: "1분")
        $0.addItem(withTitle: "5분")
        $0.addItem(withTitle: "10분")
        $0.addItem(withTitle: "15분")
    }
    
    private let quitButton = NSButton().then {
        $0.title = "Quit"
        $0.action = #selector(onQuitTap)
        $0.bezelStyle = .rounded
    }
    
    private let helpButton = NSButton().then {
        $0.title = "Help & Feedback"
        $0.action = #selector(onHelpTap)
        $0.bezelStyle = .rounded
    }
    
    private let saveButton = NSButton().then {
        $0.title = "Save"
        $0.action = #selector(onSaveTap)
        $0.bezelStyle = .rounded
        $0.keyEquivalent = "\r"
        $0.highlight(true)
    }
    
    private let startAtLoginButton = NSButton(checkboxWithTitle: Localized.autoLaunch, target: nil, action: #selector(setupLaunchToggle)).then {
        $0.state = LaunchAtLogin.isEnabled ? .on : .off
    }
    
    
    override func loadView() {
        let rect = NSRect(x: 0, y: 0, width: 480, height: 240)
        view = NSView(frame: rect)
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
        
        
        view.addSubview(accessTokenLabel)
        view.addSubview(accessTokenField)
        view.addSubview(refreshTokenLabel)
        view.addSubview(refreshTokenField)
        view.addSubview(refreshTimeLabel)
        view.addSubview(refreshTimeCheckbox)
        view.addSubview(startAtLoginButton)
        view.addSubview(quitButton)
        view.addSubview(helpButton)
        view.addSubview(saveButton)
        
        
        accessTokenField.stringValue = keys.accessToken
        refreshTokenField.stringValue = keys.refreshToken
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        accessTokenLabel.snp.makeConstraints  {
            $0.top.equalToSuperview().offset(50)
            $0.left.equalToSuperview().offset(10)
        }
        
        accessTokenField.snp.makeConstraints {
            $0.centerY.equalTo(accessTokenLabel.snp.centerY)
            $0.left.equalTo(accessTokenLabel.snp.right).offset(30)
        }
        
        refreshTokenLabel.snp.makeConstraints {
            $0.top.equalTo(accessTokenLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(10)
        }
        
        refreshTokenField.snp.makeConstraints {
            $0.centerY.equalTo(refreshTokenLabel.snp.centerY)
            $0.left.equalTo(refreshTokenLabel.snp.right).offset(30)
        }
        
        
        refreshTimeLabel.snp.makeConstraints {
            $0.top.equalTo(refreshTokenField.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(10)
        }
        
        refreshTimeCheckbox.snp.makeConstraints {
            $0.centerY.equalTo(refreshTimeLabel.snp.centerY)
            $0.left.equalTo(refreshTimeLabel.snp.right).offset(30)
        }
        
        startAtLoginButton.snp.makeConstraints {
            $0.top.equalTo(refreshTimeCheckbox.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(10)
        }
        
        quitButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.left.equalToSuperview().offset(20)
            $0.size.equalTo(CGSize(width: 100, height: 20))
        }
        
        helpButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.left.equalTo(quitButton.snp.right).offset(20)
            $0.size.equalTo(CGSize(width: 120, height: 20))
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.right.equalToSuperview().offset(-20)
            $0.size.equalTo(CGSize(width: 100, height: 20))
        }
    }
    
    // MARK: Private functions
    
    @objc func setupLaunchToggle() {
        LaunchAtLogin.isEnabled.toggle()
    }
    
    @objc func onQuitTap() {
        NSApp.stopModal()
    }
    
    @objc func onHelpTap() {
        print("onHelpTap")
    }
    
    @objc func onSaveTap() {
        print("onSaveTap")
        
        let accessToken = accessTokenField.stringValue
        let refreshToken = refreshTokenField.stringValue
        
        if accessToken.isEmpty {
            
            let alert = NSAlert()
            alert.alertStyle = .warning
            alert.messageText = "알림"
            alert.informativeText = "access token을 채워주세요"
            alert.addButton(withTitle: "확인")
            if alert.runModal() == .alertFirstButtonReturn {
                
            }
        } else if refreshToken.isEmpty {
            
            let alert = NSAlert()
            alert.messageText = "알림"
            alert.informativeText = "refresh token을 채워주세요"
            alert.addButton(withTitle: "확인")
            if alert.runModal() == .alertFirstButtonReturn {
                
            }
        }
        
        print(refreshTimeCheckbox.titleOfSelectedItem)
       
        keys.accessToken = accessToken
        keys.refreshToken = refreshToken
        
        NotificationCenter.default.post(name: .neededRefresh, object: nil)
        NSApp.stopModal()
    }
    
}
