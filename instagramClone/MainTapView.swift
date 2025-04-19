//
//  MainTapView.swift
//  instagramClone
//
//  Created by eunchanKim on 4/15/25.
//

import SwiftUI
import FirebaseAuth

struct MainTapView: View {
    @State var tabIndex = 0
    
    var body: some View {
        TabView(selection: $tabIndex) {
            Text("Feed")
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)
            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(1)
            NewPostView(tabIndex: $tabIndex)
                .tabItem {
                    Image(systemName: "plus.square")
                }
                .tag(2)
            VStack {
                Text("Reels")
                Button {
                    AuthManager.shared.signout()
                } label: {
                    Text("LogOut")
                }
                  
            }  .tabItem {
                Image(systemName: "movieclapper")
            }
            .tag(3)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                }
                .tag(4)
        }
        .tint(Color.black)
    }
}

#Preview {
    MainTapView()
}
