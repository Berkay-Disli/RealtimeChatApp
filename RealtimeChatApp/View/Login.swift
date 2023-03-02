//
//  Login.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 28.01.2023.
//

import SwiftUI

struct Login: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var navVM: NavigationViewModel
    
    var body: some View {
        
        NavigationView {
            let primaryColor = Color("pri")
            VStack {
                //header
                VStack(alignment: .leading) {
                    Text("Hello.")
                    Text("Welcome back.")
                        .foregroundColor(primaryColor)
                }
                .font(.largeTitle).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                
                VStack(spacing: 40) {
                    CustomTextField(image: "envelope", placeholder: "email", text: $email, isSecure: false, textContentType: .emailAddress)
                    
                    CustomTextField(image: "lock", placeholder: "password", text: $password, isSecure: true, textContentType: nil)
                }
                .padding([.horizontal, .top], 32)
                
                NavigationLink {
                    Text("Reset password page..")
                } label: {
                    Text("Forgot Password?")
                        .font(.system(size: 13)).fontWeight(.semibold)
                        .foregroundColor(primaryColor)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                }

                
                
                Button {
                    //authVM.signInWithEmail(email: email, password: password)
                    Task {
                        do {
                            try await authVM.signInWithEmailAsync(email: email, password: password)
                        } catch {
                            await authVM.setError(error)
                        }
                    }
                } label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .frame(height: 50)
                        .background(primaryColor)
                        .clipShape(Capsule())
                        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
                        .padding(.horizontal)
                }


                
                Spacer()
                
                NavigationLink {
                    Registiration()
                } label: {
                    HStack(spacing: 4) {
                        Text("Don't have an account?")
                            .font(.system(size: 14))
                        Text("Sign up.")
                            .font(.system(size: 14)).fontWeight(.semibold)
                    }
                    .foregroundColor(primaryColor)
                }
            }
            .padding()
            .background(Color("bg"))
            .overlay {
                if authVM.loadingAnimation {
                    ProgressView()
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                }
            }
            //.padding(.top, -90) // Had to do it.
            .alert(authVM.errorMessage, isPresented: $authVM.showError, actions: {})
        }
        .toolbar(.hidden)
        
        
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
            .environmentObject(AuthViewModel())
            .environmentObject(NavigationViewModel())
    }
}
