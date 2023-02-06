//
//  Home.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 30.01.2023.
//

import SwiftUI
import Kingfisher

struct Home: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var navVM: NavigationViewModel
    
    var body: some View {
        VStack {
            if let user = authVM.userSession {
                HStack {
                    KFImage(authVM.userProfileImageUrl)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.displayName ?? "No Display Name")
                            .font(.title2)
                        Text(user.email ?? "No Email")
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            Button {
                authVM.signOut()
                navVM.disableOnboarding()
            } label: {
                BigButton(title: "Sign Out", bgColor: .black, textColor: .white)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            authVM.getUserInfo()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(AuthViewModel())
            .environmentObject(NavigationViewModel())
    }
}
