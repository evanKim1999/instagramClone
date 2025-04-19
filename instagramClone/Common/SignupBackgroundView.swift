//
//  SignupBackgroundView.swift
//  instagramClone
//
//  Created by eunchanKim on 4/18/25.
//

import SwiftUI

struct SignupBackgroundView<Content: View>: View {
    let content: Content
    @Environment(\.dismiss) var dismiss //뒤로가기를 위한 환경변수
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            GradientBackgroundView()
        content
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

