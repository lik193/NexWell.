//
//  ButtonView.swift
//  Snake
//
//  Created by Denis Horvat  on 28.08.2023.
//

import SwiftUI

struct ButtonView: View {
    
    var imageName: String = "arrow.up"
    let snColor = Color(red: 74/250, green: 250/255, blue: 30/255)
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 80, height: 80)
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(color: snColor, radius: 4)
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(.black)
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
