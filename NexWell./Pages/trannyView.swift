//
//  trannyView.swift
//  NexWell.
//
//  Created by Keoni Li on 9/25/23.
//

import SwiftUI

struct trannyView: View {
    var body: some View {
        ZStack {
            Text("Hello")
                .font(.custom("CroissantOne-Regular", size: 50))
        }
    }
    init() {
        for f in UIFont.familyNames {
            print(f)
            
            for fN in UIFont.fontNames(forFamilyName: f) {
                print("-- \(fN)")
            }
        }
    }
}

struct trannyView_Previews: PreviewProvider {
    static var previews: some View {
        trannyView()
    }
}
