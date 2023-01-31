//
//  Registiration.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 28.01.2023.
//

import SwiftUI
import PhotosUI

struct Registiration: View {
    @State private var email = ""
    @State private var password = ""
    @State private var fullname = ""
    @State private var username = ""
    
    @State private var selectedItem = [PhotosPickerItem]()
    @State private var data: Data?
    
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Get started.")
                Text("Create your account.")
                    .foregroundColor(.orange)
            }
            .font(.largeTitle).bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 40) {
                #warning("Make the pic selection in another view")
                
                
                if let data {
                    if let image = UIImage(data: data) {
                        PhotosPicker(selection: $selectedItem, maxSelectionCount: 1, matching: .images) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .frame(width: 140, height: 140)
                                .overlay {
                                    Circle()
                                        .stroke(LinearGradient(colors: [.orange, .orange, .orange, .black], startPoint: .top, endPoint: .bottom), lineWidth: 3)
                                        .frame(width: 140, height: 140)
                                }
                        }.onChange(of: selectedItem) { newValue in
                            guard let item = selectedItem.first else { return }
                            item.loadTransferable(type: Data.self) { result in
                                switch result {
                                case .success(let data):
                                    guard let data else { return }
                                    self.data = data
                                case .failure(let failure):
                                    print(failure)
                                }
                            }
                        }
                    }
                } else {
                    PhotosPicker(selection: $selectedItem, maxSelectionCount: 1, matching: .images) {
                        Image(systemName: "person")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .foregroundColor(.black)
                            .overlay {
                                Circle()
                                    .stroke(.black, lineWidth: 3)
                                    .frame(width: 140, height: 140)
                            }
                            .frame(height: 140)
                    }.onChange(of: selectedItem) { newValue in
                        guard let item = selectedItem.first else { return }
                        item.loadTransferable(type: Data.self) { result in
                            switch result {
                            case .success(let data):
                                guard let data else { return }
                                self.data = data
                            case .failure(let failure):
                                print(failure)
                            }
                        }
                    }
                }
                
                
                CustomTextField(image: "envelope", placeholder: "email", text: $email, isSecure: false)
                    .keyboardType(.emailAddress)
                CustomTextField(image: "person", placeholder: "username", text: $username, isSecure: false)
                CustomTextField(image: "person", placeholder: "fullname", text: $fullname, isSecure: false)
                CustomTextField(image: "lock", placeholder: "password", text: $password, isSecure: true)
            }
            .padding([.horizontal], 32)
            
            Button {
                if let data {
                    if let image = UIImage(data: data) {
                        authVM.createAccountWithEmail(email: email, username: username, fullname: fullname, password: password, image: image)
                    }
                }
                
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(height: 50)
                    .background(.orange)
                    .clipShape(Capsule())
                    .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.horizontal).padding(.top, 24)
            }
            
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 4) {
                    Text("Already have an account?")
                        .font(.system(size: 14))
                    Text("Sign in.")
                        .font(.system(size: 14)).fontWeight(.semibold)
                }
                .foregroundColor(.black)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .padding()
    }
}

struct Registiration_Previews: PreviewProvider {
    static var previews: some View {
        Registiration()
            .environmentObject(AuthViewModel())
    }
}



