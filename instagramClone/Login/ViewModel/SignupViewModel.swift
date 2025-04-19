//
//  SignupViewModel.swift
//  instagramClone
//
//  Created by eunchanKim on 4/18/25.
//

import Foundation
import FirebaseAuth // 회원가입용 인증 API

@Observable
class SignupViewModel {
    var email: String = ""
    var password: String = ""
    var name: String = ""
    var username: String = ""
    
//    var currentUserSession: FirebaseAuth.User? // 현재 유저정보 유지세션 (싱글톤)
//    
//    func createUser() async {
//        print("email:",email)
//        print("password:",password)
//        print("name:",name)
//        print("username:",username)
//        
//        do {
//            let result = try await Auth.auth().createUser(withEmail: email, password: password)
//            currentUserSession = result.user
//        } catch {
//            print("DEBUG: createUser error: \(error.localizedDescription)")
//        }
//    }
    
    func createUser() async {
       await AuthManager.shared.createUser(email: email, password: password, name: name, username: username)
        email = ""
        password = ""
        name = ""
        username = ""  
    }
}
