//
//  NavigationViewModel.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 1.02.2023.
//

import Foundation

class NavigationViewModel: ObservableObject {
    @Published var onboarding = false
    
    init() {
        
    }
    
    func enableOnboarding() {
        onboarding = true
    }
    func disableOnboarding() {
        onboarding = false
    }
}
