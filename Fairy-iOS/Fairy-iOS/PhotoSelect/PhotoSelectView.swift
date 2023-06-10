//
//  PhotoSelectView.swift
//  Fairy-iOS
//
//  Created by Eric Lee on 2023/06/10.
//

import SwiftUI

struct PhotoSelectView: View {
    @State var image: UIImage?
    @State var showImagePicker: Bool = false
    var body: some View {
        VStack(spacing: 0){
            PhotoSelectTipView()
            
            PhotoSelectCardView(image: $image, showImagePicker: $showImagePicker)
                .padding(.top, 33)
            Spacer()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary){ image in
                self.image = image
            }
        }
        
    }
}

struct PhotoSelectTipView: View {
    var body: some View {
        VStack{
            HStack{
                Text("표지에 사용할 이미지를 선택해주세요")
                    .foregroundColor(Color(hex: "428F71"))
                    .font(.system(size: 18))
                Spacer()
            }
            .padding(.leading, 25)
        }
    }
}

struct PhotoSelectCardView: View{
    @Binding var image: UIImage?
    @Binding var showImagePicker: Bool
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color(hex: "EEF7F3", opacity: 0.5))
                .frame(width: 287, height: 485)
            
            VStack(spacing: 0){
                Text("나의 작가 탐험기")
                    .font(.system(size: 22, weight: .bold))
                    .padding(.top, 32)
                
                Rectangle()
                    .frame(width: 202.5, height: 1)
                    .foregroundColor(Color(hex: "3C5F3F"))
                    .padding(.top, 6.5)
                    .padding(.bottom, 37.5)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 172, height: 154)
                        .foregroundColor(Color(hex: "428F71"))
                        
                    if let image = image{
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 168, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }else{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color(hex: "EEF7F3", opacity: 0.5))
                            .frame(width: 168, height: 150)
                    }
                }
                .frame(width: 172, height: 154)
                .padding(.bottom, 43)
                
                
                Button {
                    showImagePicker = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color(hex: "4DAC87"))
                            .frame(width: 191, height: 43)
                        
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color(hex: "428F71"))
                            .frame(width: 189, height: 41)
                        
                        HStack{
                            Image(systemName: "photo")
                                .foregroundColor(.white)
                            Text("앨범에서 가져오기")
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.bottom, 15)

                Button {
                    print("앨범")
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color(hex: "4DAC87"))
                            .frame(width: 191, height: 43)
                        
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color(hex: "428F71"))
                            .frame(width: 189, height: 41)
                        
                        HStack{
                            Image(systemName: "camera.macro.circle.fill")
                                .foregroundColor(.white)
                            Text("동화 이미지 선택하기")
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                        }
                    }
                }
                
                
                Spacer()
            }
            
        }
        .frame(width: 287, height: 485)
    }
}

struct PhotoSelectView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSelectView()
    }
}

