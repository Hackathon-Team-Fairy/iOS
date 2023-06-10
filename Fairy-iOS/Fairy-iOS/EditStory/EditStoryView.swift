//
//  EditStoryView.swift
//  Fairy-iOS
//
//  Created by Eric Lee on 2023/06/10.
//

import SwiftUI
import SnapKit

struct EditStoryView: View {
    @State var title: String = ""
    
    @State var story1: String = "‘새로운 팀원, 새로운 도전' 옛날 어느 마을에 한 작가가 살고 있었다. 이 작가는 매일같이 새로운 도전을 받아들이며 그것을 극복하며 살아가고 있었다. 어느 날 해커톤 참가 신청을 하게 되어 새로운 팀원들을 만나게 되었다   도전을 받아들이며 그것을 극복하며 살아가고 있었다. 어느 날 해커톤 참가 신청을 하게 되어 새로운 팀원들을 만나게 되었다 도전을 받아들이며 그것을 극복하며 살아가고 있었다. 어느 날 해커톤 참가 신청을 하게 되어 새로운 팀원들을 만나게 되었다 "
    @State var story2: String = "신데렐라는 어려서"
    @State var story3: String = "백마탄 왕자님 두둥등장"
    @State var story4: String = "가보작오"
    
    var body: some View {
        NavigationView {
            VStack{
                EditTipView()
                
                EditTitleView(name: $title)
                
                EditTextTabView(story1: $story1, story2: $story2, story3: $story3, story4: $story4)
                
                
//                Button {
//                    <#code#>
//                } label: {
//                    <#code#>
//                }

                
//                NavigationLink(destination: Text("오")) {
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 15)
//                            .foregroundColor(.gray)
//                            .frame(width: 319, height: 50)
//                        Text("표지 만들러가기")
//                    }
//                }

                
                Spacer()
            }
            .onTapGesture {
                self.endTextEditing()
            }
        }
        
    }
    
    
    
}

struct EditTipView: View {
    
    var body: some View {
        
        VStack{
            HStack{
                Text("이야기 내용을 편집해주세요")
                    .foregroundColor(.black)
                    .font(.system(size: 18))
                Spacer()
            }
            HStack{
                Text("자유롭게 편집하며 나만의 이야기를 만들어보세요")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

struct EditTitleView: View {
    @Binding var name: String
    
    var body: some View {
        
        VStack(spacing: 0){
            HStack{
                Spacer()
                
                TextField("책 제목을 입력해주세요", text: $name)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 24))
                
                Spacer()
                    
            }
            .frame(width: 235)
            
            if name.isEmpty{
               Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: 235, height: 1)
            }
        }

        
    }
}

struct EditTextTabView: View{
    @Binding var story1: String
    @Binding var story2: String
    @Binding var story3: String
    @Binding var story4: String
    
    var body: some View {
        
        GeometryReader { geo in
            TabView {
                EditTextView(story: $story1)
                EditTextView(story: $story2)
                EditTextView(story: $story3)
                EditTextView(story: $story4)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle())
        }
        .frame(height: 500)
        
        
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
                .foregroundColor(.gray)
                .frame(width: 297, height: 359)

            
            TextEditor(text: $story)
                          .padding()
                          .foregroundColor(Color.black)
                          .font(.system(size: 20))
                          .colorMultiply(.gray)
                          .lineSpacing(5) //줄 간격
                          .frame(width: 246, height: 359)

                          
        }
        
    }
}



struct EditStoryView_Previews: PreviewProvider {
    static var previews: some View {
        EditStoryView()
    }
}

