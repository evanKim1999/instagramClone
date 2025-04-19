//
//  ProfileViewModel.swift
//  instagramClone
//
//  Created by eunchanKim on 4/20/25.
//

import Firebase
import PhotosUI
import SwiftUI
import FirebaseStorage

@Observable
class ProfileViewModel {
    var user: User?
    
    var name: String
    var username: String
    var bio: String
    
    var posts: [Post] = []
    
    var selectedItem: PhotosPickerItem?
    var profileImage: Image?
    var uiImage: UIImage?
    

    init() {
//        self.user = AuthManager.shared.currentUser
        let user = AuthManager.shared.currentUser // user를 먼저 할당 받고나서 사용함
        self.user = user
        
        self.name = user?.name ?? ""
        self.username = user?.username ?? ""
        self.bio = user?.bio ?? ""
    }
    
    func convertImage(item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.profileImage = Image(uiImage: uiImage)
        self.uiImage = uiImage
    }
    
    func updateUser() async {
        do {
            try await updateUserRemote()
            updateUserLocal()
        } catch {
            print("DEBUG: Failed to update user \(error.localizedDescription)")
        }

    }
    
    func updateUserLocal() {
        if name != "", name != user?.name {
            user?.name = name
        }
        if username.isEmpty == false, username != user?.username {
            user?.username = username
        }
        if !bio.isEmpty, bio != user?.bio {
            user?.bio = bio
        }
    }
    
    func updateUserRemote() async throws {
        var editedData: [String: Any] = [:] // 딕셔너리 초기화
        
        if name != "", name != user?.name {
            editedData["name"] = name
        }
        if username.isEmpty == false, username != user?.username {
            editedData["username"] = username
        }
        if !bio.isEmpty, bio != user?.bio {
            editedData["bio"] = bio
        }
        if let uiImage = self.uiImage {
            let imageUrl = await uploadImage(uiImage: uiImage)
            editedData["profileImageUrl"] = imageUrl
        }
        if !editedData.isEmpty, let userId = user?.id {
            try await Firestore.firestore().collection("users").document(userId).updateData(editedData)
        }
    }
    
    // 사진업로드
    func uploadImage(uiImage: UIImage) async -> String? {
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return nil }
        let fileName = UUID().uuidString
        print("filename :", fileName)
        
        let reference = Storage.storage().reference(withPath: "/profile/\(fileName)")
        
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
    
    // 유저포스트 다운로드
    func loadUserPosts() async {
        do {
            let documents = try await Firestore.firestore().collection("posts").order(by: "date", descending: true)
                .whereField("userId", isEqualTo: user?.id ?? "").getDocuments().documents
            
            var posts: [Post] = []
            for document in documents {
                let post = try document.data(as: Post.self)
                posts.append(post)
            }
            self.posts = posts
        } catch {
            print("DEBUG: Failed to load user posts with error \(error.localizedDescription)")
        }
        
    }
}
