//
//  EditStoryView.swift
//  Fairy-iOS
//
//  Created by Eric Lee on 2023/06/10.
//

import SwiftUI

struct EditStoryView: View {
    @State var title: String = ""
    
    @State var stroy1: String = "‘새로운 팀원, 새로운 도전' 옛날 어느 마을에 한 작가가 살고 있었다. 이 작가는 매일같이 새로운 도전을 받아들이며 그것을 극복하며 살아가고 있었다. 어느 날 해커톤 참가 신청을 하게 되어 새로운 팀원들을 만나게 되었다   도전을 받아들이며 그것을 극복하며 살아가고 있었다. 어느 날 해커톤 참가 신청을 하게 되어 새로운 팀원들을 만나게 되었다 도전을 받아들이며 그것을 극복하며 살아가고 있었다. 어느 날 해커톤 참가 신청을 하게 되어 새로운 팀원들을 만나게 되었다 "
    
    var body: some View {
        VStack{
            EditTipView()
            
            EditTitleView(name: $title)
            
            EditTextView(story: $stroy1)
        }
        .onTapGesture {
            self.endTextEditing()
        }
    }
    
    
}

struct EditTipView: View {
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.gray)
                .frame(width: 355, height: 58)
            
            
            HStack{
                Image(systemName: "book.fill")
                Text("이야기를 자유롭게 편집해주세요")
            }
        }
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


class EditStoryViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SwiftUI 화면을 UIKit에 통합
        let contentView = EditStoryView()
        let hostingController = UIHostingController(rootView: contentView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
}
