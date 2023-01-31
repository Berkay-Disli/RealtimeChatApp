//
//  CustomInputView.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 28.01.2023.
//

import SwiftUI

struct CustomInputView: View {
    @Binding var text: String
    
    var body: some View {
        VStack {
            Divider()
            
            HStack {
                TextField("Message...", text: $text)
                    .frame(height: 30)
                
                Button {
                    text = ""
                } label: {
                    Image(systemName: "location.circle.fill")
                        .foregroundColor(.orange)
                        .font(.system(size: 30))
                }
            }
            .padding(.horizontal).padding(.vertical, 8)
        }
    }
}

struct CustomInputView_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputView(text: .constant(""))
    }
}
