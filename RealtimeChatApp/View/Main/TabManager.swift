//
//  TabManager.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 2.03.2023.
//

import SwiftUI

struct TabManager: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var navVM: NavigationViewModel
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                switch navVM.selectedTab {
                case .feed:
                    FeedView()
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                case .newPost:
                    NewPostView()
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                case .profile:
                    ProfileView()
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                case .settings:
                    SettingsView()
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                }
                
                if navVM.navBarIsShown {
                    VStack(spacing: 0) {
                        Divider()
                        HStack(alignment: .bottom) {
                            ForEach(Tabs.allCases, id:\.self) { tabItem in
                                VStack(spacing: 4) {
                                    Image(systemName: navVM.selectedTab == tabItem ? "\(tabItem.icon).fill":tabItem.icon)
                                        .font(.system(size: 21))
                                    Text(tabItem.title)
                                        .font(.system(size: 13))
                                }
                                .foregroundColor(navVM.selectedTab == tabItem ? Color("pri"):.black.opacity(0.7))
                                .padding(.horizontal)
                                .padding(.top, 4)
                                .hAlign(.center)
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        navVM.changeNavigationTab(tabItem)
                                    }
                                }
                            }
                        }
                    }
                    .background(.regularMaterial)
                }
                
                
            }
        }
    }
}

struct TabManager_Previews: PreviewProvider {
    static var previews: some View {
        TabManager()
            .environmentObject(AuthViewModel())
            .environmentObject(NavigationViewModel())
    }
}
