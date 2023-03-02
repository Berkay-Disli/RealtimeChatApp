//
//  SettingsView.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 2.03.2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Settings will be here 😏")
            }
            .vAlign(.center).hAlign(.center)
            .background(Color("bg"))
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TabManager()
            .environmentObject(NavigationViewModel())
            .environmentObject(AuthViewModel())
    }
}
