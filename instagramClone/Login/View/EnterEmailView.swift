//
//  EnterEmailView.swift
//  instagramClone
//
//  Created by eunchanKim on 4/17/25.
//

import SwiftUI

struct EnterEmailView: View {
    @Environment(SignupViewModel.self) var signupViewModel
    var body: some View {
        // 뷰모델에 내용을 변경하려면 @Bindable로 재선언 필요
        @Bindable var signupViewModel = signupViewModel
        SignupBackgroundView {
            VStack {
                Text("이메일 주소 입력")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                
                Text("회원님에게 연락할 수 있는 이메일 주소를 입력하세요. 이 이메일 주소는 피로필에서 다른 사람에게 공개되지 않습니다.")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                TextField("이메일주소", text: $signupViewModel.email)
                    .modifier(InstagramTextFieldModifier())
                
                NavigationLink {
                    EnterPasswordView()
                } label: {
                    Text("다음")
                        .foregroundStyle(.white)
                        .frame(width: 363, height: 42)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                Spacer()
            }
        }
    }
}

#Preview {
    EnterEmailView()
}
