//
//  BigButton.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 30.01.2023.
//

import SwiftUI

struct BigButton: View {
    let title: String
    let bgColor: Color
    let textColor: Color
    
    var body: some View {
        ZStack {
            Text(title)
        }
        .font(.title3).fontWeight(.medium)
        .foregroundColor(textColor)
        .frame(maxWidth: .infinity).frame(height: 60)
        .background(bgColor)
        .cornerRadius(100)
        .padding(.horizontal)
    }
}

struct BigButton_Previews: PreviewProvider {
    static var previews: some View {
        BigButton(title: "Add to Watchlist", bgColor: .black, textColor: .white)
    }
}
