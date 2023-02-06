//
//  AuthViewModel.swift
//  RealtimeChatApp
//
//  Created by Berkay Disli on 30.01.2023.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var userProfileImageUrl: URL?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.userProfileImageUrl = nil
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createAccountWithEmail(email: String, username: String, fullname: String, password: String, image: UIImage) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error {
                print("AUTH ERROR:\(error.localizedDescription)")
            } else {
                guard let user = result?.user else { return }
                // To give the user specific profile infos:
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                //changeRequest?.photoURL =
                changeRequest?.commitChanges(completion: { error in
                    if let error {
                        print("CHANGE REQUEST ERROR:\(error.localizedDescription)")
                    }
                })
                self.uploadFullUserInfoWithPicture(user: user, email: email, username: username, fullname: fullname, image: image)
                
                
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.userSession = user
                    self.getUserInfo()
                }
            }
        }
    }
    
    func signInWithEmail(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                print(error.localizedDescription)
            } else {
                guard let user = result?.user else { return }
                self.userSession = user
            }
        }
    }
    
    private func uploadUserInfoToFirestore(user: User, email: String, username: String, fullname: String, imgUrl: String) {
        let userData = ["email": email, "username": username, "fullname": fullname, "profilePicUrl": imgUrl] as [String:Any]
        Firestore.firestore().collection("users").document(user.uid).setData(userData) { error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("User info saved.")
            }
        }
    }
    
    private func uploadFullUserInfoWithPicture(user: User, email: String, username: String, fullname: String, image: UIImage) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Storage.storage().reference(withPath: "userImages/\(uid).jpg")
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        ref.putData(imageData) { metadata, error in
            if let error {
                print("IMAGE UPLOAD ERROR: \(error)")
                return
            } else {
                ref.downloadURL { url, error in
                    if let error {
                        print("DOWNLOAD URL ERROR: \(error)")
                    } else {
                        guard let url else { return }
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.photoURL = url
                        changeRequest?.commitChanges(completion: { error in
                            if let error {
                                print("CHANGE REQUEST ERROR FOR PHOTO URL:\(error.localizedDescription)")
                            }
                        })
                        
                        self.uploadUserInfoToFirestore(user: user, email: email, username: username, fullname: fullname, imgUrl: url.absoluteString)
                    }
                }
            }
        }
    }
    
    func getUserInfo() {
        guard let user = userSession else { return }
        
        Firestore.firestore().collection("users").document(user.uid).getDocument { snapshot, error in
            guard let snapshot, error == nil else {
                print("ERROR IN GETUSERINFO \(error?.localizedDescription ?? "error")")
                return
            }
            if let userProfileImg = snapshot.get("profilePicUrl") as? String {
                self.userProfileImageUrl = URL(string: userProfileImg)
            }
        }
    }
}
