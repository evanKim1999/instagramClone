//
//  LoginView.swift
//  instagramClone
//
//  Created by eunchanKim on 4/17/25.
//

import SwiftUI

struct LoginView: View {
    @State var viewModel = LoginViewModel()
    var body: some View {
        NavigationStack {
            // 그라데이션 효과
            ZStack {
                GradientBackgroundView()
                VStack {
                    Spacer()
                    Image("instagramLogo")
                        .resizable()
                        .frame(width: 57, height: 57)
                    Spacer()
                    
                    VStack(spacing: 20) {
                        TextField("이메일주소", text: $viewModel.email)
                            .modifier(InstagramTextFieldModifier()) // modifier refectoring
                        
                        SecureField("비밀번호", text: $viewModel.password)
                            .modifier(InstagramTextFieldModifier()) // modifier refectoring
                        
                        BlueButtonView {
                            Task {
                                await viewModel.signin()
                            }
                        } label: {
                            Text("로그인")
                        }
                        
                        Text("비밀번호를 잊으셨나요?")
                    }
                    Spacer()
                    
                    NavigationLink {
                        EnterEmailView()
                    } label: {
                        Text("새 계정 만들기")
                            .fontWeight(.bold)
                            .frame(width: 363, height: 42)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.blue, lineWidth: 1)
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
