//
//  ProfileView.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 2.03.2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var deleteUserAlertIsShown = false
    
    var body: some View {
        NavigationView {
            let primaryColor = Color("pri")
            VStack {
                Text("Profile View will be here 😏")
            }
            .vAlign(.center).hAlign(.center)
            .background(Color("bg"))
            .navigationTitle(authVM.userSession?.displayName ?? "Berkay")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        deleteUserAlertIsShown.toggle()
                    } label: {
                        Image(systemName: "person.fill.xmark")
                            .foregroundColor(primaryColor)
                    }
                    .alert("Delete Account", isPresented: $deleteUserAlertIsShown) {
                        Button(role: .destructive) {
                            Task {
                                do {
                                    try await authVM.deleteUser()
                                } catch {
                                    await authVM.setError(error)
                                }
                            }
                        } label: {
                            Text("Do you want to delete your account? This action cannot be undone")
                        }
                        .alert(authVM.errorMessage, isPresented: $authVM.showError, actions: {} )

                    }

                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TabManager()
            .environmentObject(NavigationViewModel())
            .environmentObject(AuthViewModel())
    }
}
