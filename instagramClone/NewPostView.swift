//
//  NewPostView.swift
//  instagramClone
//
//  Created by eunchanKim on 4/15/25.
//

import SwiftUI
import PhotosUI

struct NewPostView: View {
    @State var caption = ""
    @Binding var tabIndex: Int
    @State var selectedItem: PhotosPickerItem?
    @State var postImage: Image?
    
    func convertImage(item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.postImage = Image(uiImage: uiImage)
    }
    
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
            
            PhotosPicker(selection: $selectedItem){
                if let image = self.postImage { // self.postImage가 nil이 아닐 때
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
            .onChange(of: selectedItem) { oldValue, newValue in
                Task {
                    await convertImage(item: newValue)
                }
            }
            
            
            
            TextField("문구를 작성하거나 설문을 추가하세요..", text: $caption)
                .padding()
            
            Spacer()
            
            Button {
                print("사진 공유")
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
