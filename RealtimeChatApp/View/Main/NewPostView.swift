//
//  NewPostView.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 2.03.2023.
//

import SwiftUI

struct NewPostView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("New Post View will be here 😏")
            }
            .vAlign(.center).hAlign(.center)
            .background(Color("bg"))
            .navigationTitle("New Post")
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        TabManager()
            .environmentObject(NavigationViewModel())
            .environmentObject(AuthViewModel())
    }
}
