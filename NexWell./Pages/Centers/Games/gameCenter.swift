//
//  gameCenter.swift
//  NexWell.
//
//  Created by Keoni Li on 8/27/23.
//

import SwiftUI

//Now just need the reverse implementation of the bubbles
//Also include rdf if figured out
//Demo of both idk

struct gameCenter: View {
    struct LinkItem {
        let url: String
        let title: String
        private let colorValue: Int
        private let colorValue2: Int
        
        var color: Color {
            switch colorValue {
            case 1:
                return Color(red: 102/255, green: 127/255, blue: 1)
            case 2:
                return Color(red: 2/255, green: 98/255, blue: 176/255)
            case 3:
                return Color(red: 41/255, green: 41/255, blue: 158/255)
            default:
                return Color.black
            }
        }
        
        var color2: Color {
            switch colorValue2 {
            case 1:
                return Color(red: 102/255, green: 127/255, blue: 1)
            case 2:
                return Color(red: 2/255, green: 98/255, blue: 176/255)
            case 3:
                return Color(red: 41/255, green: 41/255, blue: 158/255)
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
        LinkItem(url: "https://gameforge.com/en-US/littlegames/spiral-roll/#", title: "Spiral Roll", color: 1),
        LinkItem(url: "https://www.silvergames.com/en/color-match#", title: "Color Match", color: 1),
        LinkItem(url: "https://gameforge.com/en-US/littlegames/drop-stack-ball/", title: "Drop Stack", color: 2),
        LinkItem(url: "https://www.gameflare.com/online-game/home-sheep-home/", title: "Home Sheep Home", color: 2),
        LinkItem(url: "https://www.crazygames.com/game/poly-art-3d", title: "Poly Art", color: 3),
        LinkItem(url: "https://www.dailyjigsawpuzzles.net/landscape-jigsaws/relaxing-in-the-park_4047.html", title: "Jigsaw Puzzles", color: 3),
        LinkItem(url: "https://www.yad.com/Flow-Free", title: "Flow Free", color: 1),
        LinkItem(url: "https://play2048.co/", title: "2048", color: 1)
        
    ]
    
    var v: some View {
        //Utilize this for small distinctive rr
        Text("Games")
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
                            HStack {
                                NavigationLink(destination: SnakeMainView(selectedSnakeSpeed: Int(0.15), selectedSnakeSize: 5)) {
                                    listThing(title: "Snake (Offline)", color: Color(red: 102/255, green: 127/255, blue: 1), color2: Color(red: 2/255, green: 98/255, blue: 176/255), widthDiv: 2.1, heightDiv: 7.5)
                                }
                                
                                NavigationLink(destination: GameView()) {
                                    listThing(title: "Bubbles", color: Color(red: 102/255, green: 127/255, blue: 1), color2: Color(red: 2/255, green: 98/255, blue: 176/255), widthDiv: 2.1, heightDiv: 7.5)
                                }
                            }
                            
                            
                            
                            
                            invisBox(height: 250)
                            
                            

                        }
                    }
                    .offset(y: UIScreen.main.bounds.height * 0.215 + 40)
                    
                    topBanner(c1: (Color(red: 102/255, green: 127/255, blue: 1)), c2: (light ? .white : .black), c3: .cyan, heightDiv: 3, padding: -UIScreen.main.bounds.height*0.35 + 15, image: "gamecontroller")
                    
                    LinearGradient(colors: [Color(red: 102/255, green: 127/255, blue: 1), Color(red: 2/255, green: 98/255, blue: 176/255), Color(red: 41/255, green: 41/255, blue: 158/255)], startPoint: .leading, endPoint: .bottomTrailing)
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

struct gameCenter_Previews: PreviewProvider {
    static var previews: some View {
        gameCenter(trueGrey: Color(red: 0.1725, green: 0.188, blue: 0.188), light: true)
    }
}
