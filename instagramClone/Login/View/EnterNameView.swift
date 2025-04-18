//
//  EnterNameView.swift
//  instagramClone
//
//  Created by eunchanKim on 4/17/25.
//

import SwiftUI

struct EnterNameView: View {
    var body: some View {
        SignupBackgroundView {
            VStack {
                Text("이름 입력")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                
                TextField("성명", text: .constant(""))
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
