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
        
        static let viewRect =  NSRect(x: 0, y: 0, width: 480, height: 240)
        static let accessTokenFieldFrame = NSRect(x: 0, y: 0, width: 300, height: 30)
        static let refreshTokenFieldFrame = NSRect(x: 0, y: 40, width: 300, height: 30)
    }
  
    private var keys = UPbitKeys()
    
    private let accessTokenField = NSTextField().then {
        $0.frame = Consts.accessTokenFieldFrame
    }
    
    private let refreshTokenField = NSTextField().then {
        $0.frame = Consts.refreshTokenFieldFrame
    }
    
    private let accessTokenLabel = NSTextField().then {
        $0.stringValue = Localized.accessToken
        $0.isBezeled = false
        $0.isEditable = false
        $0.backgroundColor = .clear
        $0.sizeToFit()
    }
    
    private let refreshTokenLabel = NSTextField().then {
        $0.stringValue = Localized.refreshToken
        $0.isBezeled = false
        $0.isEditable = false
        $0.backgroundColor = .clear
        $0.sizeToFit()
    }
    
    private let refreshTimeLabel = NSTextField().then {
        $0.stringValue = Localized.refreshTime
        $0.isBezeled = false
        $0.isEditable = false
        $0.backgroundColor = .clear
        $0.sizeToFit()
    }
    
    private let refreshTimeCheckbox = NSPopUpButton().then {
        $0.addItem(withTitle: Localized.oneMinutes)
        $0.addItem(withTitle: Localized.fiveMinutes)
        $0.addItem(withTitle: Localized.tenMinutes)
        $0.addItem(withTitle: Localized.fifteenMinues)
    }
    
    private let quitButton = NSButton().then {
        $0.title = Localized.settingQuit
        $0.action = #selector(onQuitTap)
        $0.bezelStyle = .rounded
    }
    
    private let helpButton = NSButton().then {
        $0.title = Localized.settingHelpFeedback
        $0.action = #selector(onHelpTap)
        $0.bezelStyle = .rounded
    }
    
    private let saveButton = NSButton().then {
        $0.title = Localized.settingSave
        $0.action = #selector(onSaveTap)
        $0.bezelStyle = .rounded
        $0.keyEquivalent = "\r"
        $0.highlight(true)
    }
    
    private let startAtLoginButton = NSButton(checkboxWithTitle: Localized.autoLaunch, target: nil, action: #selector(setupLaunchToggle)).then {
        $0.state = LaunchAtLogin.isEnabled ? .on : .off
    }
    
    
    override func loadView() {
        let rect = Consts.viewRect
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
        
        
       
        setupDefaultValues()
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
    
    func setupDefaultValues() {
        accessTokenField.stringValue = keys.accessToken
        refreshTokenField.stringValue = keys.refreshToken
        refreshTimeCheckbox.selectItem(at: keys.refershInterVal)
        startAtLoginButton.state = LaunchAtLogin.isEnabled ? .off : .on
    }
    
    @objc func setupLaunchToggle() {
        LaunchAtLogin.isEnabled.toggle()
    }
    
    @objc func onQuitTap() {
        NSApp.stopModal()
    }
    
    @objc func onHelpTap() {
        let url = URL(string: "https://github.com/techinpark/upbitBar")!
        NSWorkspace.shared.open(url)
    }
    
    @objc func onSaveTap() {
        print("onSaveTap")
        
        let accessToken = accessTokenField.stringValue
        let refreshToken = refreshTokenField.stringValue
        
        if accessToken.isEmpty {
            
            let alert = NSAlert()
            alert.alertStyle = .warning
            alert.messageText = Localized.settingAlertTitle
            alert.informativeText = Localized.settingAlertAccessTokenInfoText
            alert.addButton(withTitle: Localized.ok)
            if alert.runModal() == .alertFirstButtonReturn {
                
            }
        } else if refreshToken.isEmpty {
            
            let alert = NSAlert()
            alert.messageText = Localized.settingAlertTitle
            alert.informativeText = Localized.settingAlertRefreshTokenInfoText
            alert.addButton(withTitle: Localized.ok)
            if alert.runModal() == .alertFirstButtonReturn {
                
            }
        }
        
        keys.accessToken = accessToken
        keys.refreshToken = refreshToken
        keys.refershInterVal = refreshTimeCheckbox.indexOfSelectedItem
        
        NotificationCenter.default.post(name: .neededRefresh, object: nil)
        NSApp.stopModal()
    }
    
}
