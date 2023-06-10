//
//  EditStoryView.swift
//  Fairy-iOS
//
//  Created by Eric Lee on 2023/06/10.
//

import SwiftUI
import SnapKit

struct EditStoryView: View {
    var diary: [String]

    @ObservedObject var fms = FairyMakingSource.shared
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(hex: "F3F4EC"))
                .ignoresSafeArea()
            
            ScrollView{
                VStack(spacing: 0){
                    EditTipView()
                        .padding(.top, 25)
                        .padding(.bottom, 38)
                    
                    EditBookView()
                    
                    Spacer()
                }
            }
            
            
        }
        .onTapGesture {
            self.endTextEditing()
        }
        .onAppear{
            setStory()
        }
        
    }
    
    private func setStory(){
        
        if diary.indices.contains(0) {
            self.fms.story1 = diary[0]
        } else {
            self.fms.story1 = "어느어느날의 이야기에요"
        }

        if diary.indices.contains(1) {
            self.fms.story2 = diary[1]
        } else {
            self.fms.story2 = "행복하게 살았어요"
        }

        if diary.indices.contains(2) {
            self.fms.story3 = diary[2]
        } else {
            self.fms.story3 = "행복하게 살았어요"
        }

        if diary.indices.contains(3) {
            self.fms.story4 = diary[3]
        } else {
            self.fms.story4 = "행복하게 살았어요"
        }
        
    }
    
    
    
}

struct EditTipView: View {
    
    var body: some View {
        
        VStack(spacing: 0){
            HStack{
                Text("이야기 내용을 편집해주세요")
                    .foregroundColor(.green1)
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                Spacer()
            }
            .padding(.bottom, 7)
            HStack{
                Text("*자유롭게 편집하며 나만의 이야기를 만들어보세요")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                Spacer()
            }
        }
        .padding(.leading, 25)
    }
}

struct EditBookView: View{
    
    var body: some View{
        
        ZStack{
            VStack{
                Spacer()
                EditTextTabView()
                
            }
            .frame(height: 500)
            
            VStack{
                EditTitleView()
                Spacer()
            }
            .frame(height: 500)

            
        }
        .frame(height: 500)
        
    }
    
}

struct EditTitleView: View {
    @ObservedObject var fms = FairyMakingSource.shared
    
    var body: some View {

        VStack(spacing: 0){
            HStack{
                Spacer()
               
                
                TextField("책 제목을 입력해주세요", text: $fms.title)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                
                Spacer()
                    
            }
            .frame(width: 235, height: 37)
            
            if fms.title.isEmpty{
               Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: 235, height: 1)
            }
        }
        
    }
}

struct EditTextTabView: View{
    @ObservedObject var fms = FairyMakingSource.shared
    
    
    var body: some View {
        
        TabView {
            EditTextView(story: $fms.story1)
            EditTextView(story: $fms.story2)
            EditTextView(story: $fms.story3)
            EditTextView(story: $fms.story4)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
        .indexViewStyle(PageIndexViewStyle())
        .frame(height: 500)
        .onAppear{
            setupAppearance()
        }
        
    }
    
    func setupAppearance() {
       UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(hexCode: "4DAC87")
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(hexCode: "4DAC87").withAlphaComponent(0.3)
     }
}

struct EditTextView: View {
    @Binding var story: String
    
    init(story: Binding<String>) {
        self._story = story
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 32)
                .foregroundColor(Color.bookBgColor)
                .frame(width: 297, height: 359)
                .shadow(color: Color(hex: "000000", opacity: 0.15),radius: 15, y: 4)
            

            
            TextEditor(text: $story)
                .foregroundColor(Color.bookTextColor)
                .font(.system(size: 20))
                .fontWeight(.medium)
                .colorMultiply(.bookBgColor)
                .lineSpacing(8) //줄 간격
                .padding(.vertical)
                .frame(width: 246, height: 359)
                
                          
        }
        
    }
}



struct EditStoryView_Previews: PreviewProvider {
    static var previews: some View {
        EditStoryView(diary: ["무" ,"야" ,"호", "호"])
    }
}

