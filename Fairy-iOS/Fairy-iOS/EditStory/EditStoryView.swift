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
    
    @State var story1: String = "한 번 도전해 보고 싶어하는 유미는 맛있는 커피를 마셔보고 싶어했습니다. 여러 가게를 돌아다니며 커피를 마셔봐도 별로 맛있지 않아서 좌절을 하고 있었어요. 그러던 중 사람들이 줄서서 기다리는 커피 가게를 발견하게 되었습니다. 유미는 기대감에 흥분하며 줄을 서서 커피를 주문했습니다. 처음 마셔본 그 커피는 정말 맛있었어요. 유미는 이 경험을 토대로 자신이 원하는 것을 끝까지 포기하지 않는 대인생을 살기로 결심했습니다."
    @State var story2: String = "유미는 새로운 환경에서 가장 어렵게 느껴졌던 인간관계에서 이성적으로 괜찮은 사람을 만났습니다. 그 사람은 유미를 무슨 일이 있어도 이해해주고, 말을 잘 들어주는 좋은 친구였어요. 친구와 함께 즐거운 시간을 보내며 유미는 이성적으로 괜찮은 사람과 인간관계를 잘 유지하는 방법을 깨달았습니다."
    @State var story3: String = "하지만 유미에게는 오늘 하루 가장 어려운 순간이 있었습니다. 새로운 사람과 밥을 먹는 것은 항상 어색하고 불편한 일이었지만, 오늘은 군침이 돌 정도로 배가고파서 도전했습니다. 하지만 막상 새로운 사람과 함께 식사를 하니 자신이 너무 바보 같이 행동한 것 같아 자책하기 시작했어요. 하지만 유미는 이것을 극복하기 위해 새로운 사람과 대화하면서 진정한 나를 보여주는 것이 가장 좋은 방법이라는 생각을 하게 되었습니다"
    @State var story4: String = "결국 유미는 오늘 하루 일어난 일들로 인해, 이동동화에서 배운 대인관계, 도전 정신 등의 교훈들을 가장 잘 체득한 캐릭터가 되었습니다. 유미는 더 열심히 살아가며 멋진 인생을 살고, 이동동화에서 주어진 교훈들이 미치는 의미를 그대로 활용해서 살아갈 것입니다"
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(hex: "F3F4EC"))
                .ignoresSafeArea()
            
            ScrollView{
                VStack(spacing: 0){
                    EditTipView()
                        .padding(.bottom, 38)
                    
                    EditBookView(name: $title, story1: $story1, story2: $story2, story3: $story3, story4: $story4)
                    
                    Spacer()
                }
            }
            
            
        }
        .onTapGesture {
            self.endTextEditing()
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
    @Binding var name: String
    @Binding var story1: String
    @Binding var story2: String
    @Binding var story3: String
    @Binding var story4: String
    
    var body: some View{
        
        ZStack{
            VStack{
                Spacer()
                EditTextTabView(story1: $story1, story2: $story2, story3: $story3, story4: $story4)
                
            }
            .frame(height: 500)
            
            VStack{
                EditTitleView(name: $name)
                Spacer()
            }
            .frame(height: 500)

            
        }
        .frame(height: 500)
        
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
                    .fontWeight(.bold)
                
                Spacer()
                    
            }
            .frame(width: 235, height: 37)
            
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
        
        TabView {
            EditTextView(story: $story1)
            EditTextView(story: $story2)
            EditTextView(story: $story3)
            EditTextView(story: $story4)
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
                .shadow(color: Color(hex: "000000", opacity: 0.1),radius: 15, y: 4)
            

            
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
        EditStoryView()
    }
}

