//
//  NewPostViewModel.swift
//  instagramClone
//
//  Created by eunchanKim on 4/16/25.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import Firebase
import FirebaseFirestoreSwift



@Observable
class NewPostViewModel {
    var caption = ""
    var selectedItem: PhotosPickerItem?
    var postImage: Image?
    var uiImage: UIImage?
    
    func convertImage(item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.postImage = Image(uiImage: uiImage)
        self.uiImage = uiImage
    }
    
    // 게시글업로드
    func uploadPost() async {
        guard let uiImage else { return }
        guard let imageUrl = await uploadImage(uiImage: uiImage) else { return }
        guard let userId = AuthManager.shared.currentAuthUser?.uid else { return }
                
        let postReference = Firestore.firestore().collection("posts").document()
        let post = Post(id: postReference.documentID, userId: userId, caption: caption, like: 0, imageUrl: imageUrl, date: Date())
        
        do {
            // firebase에서 이해하도록 인코딩
            let encodedData = try Firestore.Encoder().encode(post)
            try await postReference.setData(encodedData)
        } catch {
            print("DEBUG: error upload post: \(error.localizedDescription)")
        }
    }
    
    // 사진업로드
    func uploadImage(uiImage: UIImage) async -> String? {
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return nil }
        let fileName = UUID().uuidString
        print("filename :", fileName)
        
        let reference = Storage.storage().reference(withPath: "/images/\(fileName)")
        
        do {
            let metaData = try await reference.putDataAsync(imageData)
            print("metaData:", metaData)
            let url = try await reference.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: error uploading image: \(error.localizedDescription)")
            return nil
        }
    }
    
    // 업로드화면 클리어
    func clearData() {
        caption = ""
        selectedItem = nil
        postImage = nil
        uiImage = nil
    }
}
