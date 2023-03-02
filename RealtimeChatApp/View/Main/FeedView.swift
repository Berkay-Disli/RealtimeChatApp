//
//  FeedView.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 2.03.2023.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationView {
            let primaryColor = Color("pri")
            ScrollView(showsIndicators: false, content: {
                LazyVStack {
                    // MARK: Header Profiles -- New profiles maybe?
                    ScrollView(.horizontal, showsIndicators: false) {
                        HeaderProfilesView // extension
                        
                        
                    }
                    
                    Divider()
                }
                
            })
            .background(Color("bg"))
            .navigationTitle("Feed")
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        TabManager()
            .environmentObject(NavigationViewModel())
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
