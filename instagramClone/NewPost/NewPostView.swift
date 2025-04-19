//
//  NewPostView.swift
//  instagramClone
//
//  Created by eunchanKim on 4/15/25.
//

import SwiftUI
import PhotosUI

struct NewPostView: View {
    @State var viewModel = NewPostViewModel()
    @Binding var tabIndex: Int

    
    var body: some View {
        VStack{
            HStack {
                Button {
                    print("뒤로가기")
                    tabIndex = 0
                } label: {
                    Image(systemName: "chevron.left")
                        .tint(.black)
                }
                Spacer()
                Text("새 게시물")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.horizontal)
            
            PhotosPicker(selection: $viewModel.selectedItem){
                if let image = self.viewModel.postImage { // self.postImage가 nil이 아닐 때
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 400)
                        .clipped()
                    
                } else { // 장착 전
                    Image(systemName:"photo.on.rectangle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 150)
                        .padding()
                }
            }
            .onChange(of: viewModel.selectedItem) { oldValue, newValue in
                Task {
                    await viewModel.convertImage(item: newValue)
                }
            }
            
            
            
            TextField("문구를 작성하거나 설문을 추가하세요..", text: $viewModel.caption)
                .padding()
            
            Spacer()
            
            Button {
                print("사진 공유")
                Task {
                    await viewModel.uploadPost()
                    viewModel.clearData()
                    tabIndex = 0
                }
            } label: {
                Text("공유")
                    .frame(width: 363, height: 42)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding()
            
        }
    }
}

#Preview {
    NewPostView(tabIndex: .constant(2))
}
