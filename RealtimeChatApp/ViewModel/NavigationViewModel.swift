//
//  NavigationViewModel.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 1.02.2023.
//

import Foundation

class NavigationViewModel: ObservableObject {
    @Published var onboarding = false
    @Published private(set) var selectedTab: Tabs = .feed
    @Published private(set) var navBarIsShown: Bool = true
    
    init() {
        
    }
    
    func enableNavBar() {
        navBarIsShown = true
    }
    
    func disableNavBar() {
        navBarIsShown = false
    }
    
    func changeNavigationTab(_ tab: Tabs) {
        selectedTab = tab
    }
    
    func enableOnboarding() {
        onboarding = true
    }
    func disableOnboarding() {
        onboarding = false
    }
}
