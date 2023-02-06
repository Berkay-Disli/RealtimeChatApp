//
//  MainMessagesView.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 5.02.2023.
//

import SwiftUI

struct MainMessagesView: View {
    @State private var shouldShowLogOutOptions = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 0) {
                    CustomNavBar()
                    .confirmationDialog("Settings", isPresented: $shouldShowLogOutOptions) {
                        Button(role: .cancel) {
                            print("cancel")
                        } label: {
                            Text("Cancel")
                        }
                        
                        Button(role: .destructive) {
                            print("sign out")
                        } label: {
                            Text("Sign Out")
                        }
                    } message: {
                        Text("Something")
                    }

                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(0...9, id: \.self) { _ in
                                VStack {
                                    HStack(spacing: 16) {
                                        Image("engine")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipShape(Circle())
                                            .frame(width: 60, height: 60)
                                            .overlay {
                                                Circle()
                                                    .stroke(LinearGradient(colors: [Color(.label)], startPoint: .top, endPoint: .bottom), lineWidth: 2)
                                                    .frame(width: 60, height: 60)
                                            }
                                            .padding(.leading, 1)
                                        
                                        VStack(alignment: .leading) {
                                            Text("Username")
                                                .font(.system(size: 16))
                                                .fontWeight(.bold)
                                            Text("Message sent to user")
                                                .font(.system(size: 14))
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Text("22d")
                                            .font(.system(size: 14))
                                            .fontWeight(.semibold)
                                    }
                                    Divider()
                                        .padding(.vertical, 8)
                                }
                            }
                        }
                        .padding(.top)
                    }
                }
                .padding(.horizontal)
                .toolbar(.hidden)
                
                Button {
                    
                } label: {
                    newChatBubble
                }

            }
        }
    }
    
    @ViewBuilder
    func CustomNavBar() -> some View {
        VStack {
            HStack(spacing: 16) {
                Image("mountain")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                    .overlay {
                        Circle()
                            .stroke(LinearGradient(colors: [.orange, .orange, .orange, .orange], startPoint: .top, endPoint: .bottom), lineWidth: 3)
                            .frame(width: 50, height: 50)
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Username")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                    
                    HStack {
                        Circle().fill(.green)
                            .frame(width: 11, height: 11)
                        Text("online")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                Image(systemName: "gearshape")
                    .font(.system(size: 24))
                    .onTapGesture {
                        shouldShowLogOutOptions.toggle()
                    }
            }
            Divider()
                .padding(.top, 6)
        }
    }
}

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}

extension View {
    var newChatBubble: some View {
        Image(systemName: "plus.bubble")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 70, height: 70)
            .background {
                Circle()
                    .fill(.orange)
            }
            .padding(.trailing)
    }
}
