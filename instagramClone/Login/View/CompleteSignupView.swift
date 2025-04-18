//
//  CompleteSignupView.swift
//  instagramClone
//
//  Created by eunchanKim on 4/17/25.
//

import SwiftUI

struct CompleteSignupView: View {
    @Environment(\.dismiss) var dismiss //뒤로가기를 위한 환경변수
    var body: some View {
        ZStack {
            GradientBackgroundView()
            VStack {
                Image("instagramLogo2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                
                Spacer()
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 172, height: 172)
                    .foregroundStyle(Color.gray)
                    .opacity(0.5)
                    .overlay {
                        Circle()
                            .stroke(Color.gray, lineWidth: 2)
                            .opacity(0.5)
                            .frame(width: 185, height: 1852)
                    }
                
                Text("에반님, Instagrame에 오신 것을 환영합니다")
                    .font(.title)
                    .padding(.top, 30)
                    .padding(.horizontal)
                Spacer()

                BlueButtonView {
                    print("complete")
                } label: {
                    Text("complete")
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .tint(.black)
                }
            }
        }
    }
}

#Preview {
    CompleteSignupView()
}
