//
//  SettingItem.swift
//  MarqueeText
//
//  Created by Amini on 25/08/22.
//

import SwiftUI

struct SettingItem: View {
    var namespace: Namespace.ID

    @ObservedObject var numberVM: SettingViewModel

    var id: SystemModel
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.black.opacity(0.25))
                .frame(width: 40, height: 40)
                .matchedGeometryEffect(id: "back\(id.number)", in: namespace)

            
            Image(systemName: "\(id.icon)")
                .matchedGeometryEffect(id: "circle\(id.number)", in: namespace)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .foregroundColor(.gray)
                .onTapGesture {
                    withAnimation(.spring(response: 1.0, dampingFraction: 0.8)) {
                        numberVM.selected = id
                        numberVM.tapped = true
                    }
                }
        }
        .frame(width: 40, height: 40)
    }
}
