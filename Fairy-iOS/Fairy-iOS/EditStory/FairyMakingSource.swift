//
//  FairyMakingSource.swift
//  Fairy-iOS
//
//  Created by Eric Lee on 2023/06/11.
//

import SwiftUI

class FairyMakingSource: ObservableObject{
    static let shared = FairyMakingSource()
    
    @Published var title: String = ""
    @Published var story1: String = "한 번 도전해 보고 싶어하는 유미는 맛있는 커피를 마셔보고 싶어했습니다. 여러 가게를 돌아다니며 커피를 마셔봐도 별로 맛있지 않아서 좌절을 하고 있었어요. 그러던 중 사람들이 줄서서 기다리는 커피 가게를 발견하게 되었습니다. 유미는 기대감에 흥분하며 줄을 서서 커피를 주문했습니다. 처음 마셔본 그 커피는 정말 맛있었어요. 유미는 이 경험을 토대로 자신이 원하는 것을 끝까지 포기하지 않는 대인생을 살기로 결심했습니다."
    @Published var story2: String = "유미는 새로운 환경에서 가장 어렵게 느껴졌던 인간관계에서 이성적으로 괜찮은 사람을 만났습니다. 그 사람은 유미를 무슨 일이 있어도 이해해주고, 말을 잘 들어주는 좋은 친구였어요. 친구와 함께 즐거운 시간을 보내며 유미는 이성적으로 괜찮은 사람과 인간관계를 잘 유지하는 방법을 깨달았습니다."
    @Published var story3: String = "하지만 유미에게는 오늘 하루 가장 어려운 순간이 있었습니다. 새로운 사람과 밥을 먹는 것은 항상 어색하고 불편한 일이었지만, 오늘은 군침이 돌 정도로 배가고파서 도전했습니다. 하지만 막상 새로운 사람과 함께 식사를 하니 자신이 너무 바보 같이 행동한 것 같아 자책하기 시작했어요. 하지만 유미는 이것을 극복하기 위해 새로운 사람과 대화하면서 진정한 나를 보여주는 것이 가장 좋은 방법이라는 생각을 하게 되었습니다"
    @Published var story4: String = "결국 유미는 오늘 하루 일어난 일들로 인해, 이동동화에서 배운 대인관계, 도전 정신 등의 교훈들을 가장 잘 체득한 캐릭터가 되었습니다. 유미는 더 열심히 살아가며 멋진 인생을 살고, 이동동화에서 주어진 교훈들이 미치는 의미를 그대로 활용해서 살아갈 것입니다"
    
    @Published var image: UIImage?
    @Published var imageURL: String?

}
