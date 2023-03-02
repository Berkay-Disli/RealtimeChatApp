//
//  FeedView.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 2.03.2023.
//

import SwiftUI
import Kingfisher

struct FeedView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var signOutAlertIsShown = false
    
    var body: some View {
        NavigationView {
            let primaryColor = Color("pri")
            ScrollView(showsIndicators: false, content: {
                LazyVStack(spacing: 0) {
                    // MARK: Header Profiles -- New profiles maybe?
                    ScrollView(.horizontal, showsIndicators: false) {
                        HeaderProfilesView // extension
                    }
                    
                    Divider()
                        .padding(.bottom)
                    
                    ForEach(1...5, id:\.self) { item in
                        VStack(spacing: 0) {
                            // Post Owner
                            HStack {
                                Circle().fill(Color("pri"))
                                    .frame(width: 35, height: 35)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("User: \(item)")
                                        .font(.callout)
                                    Text("username\(item)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .hAlign(.leading)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                            
                            TabView {
                                Text("blablablabl blablabl ballab bla bla blablalbabl blasa blablablabl blablabl ballab bla bla blablalbabl blaasss blablablabl blablabl ballab bla bla blablalbabl blsa blablablabl blablabl ballab bla bla blablalbabl basla blablablabl blablabl ballab bla bla blablalbabl bvgfla blablablabl blablabl ballab bla bla blablalbabl blsdvsdva ")
                                    .vAlign(.top)
                                    .padding()
                                    
                                
                                Image("engine")
                                    .resizable()
                                
                            }
                            .frame(height: 250)
                            .tabViewStyle(.page)
                            .onAppear {
                                setupAppearance()
                            }
                            
                            Divider()
                        }
                        .padding(.bottom)
                    }
                }
                
            })
            .background(Color("bg"))
            .onAppear {
                Task {
                    try? await authVM.getUserInfoAsync()
                }
            }
            .navigationTitle("Feed")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if authVM.userSession != nil {
                    HStack(spacing: 4) {
                            KFImage(authVM.userProfileImageUrl)
                            //Image("engine")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .frame(width: 30, height: 30)
                                .overlay {
                                    Circle().stroke(primaryColor, lineWidth: 2)
                                }
                        }
                        
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        signOutAlertIsShown.toggle()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(primaryColor)
                    }
                    .alert("Signing Out", isPresented: $signOutAlertIsShown) {
                        Button(role: .destructive) {
                            do {
                                try authVM.signOut()
                            } catch {
                                Task {
                                    await authVM.setError(error)
                                }
                            }
                        } label: {
                            Text("Do you want to sign out?")
                        }
                        .alert(authVM.errorMessage, isPresented: $authVM.showError, actions: {} )

                    }

                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        TabManager()
            .environmentObject(NavigationViewModel())
            .environmentObject(AuthViewModel())
    }
}

extension FeedView {
    var HeaderProfilesView: some View {
        LazyHStack(spacing: 16) {
            ForEach(1...15, id:\.self) { item in
                VStack(spacing: 4) {
                    Circle().stroke(Color("pri"), lineWidth: 2.5)
                        .frame(width: 60, height: 60)
                    
                    Text("User: \(item)")
                        .font(.callout)
                }
            }
        }
        .padding()
    }
}

extension View {
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("pri"))
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color("pri")).withAlphaComponent(0.2)
      }
}
