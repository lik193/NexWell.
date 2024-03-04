//
//  booking.swift
//  NexWell.
//
//  Created by Keoni Li on 9/29/23.
//

import SwiftUI

struct booking: View {
    let backgroundCol: Color
    var body: some View {
        ZStack {
            backgroundCol.ignoresSafeArea()
            WebView(url: URL(string: "https://nexuscounsellors.youcanbook.me/")!)
                .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.65 + 170)
                .cornerRadius(35)
        }
        
    }
}

#Preview {
    booking(backgroundCol: .black)
}
