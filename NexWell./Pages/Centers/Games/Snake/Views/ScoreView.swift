//
//  ScoreView.swift
//  Snake
//
//  Created by Denis Horvat  on 28.08.2023.
//

import SwiftUI

struct ScoreView: View {
    
    var score: Int = 0
    var topScore: Int = 0
    
    var body: some View {
        
        HStack{
            HStack() {
                Text(" Score:")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("\(score)")
                    .font(.title)
                    .foregroundColor(.white)
            }
            Spacer()
            HStack() {
                Text("Top score: ")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("\(topScore) ")
                    .font(.title)
                    .foregroundColor(.white)
            }
//            Spacer()
//            NavigationLink(destination: MainMenuView()){
//                Text("HOME")
//                    .foregroundColor(.white)
//            }
        }
        .frame(height: 50)
        .background(.black)
        
    }
}
        

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score:10)
    }
}
