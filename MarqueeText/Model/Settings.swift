//
//  Settings.swift
//  MarqueeText
//
//  Created by Amini on 25/08/22.
//

import Foundation
import SwiftUI

class SettingViewModel: ObservableObject {
    @Published var selected: SystemModel? = nil
    @Published var tapped: Bool = false
}

class SystemViewModel: ObservableObject {
    @Published var animationPlay = true
    @Published var settingShow = true
    
    //Setting for Text
    @Published var textEffect: String = ""
    @Published var textSize: CGFloat = 40  //// --->>> MAX 400 ---> MIN 150
    @Published var textColor: Color = .black
    @Published var textSpeed: Double = 5
    @Published var textDelay: Double = 0
    @Published var textFont: String = "HelevaticaNeue"
    @Published var textFontWeight: Font.Weight = .regular
    @Published var textDesign: Font.Design = .default
    
    @Published var textToShow: String = "MARQUEE TEXT"
    
    //Setting for back
    @Published var backgroundImage: String = ""
    @Published var backgroundColor: Color = .white
    
    
    var textCount: [String] {
        var counter = UIScreen.main.bounds.height / widthOfText()
        if counter < 1 {
            counter = 1
        }
        let arrStr = [String](repeating: textToShow, count: Int(counter))
        return arrStr
    }
    
    private func widthOfText() -> CGFloat {
        return textToShow.widthOfString(usingFont: UIFont(name: textFont, size: textSize) ?? .systemFont(ofSize: textSize))
    }

    
}

enum TextEffect {
    case blink
}

enum SystemType {
    case textColors(color: [Color])
    case textDesign(design: [Font.Design])
    case textWeight(weight: [Font.Weight])
    case textEffect(effect: [TextEffect])
    case textSize(minFontSize: CGFloat, maxFontSize: CGFloat)
    case backgroundColor(color: [Color])
    case backgroundImage(image: [String])
}

struct SystemModel: Identifiable {
    var id = UUID()
    var number: Int
    var type: SystemType
    var icon: String
}

var settingsArr: [SystemModel] = [
    SystemModel(number: 1,
                type: .textColors(color: [.brown, .red, .green, .blue, .black, .pink, .white, .cyan, .gray, .indigo, .orange, .mint, .purple, .yellow, .teal]),
                icon: "paintbrush.pointed.fill"
               ),
    
    SystemModel(number: 2,
                type: .textDesign(design: [.monospaced, .rounded, .serif]),
                icon: "textformat.size.larger"
               ),
    
    SystemModel(number: 3,
                type: .textSize(minFontSize: 1, maxFontSize: 70),
                icon: "textformat.size"
               ),
    
    SystemModel(number: 4,
                type: .textWeight(weight: [.regular, .black, .bold, .heavy, .light, .medium, .semibold, .thin, .ultraLight]),
                icon: "bold"),
    
    SystemModel(number: 5,
                type: .backgroundColor(color: [.brown, .red, .green, .blue, .black, .pink, .white, .cyan, .gray, .indigo, .orange, .mint, .purple, .yellow, .teal]),
                icon: "rectangle.inset.filled.on.rectangle"
               ),
    
    SystemModel(number: 6,
                type: .backgroundImage(image: ["", "", "", ""]),
                icon: "photo.on.rectangle"),
    
    SystemModel(number: 7,
                type: .textEffect(effect: [.blink]),
                icon: "sparkles")
    
]
