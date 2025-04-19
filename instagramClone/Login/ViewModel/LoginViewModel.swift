//
//  LoginViewModel.swift
//  instagramClone
//
//  Created by eunchanKim on 4/18/25.
//

import Foundation

@Observable
class LoginViewModel {
    var email = ""
    var password = ""
    
    func signin() async {
        await AuthManager.shared.signin(email: email, password: password)
    }
}
