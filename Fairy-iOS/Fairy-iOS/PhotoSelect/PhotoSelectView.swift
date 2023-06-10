//
//  PhotoSelectView.swift
//  Fairy-iOS
//
//  Created by Eric Lee on 2023/06/10.
//

import SwiftUI
import Kingfisher

struct PhotoSelectView: View {
    @ObservedObject var fms = FairyMakingSource.shared
    
    var title: String = "나의 작가 탐험기"
    @State var showImagePicker: Bool = false
    @State var showMandos: Bool = false
    
    var body: some View {
        ZStack{
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(Color(hex: "F3F4EC"))
            
            VStack(spacing: 0){
                PhotoSelectTipView()
                    .padding(.top, 33)
                    .padding(.bottom, 34)
                
                PhotoThumbNailView()
                    .padding(.bottom, 27)
                
                PhotoControlButton(image: $fms.image, showImagePicker: $showImagePicker, showMandos: $showMandos)
                
                Spacer()
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .photoLibrary){ image in
                    fms.image = image
                }
            }
            .sheet(isPresented: $showMandos) {
                BasePhotoSelectViewControllerWrapper()
            }
        }
        
    }
}

struct PhotoSelectTipView: View {
    var body: some View {
        VStack(spacing: 0){
            HStack{
                Text("표지에 사용할 이미지를 선택해주세요")
                    .foregroundColor(.green1)
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                Spacer()
            }
        }
        .padding(.leading, 25)
    }
}

struct PhotoThumbNailView: View{
    @ObservedObject var fms = FairyMakingSource.shared
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color(hex: "f1f3e5"))
                .frame(width: 287, height: 368)
                .shadow(color: Color(hex: "000000", opacity: 0.15), radius: 15, y: 4)
            
            VStack(spacing: 0){
                
                //이미지 선택 영역
                Text(fms.title)
                    .padding(.top, 25)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.bottom, 22)
                
                
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 180, height: 255)
                        .foregroundColor(Color(hex: "428F71", opacity: 0.15))
                    
                    if let image = fms.image{
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 174, height: 249)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }else if let imageURL = fms.imageURL{
                        
                        KFImage(URL(string: imageURL))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 174, height: 249)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        
                        
                    }else{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color(hex: "f1f3e5"))
                            .frame(width: 174, height: 249)
                        
                        Image(systemName: "photo.on.rectangle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 66, height: 66)
                            .foregroundColor(Color(hex: "428F71", opacity: 0.3))
                    }
                    
                }
                Spacer()
                
            }
            
        }
        .frame(width: 287, height: 368)
        
    }
}

struct PhotoControlButton: View{
    @Binding var image: UIImage?
    @Binding var showImagePicker: Bool
    @Binding var showMandos: Bool
    
    var body: some View{
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(hex: "4DAC87"))
                .frame(width: 191, height: 95)
            
            VStack(spacing: 0){
                
                HStack{
                    Image("photo_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                    Text("앨범에서 가져오기")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                }
                .frame(width: 190, height: 46)
                .onTapGesture {
                    showImagePicker = true
                }
                
                
                Rectangle()
                    .frame(width: 167, height: 1)
                    .foregroundColor(Color(hex:"FFFFFF", opacity: 31.37))
                
                
                HStack{
                    Image("flower_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                    Text("앨범에서 가져오기")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                }
                .frame(width: 190, height: 46)
                .onTapGesture {
                    showMandos = true
                }
            }
            
        }
        .frame(width: 191, height: 95)

    }
}

struct PhotoSelectView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSelectView()
    }
}

