//
//  Marquee.swift
//  MarqueeText
//
//  Created by Amini on 25/08/22.
//

import SwiftUI

// MARK: Marquee Text View
struct MarqueeText: View {
    
    @StateObject var systemViewModel: SystemViewModel
    @State var text: String = "Marquee"
    // MARK: Animation Offset
    @State var offset: CGFloat = UIScreen.main.bounds.height
    
    // MARK: Animation Speed
    @State var delay: Double = 0
    
    @Environment(\.colorScheme) var scheme
    
    @Namespace var namespace
    @State var show = true
    
    var body: some View {
        
            HStack {
                if show {
                    HStack {
                        Text(systemViewModel.textToShow)
                            .font(Font(UIFont(name: systemViewModel.textFont,
                                              size: systemViewModel.textSize) ?? .systemFont(ofSize: systemViewModel.textSize)))
                        
                            .fontWeight(systemViewModel.textFontWeight)
                            .foregroundColor(systemViewModel.textColor)

                    }
                    .transition(.slide)
                    .matchedGeometryEffect(id: "scroll", in: namespace)
                    
                    Spacer()
                } else {
                    Spacer()
                    HStack {
                        Text(systemViewModel.textToShow)
                            .font(Font(UIFont(name: systemViewModel.textFont,
                                              size: systemViewModel.textSize) ?? .systemFont(ofSize: systemViewModel.textSize)))
                            .fontWeight(systemViewModel.textFontWeight)
                            .foregroundColor(systemViewModel.textColor)

                    }
                    .transition(.slide)
                    .matchedGeometryEffect(id: "scroll", in: namespace)
                    
                }
                
            }

        // MARK: Repeating Marquee Effect with the help of Timer
        .onReceive(Timer.publish(every: ((systemViewModel.textSpeed) + delay), on: .main, in: .default).autoconnect()){ _ in
            
            show.toggle()
            withAnimation (.linear(duration: (systemViewModel.textSpeed))){
                show.toggle()
            }

            // Thus its look like its looping
        }
        
    }
    
    func widthOfText() -> CGFloat {
        
        return systemViewModel.textToShow.widthOfString(usingFont: UIFont(name: systemViewModel.textFont, size: systemViewModel.textSize) ?? .systemFont(ofSize: systemViewModel.textSize))
    }
    
}



extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
}
