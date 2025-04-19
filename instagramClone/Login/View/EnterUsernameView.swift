//
//  EnterUsernameView.swift
//  instagramClone
//
//  Created by eunchanKim on 4/17/25.
//

import SwiftUI

struct EnterUsernameView: View {
    @Environment(SignupViewModel.self) var signupViewModel
    var body: some View {
        // 뷰모델에 내용을 변경하려면 @Bindable로 재선언 필요
        @Bindable var signupViewModel = signupViewModel
        SignupBackgroundView {
            VStack {
                Text("사용자 이름 만들기")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                
                Text("사용자 이름을 직접 추가하거나 추천 이름을 사용하세요. 언제든지 변경할 수 있습니다")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                TextField("사용자이름", text: $signupViewModel.username)
                    .modifier(InstagramTextFieldModifier())
                
                NavigationLink {
                    CompleteSignupView()
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
    EnterUsernameView()
}
