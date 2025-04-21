//
//  FeedView.swift
//  instagramClone
//
//  Created by eunchanKim on 4/21/25.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image("instagramLogo2")
                        .resizable()
                        .scaledToFit( )
                        .frame(width: 110)
                    Spacer()
                    Image(systemName: "heart")
                        .imageScale(.large)
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                .padding(.horizontal)
                
                FeedCellView()
                FeedCellView()
                FeedCellView()
                FeedCellView()
                Spacer()
            }
        }
    }
}

#Preview {
    FeedView()
}
