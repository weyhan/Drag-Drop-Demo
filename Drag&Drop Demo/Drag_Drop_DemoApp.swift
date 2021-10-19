//
//  Drag_Drop_DemoApp.swift
//  Drag&Drop Demo
//
//  Created by WeyHan Ng on 17/10/2021.
//

import SwiftUI

@main
struct Drag_Drop_DemoApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ZStack {
                EmptyView()
            }
            .hidden()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem?
    var popOver = NSPopover()
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApplication.shared.setActivationPolicy(.accessory)
        DispatchQueue.main.async {
            NSApplication.shared.activate(ignoringOtherApps: true)
            NSApplication.shared.windows.first!.makeKeyAndOrderFront(self)
        }

        let menuView = MenuView()

        popOver.behavior = .transient
        popOver.animates = true
        popOver.contentViewController = NSViewController()
        popOver.contentViewController?.view = NSHostingView(rootView: menuView)

        popOver.contentViewController?.view.window?.makeKey()

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let menuButton = statusItem?.button {
            menuButton.image = NSImage(systemSymbolName: "photo.fill", accessibilityDescription: nil)
            menuButton.action = #selector(menuButtonToggle)
        }
    }

    @objc func menuButtonToggle(sender: AnyObject) {
        if popOver.isShown {
            popOver.performClose(sender)
        } else {
            if let menuButton = statusItem?.button {
                popOver.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: .minY)
            }

        }
    }
}
