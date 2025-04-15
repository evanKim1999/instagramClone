//
//  ImageFitAndFillView.swift
//  instagramClone
//
//  Created by eunchanKim on 4/15/25.
//

import SwiftUI

struct ImageFitAndFillView: View {
    var body: some View {
        VStack {
            //이미지 비율 맞추기 aspectRatio(contentMode: .fit)
            // .fit-한쪽변이라도 프레임에 닿을 때까지
            //.fill-프레임 넘아감 그래서 .clipped()와 같이씀
            
            Image(systemName: "trash.square.fill")
                .resizable()
                .frame(width: 200, height: 100)
            
            
            Image(systemName: "trash.square.fill")
                .resizable()
                .aspectRatio(contentMode: .fit) // == scaledToFit()
                .frame(width: 200, height: 100)
                .border(.pink, width: 2)
            
            Image(systemName: "trash.square.fill")
                .resizable()
                .aspectRatio(3,contentMode: .fit) // == scaledToFit()
                .frame(width: 200, height: 100)
                .border(.pink, width: 2)
            
            Image(systemName: "trash.square.fill")
                .resizable()
                .aspectRatio(contentMode: .fill) // == scaledToFill()
                .frame(width: 200, height: 100)
                .border(.blue, width: 2)
                .clipped() // 이미지를 프레임에 맞게 절단
        }
    }
}

#Preview {
    ImageFitAndFillView()
}
