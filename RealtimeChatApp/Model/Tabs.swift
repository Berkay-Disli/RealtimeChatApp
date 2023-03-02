//
//  Tabs.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 2.03.2023.
//

import Foundation

enum Tabs: String, CaseIterable {
    case feed, newPost, profile, settings
    
    var title: String {
        switch self {
        case .feed:
            return "Feed"
        case .newPost:
            return "New Post"
        case .profile:
            return "Profile"
        case .settings:
            return "Settings"
        }
    }
    
    var icon: String {
        switch self {
        case .feed:
            return "house"
        case .newPost:
            return "plus.app"
        case .profile:
            return "person"
        case .settings:
            return "gearshape"
        }
    }
    
}
