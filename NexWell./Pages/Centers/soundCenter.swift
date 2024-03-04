//
//  soundCenter.swift
//  NexWell.
//
//  Created by Keoni Li on 9/8/23.
//

import SwiftUI

//Indicator of which types of music are for which emotions
// Circle, dash, word : All next to the title

struct soundCenter: View {
    struct LinkItem {
        let url: String
        let title: String
        private let colorValue: Int
        private let colorValue2: Int
        
        var color: Color {
            switch colorValue {
            case 1:
                return Color(red: 107/255, green: 1, blue: 159/255)
            case 2:
                return Color(red: 50/255, green: 141/255, blue: 252/255)
            case 3:
                return Color(red: 1, green: 56/255, blue: 132/255)
            default:
                return Color.black
            }
        }
        
        var color2: Color {
            switch colorValue2 {
            case 1:
                return Color(red: 107/255, green: 1, blue: 159/255)
            case 2:
                return Color(red: 50/255, green: 141/255, blue: 252/255)
            case 3:
                return Color(red: 1, green: 56/255, blue: 132/255)
            default:
                return Color.black
            }
        }

        init(url: String, title: String, color: Int) {
            self.url = url
            self.title = title
            self.colorValue = color
            
            if color == 3 {
                self.colorValue2 = 1
            }
            else {
                self.colorValue2 = color + 1
            }
        }
    }
    
    let trueGrey : Color
    var light : Bool
    
    let linkItems: [LinkItem] = [
        //Stress and Anxiety
        LinkItem(url: "https://www.youtube.com/watch?v=79kpoGF8KWU", title: "Stress & Anxiety Detox", color: 1),
        LinkItem(url: "https://www.youtube.com/watch?v=lFcSrYw-ARY", title: "Calming & Relaxing", color: 1),
        LinkItem(url: "https://www.youtube.com/watch?v=3Lt2kuxPIcQ", title: "Stress Release", color: 2),
        
        //Feeling down
        LinkItem(url: "https://www.youtube.com/watch?v=Z-8LsLQsd-o", title: "Diminish Depression", color: 2),
        LinkItem(url: "https://www.youtube.com/watch?v=hC00D_bVm9c", title: "Songs of sorrow", color: 3),
        LinkItem(url: "https://www.youtube.com/watch?v=3pNpHZ1yv3I", title: "Binaural Beats", color: 3),
        
        //Angry
        LinkItem(url: "https://www.youtube.com/watch?v=biajGO7G0_M", title: "Release Anger", color: 1),
        LinkItem(url: "https://www.youtube.com/watch?v=DN5N_w6Mb-c", title: "Flow Free", color: 1),
        LinkItem(url: "https://www.youtube.com/watch?v=8wVtNyJN-pA", title: "Reprogram Resentment", color: 2)

    ]
    
    var v: some View {
        Text("Music")
            .font(.system(size: 60, weight: .heavy))
            .foregroundColor(.white)
    }
    
    var body: some View {
        ZStack {
            
            NavigationView {
                ZStack {
                    (light ? .white : trueGrey).ignoresSafeArea()
                    
                    ScrollView {
                        LazyVStack {
                            invisBox(height: 75)
                            
                            // Calculate the number of rows and create an array of row indices
                            let numberOfRows = (linkItems.count + 1) / 2
                            let rowIndices = Array(0..<numberOfRows)
                            
                            // Iterate over the array of row indices
                            ForEach(rowIndices, id: \.self) { rowIndex in
                                HStack {
                                    // Left item (even index)
                                    let leftIndex = rowIndex * 2
                                    if leftIndex < linkItems.count {
                                        let item = linkItems[leftIndex]
                                        NavigationLink(destination: LinkEmbedd(trueGrey: (light ? .white : trueGrey), regRRColor: item.color, link: item.url)) {
                                            listThing(title: item.title, color: item.color, color2: item.color2, widthDiv: 2.1, heightDiv: 7.5)
                                        }
                                    }
                                    Spacer()
                                    
                                    let rightIndex = rowIndex * 2 + 1
                                    if rightIndex < linkItems.count {
                                        let item = linkItems[rightIndex]
                                        NavigationLink(destination: LinkEmbedd(trueGrey: (light ? .white : trueGrey), regRRColor: item.color, link: item.url)) {
                                            listThing(title: item.title, color: item.color, color2: item.color2, widthDiv: 2.1, heightDiv: 7.5)
                                        }
                                    }
                                }
                            }
                            invisBox(height: 250)

                        }
                    }
                    .offset(y: UIScreen.main.bounds.height * 0.215 + 40)
                    
                    topBanner(c1: (Color(red: 107/255, green: 1, blue: 159/255)), c2: (light ? .white : .black), c3: Color(red: 1, green: 56/255, blue: 132/255), heightDiv: 3, padding: -UIScreen.main.bounds.height*0.35 + 15, image: "music.note")
                    
                    LinearGradient(colors: [Color(red: 107/255, green: 1, blue: 159/255), Color(red: 50/255, green: 141/255, blue: 252/255), Color(red: 1, green: 56/255, blue: 132/255)], startPoint: .leading, endPoint: .bottomTrailing)
                        .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/5)
                        .mask(v)
                        .offset(x: UIScreen.main.bounds.width * -0.175, y: UIScreen.main.bounds.height * -0.25)
                    
                }
            }
            .frame(height: UIScreen.main.bounds.height/0.9)
            .offset(y: UIScreen.main.bounds.height * -0.08)
            
        }
    }
}

struct soundCenter_Previews: PreviewProvider {
    static var previews: some View {
        soundCenter(trueGrey: Color(red: 0.1725, green: 0.188, blue: 0.188), light: true)
    }
}
