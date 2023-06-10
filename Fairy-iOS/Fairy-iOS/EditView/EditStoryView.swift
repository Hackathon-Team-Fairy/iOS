//
//  EditStoryView.swift
//  Fairy-iOS
//
//  Created by Eric Lee on 2023/06/10.
//

import SwiftUI

struct EditStoryView: View {
    @State var title: String = ""
    
    var body: some View {
        VStack{
            EditTipView()
            
            EditTitleView(name: $title)
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
