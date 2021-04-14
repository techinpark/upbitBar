//
//  AppDelegate.swift
//  upbitBar
//
//  Created by Fernando on 2021/03/07.
//

import Cocoa
import Then

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    private struct Consts {
        static let cryptoTags = 99
    }
    
    private var statusItem: NSStatusItem?
    private var refreshTimer: Timer?
    private var keys = UPbitKeys()
    
    private let menu = NSMenu().then {
        $0.title = ""
    }

    private let refreshMenuItem = NSMenuItem().then {
        $0.title = Localized.refresh
        $0.action = #selector(onRefreshTap)
        $0.tag = 1
        $0.keyEquivalent = "r"
    }
    
    private let settingMenuItem = NSMenuItem().then {
        $0.title = Localized.setting
        $0.action = #selector(onSettingTap)
        $0.tag = 2
        $0.keyEquivalent = "s"
    }
    
    private let quitMenuItem = NSMenuItem().then {
        $0.title = Localized.quit
        $0.action = #selector(onQuitTap)
        $0.tag = 3
        $0.keyEquivalent = "q"
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        NotificationCenter.default.addObserver(self, selector: #selector(onDidNeedTokenSetting(_:)), name: .neededTokenSetting, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidNeedRefresh(_:)), name: .neededRefresh, object: nil)
        
        setupUI()
        getAllBalances()
        setupRefreshTimer()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func setupUI() {
        
        menu.addItem(.separator())
        menu.addItem(refreshMenuItem)
        menu.addItem(settingMenuItem)
        menu.addItem(quitMenuItem)
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.menu = menu
        
        self.statusItem?.button?.title = "Loading ... "
        
    }
    
    @objc func onDidNeedTokenSetting(_ notification: Notification) {
        self.showSettingAlert()
    }
    
    @objc func onDidNeedRefresh(_ notification: Notification) {
        self.refresh()
    }
    
    @objc func onRefreshTap() {
        self.refresh()
    }
    
    @objc func onSettingTap() {
        self.showSettingAlert()
    }
    
    @objc func onQuitTap() {
        NSApplication.shared.terminate(self)
    }
    
    @objc func onMenuItemTap() {
        //NSApplication.shared.terminate(self)
        print("menu")
    }
    
    // MARK: Private functions
    
    private func refresh() {
        invalidateRefreshTimer()
        removeAllItems()
        getAllBalances()
        setupRefreshTimer()
    }
    
    private func setupRefreshTimer() {
        
        let refreshInterval = RefreshInterval(rawValue: keys.refershInterVal)
        let timeInterval = refreshInterval?.minutes ?? 5
        
        refreshTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval( timeInterval * 60),
                                            repeats: true,
                                            block: { [weak self] _ in
                                                guard let self = self else { return }
                                                self.refresh()
                                            })
    }
    
    private func invalidateRefreshTimer() {
            refreshTimer?.invalidate()
        }
    
    private func showSettingAlert() {
        
        var window = NSWindow()
        let windowSize = NSSize(width: 480, height: 240)
        let screenSize = NSScreen.main?.frame.size ?? .zero
        let rect = NSMakeRect(screenSize.width/2 - windowSize.width/2, screenSize.height/2 - windowSize.height/2, windowSize.width, windowSize.height)
        window = NSWindow(contentRect: rect, styleMask: [.miniaturizable, .closable, .titled], backing: .buffered, defer: false)
        window.title = Localized.settingTitle
        window.contentViewController = SettingViewController()
        
        NSApp.runModal(for: window)
        NSApp.activate(ignoringOtherApps: true)
        window.orderOut(self)
    }
    
    private func removeAllItems() {
        _ = menu.items.map {
            if $0.tag == Consts.cryptoTags {
                self.menu.removeItem($0)
            }
        }
    }
    
    private func getAllBalances() {
        guard let balances = UpbitServices.shared.getBalances(),
              let allMarket = UpbitServices.shared.getAllMarket() else { return }
        
        let availableMarkets = allMarket.compactMap{ $0.market }
        let currency: [String] = balances
            .map { "\($0.unitCurrency)-\($0.currency)" }
            .filter{ market -> Bool in availableMarkets.filter{ $0 == market }.first != nil }
        
        var myCurrency: [String: Market] {
            var tempDict: [String: Market] = [:]
            for currencyItem in currency {
                tempDict[currencyItem] = allMarket.filter{ $0.market == currencyItem }.first
            }
            return tempDict
        }

        let markets = currency.joined(separator: ",")
        guard let tickers = UpbitServices.shared.getTicker(markets: markets) else { return }
        
        var totalBalances: [Double] = []
        var avgTotalBalances: [Double] = []
        
        for ticker in tickers {
            for balance in balances {
                let currentMarket = "\(balance.unitCurrency)-\(balance.currency)"
                if ticker.market == currentMarket {
                    
                    let totalAsset = Double(balance.balance) ?? 0
                    let totalPrice = Double(ticker.tradePrice) * totalAsset
                    let buyPrice = Double(balance.avgBuyPrice)! * totalAsset
                    let percent = (Double(ticker.tradePrice) / Double(balance.avgBuyPrice)!-1.0) * 100
                    
                    var emoji = "-"
                    var attributes = Attributes.cryptoNormalAttributes
                    
                    if totalPrice < buyPrice {
                        emoji = "📉"
                        attributes = Attributes.cryptoBlueAttributes
                    } else if buyPrice < totalPrice {
                        emoji = "📈"
                        attributes = Attributes.cryptoRedAttributes
                    }
                    
                    avgTotalBalances.append(buyPrice)
                    totalBalances.append(totalPrice)
                    
                    let totalString = self.convertCurrency(prefix:"", money: round(totalPrice))
                    
                    let currentCurrency = myCurrency[currentMarket]
                    let currencyName = currentCurrency?.koreanName ?? currentCurrency?.englishName ?? ""
                    
                    let title: String = "\(emoji) \(currencyName)(\(balance.currency)) - \(totalString) (\(percent.rounded())%)"
                    
                    let menuItem = NSMenuItem().then {
                        $0.isEnabled = true
                        $0.tag = Consts.cryptoTags
                        $0.action = #selector(onMenuItemTap)
                        $0.attributedTitle = NSAttributedString(string: title, attributes: attributes)
                    }
                    
                    self.menu.insertItem(menuItem, at: .zero)
                }
            }
        }
        
        let total = totalBalances.map { round($0) }.reduce(0, +)
        let avg = avgTotalBalances.map { round($0) }.reduce(0, +)
        var title = ""
        var totalAttributes = Attributes.cryptoNormalAttributes
        
        if avg < total {
            title = self.convertCurrency(prefix: "📈", money: total)
            totalAttributes = Attributes.cryptoRedAttributes
        } else if total < avg {
            title = self.convertCurrency(prefix: "📉", money: total)
            totalAttributes = Attributes.cryptoBlueAttributes
        }
        
        self.statusItem?.button?.attributedTitle = NSAttributedString(string: title, attributes: totalAttributes)
    }
    
    func convertCurrency(prefix: String, money: Double) -> String {
        
        let number = NSNumber(value: money)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let decimalString = numberFormatter.string(from: number)!
    
        return  prefix.isEmpty ? "₩\(decimalString)" : "\(prefix) ₩\(decimalString)"
    }
    
}

