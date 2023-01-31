//
//  ContentView.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 28.01.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        if authVM.userSession != nil {
            Home()
                .transition(AnyTransition.opacity.animation(.easeInOut))
        } else {
            Login()
                .transition(AnyTransition.opacity.animation(.easeInOut))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
