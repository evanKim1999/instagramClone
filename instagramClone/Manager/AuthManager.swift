//
//  AuthManager.swift
//  instagramClone
//
//  Created by agmma on 5/1/24.
//

import Foundation
import FirebaseAuth
import Firebase

@Observable
class AuthManager {
    
    static let shared = AuthManager()
    
    var currentAuthUser: FirebaseAuth.User?
    var currentUser: User?
    
    init() {
        currentAuthUser = Auth.auth().currentUser //로그인 풀림방지
        Task {
            await loadUserData()
        }
    }
    
    func createUser(email: String, password: String, name: String, username: String) async {
        print("email:", email)
        print("password:", password)
        print("name:", name)
        print("username:", username)
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            currentAuthUser = result.user
            guard let userId = currentAuthUser?.uid else { return }
            await uploadUserData(userId: userId, email: email, username: username, name: name)
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func uploadUserData(userId: String, email: String, username: String, name: String) async {
        let user = User(id: userId, email: email, username: username, name: name)
        self.currentUser = user
        do {
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            print("DEBUG: Failed to upload user data with error \(error.localizedDescription)")
        }
    }
    
    func signin(email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            currentAuthUser = result.user
            await loadUserData()
        } catch {
            print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
        }
    }
    
    func loadUserData() async {
        guard let userId = self.currentAuthUser?.uid else { return }
        do {
            self.currentUser = try await Firestore.firestore().collection("users").document(userId).getDocument(as: User.self)
            print("currentUser: ",currentUser)
        } catch {
            print("DEBUG: Failed to load user data with error \(error.localizedDescription)")
        }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut()
            currentAuthUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
}

