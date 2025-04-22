//
//  CommentView.swift
//  instagramClone
//
//  Created by eunchanKim on 4/22/25.
//

import SwiftUI

struct CommentView: View {
    @State var commentText: String = ""
    @State var viewModel: CommentViewModel
    
    init(post: Post) {
        self.viewModel = CommentViewModel(post: post)
    }
    
    var body: some View {
        VStack {
            Text("댓글")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.bottom, 15)
                .padding(.top, 30)
            Divider()
            
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.comments) { comment in
                        Text(comment.commentText)
                    }
                }
            }
            
            Divider()
            HStack {
                Image("profile_cat")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                Spacer()
                TextField("댓글 달기...", text: $commentText, axis: .vertical)
                Button {
                    Task {
                        await
                        viewModel.uploadComment(commentText: commentText)
                        commentText = ""
                    }
                } label: {
                    Text("보내기")
                }
            }
            .padding()
        }
    }
}

#Preview {
    CommentView(post: Post.DUMMY_POST)
}
