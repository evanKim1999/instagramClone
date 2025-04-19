//
//  ContentView.swift
//  instagramClone
//
//  Created by eunchanKim on 4/15/25.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State var signUpViewModel = SignupViewModel()
    
    var body: some View {
        if AuthManager.shared.currentUser != nil {
            MainTapView()
        } else {
            LoginView()
                .environment(signUpViewModel) // 다음뷰들이 해당 뷰모델을 선택적으로 사용
        }
    }
}

#Preview {
    ContentView()
}
