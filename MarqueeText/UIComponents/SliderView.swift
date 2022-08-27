//
//  SliderView.swift
//  MarqueeText
//
//  Created by Amini on 25/08/22.
//

import Foundation
import SwiftUI

struct SliderView: View {
    @State var offset: CGFloat = 0
    
    @Namespace var namespace
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                
                Capsule()
                    .fill(Color.black.opacity(0.25))
                    .frame(height: 40)
                    .matchedGeometryEffect(id: "back", in: namespace)
                
                Capsule()
                    .fill(Color.red)
                    .frame(width: offset+40, height: 40)
                    .matchedGeometryEffect(id: "circle", in: namespace)
                
                Circle()
                    .fill(Color.pink)
                    .frame(width: 40, height: 40)
                    .background(Circle().stroke(Color.white, lineWidth: 5))
                    .offset(x: offset)
                    .gesture(DragGesture().onChanged({ (value) in
                        
                        if value.location.x >= 40 && value.location.x <= geo.size.width {
                            
                            offset = value.location.x - 40
                        }
                    }))
            }
        }
    }
}
