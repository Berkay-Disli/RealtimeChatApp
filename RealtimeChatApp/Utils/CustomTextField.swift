//
//  CustomTextField.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 28.01.2023.
//

import SwiftUI

struct CustomTextField: View {
    let image: String
    let placeholder: String
    @Binding var text: String
    let isSecure: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                } else {
                    TextField(placeholder, text: $text)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }
            }
            Divider()
                .background(.gray)
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(image: "envelope", placeholder: "email", text: .constant(""), isSecure: false)
    }
}
