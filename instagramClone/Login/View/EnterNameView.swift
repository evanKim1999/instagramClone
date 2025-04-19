//
//  EnterNameView.swift
//  instagramClone
//
//  Created by eunchanKim on 4/17/25.
//

import SwiftUI

struct EnterNameView: View {
    @Environment(SignupViewModel.self) var signupViewModel
    var body: some View {
        // 뷰모델에 내용을 변경하려면 @Bindable로 재선언 필요
        @Bindable var signupViewModel = signupViewModel
        SignupBackgroundView {
            VStack {
                Text("이름 입력")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                
                TextField("성명", text: $signupViewModel.name)
                    .modifier(InstagramTextFieldModifier())
                
                NavigationLink {
                    EnterUsernameView()
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
    EnterNameView()
}
