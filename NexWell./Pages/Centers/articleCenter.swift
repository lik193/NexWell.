//
//  articles.swift
//  NexWell.
//
//  Created by Keoni Li on 9/14/23.
//

import SwiftUI

//https://www.healthhub.sg/programmes/186/MindSG/Discover

//Idea: horizontal bar thing: select for that section to show (menu picker)
//   ---> once section is chosen, animate into horizontal bars, all stacked on top of each other

struct articles: View {
    struct articleItem {
        let url: String
        let title: String
        private let colorValue: Int
        private let colorValue2: Int
        let cat: Int
        

        var color: Color {
            switch colorValue {
            case 1:
                return Color(red: 232/255, green: 167/255, blue: 240/255)
            case 2:
                return Color(red: 232/255, green: 98/255, blue: 176/255)
            case 3:
                return Color(red: 232/255, green: 167/255, blue: 28/255)
            default:
                return Color.black
            }
        }
        
        var color2: Color {
            switch colorValue2 {
            case 1:
                return Color(red: 232/255, green: 167/255, blue: 240/255)
            case 2:
                return Color(red: 232/255, green: 98/255, blue: 176/255)
            case 3:
                return Color(red: 232/255, green: 167/255, blue: 28/255)
            default:
                return Color.black
            }
        }
        
        var category: String {
            switch cat {
            case 1:
                return "Articles"
            case 2:
                return "Self Assessment"
            case 3:
                return "Seeking Support"
            case 4:
                return "More"
            default:
                return "All"
            }
        }
        
        init(url: String, title: String, color: Int, category: Int) {
            self.url = url
            self.title = title
            self.colorValue = color
            
            if color == 3 {
                self.colorValue2 = 1
            }
            else {
                self.colorValue2 = color + 1
            }
            
            self.cat = category
        }
    }
    
    let articlesItems: [articleItem] = [
        articleItem(url: "https://www.psycom.net/", title: "Psycom Articles", color: 1, category: 1),
        articleItem(url: "https://www.health.harvard.edu/topics/mental-health/all", title: "Harvard Health Articles", color: 1, category: 1),
        articleItem(url: "https://magazine.medlineplus.gov/topic/mental-health/#:~:text=,FOIA%3B%20HHS%20Vulnerability%20Disclosure", title: "Medlineplus Articles", color: 2, category: 1),
        
        articleItem(url: "https://www.healthhub.sg/programmes/186/MindSG/About-Mental-Well-Being#home", title: "Mental wellbeing", color: 2, category: 2),
        articleItem(url: "https://www.healthhub.sg/programmes/186/MindSG/Caring-For-Ourselves/Coping-With-Stress-Adults#home", title: "Stress", color: 3, category: 2),
        articleItem(url: "https://www.healthhub.sg/programmes/186/MindSG/Caring-For-Ourselves/Understanding-Depression-Adults#home", title: "Depression", color: 3, category: 2),
        articleItem(url: "https://www.healthhub.sg/programmes/mindsg/caring-for-ourselves/dealing-with-anxiety-disorder-adults#anxiety-self-assessment-tool-questions", title: "Self-Harm", color: 1, category: 2),
        
        
        articleItem(url: "https://www.healthhub.sg/programmes/186/MindSG/Caring-For-Ourselves/Preventing-Self-harm-and-Suicide-Teens#home", title: "Explore", color: 1, category: 3),
        articleItem(url: "https://www.healthhub.sg/programmes/186/MindSG/Caring-For-Ourselves/Experiencing-Social-Isolation-Seniors#home", title: "Social Isolation", color: 2, category: 3),
        articleItem(url: "https://www.healthhub.sg/programmes/mindsg/seeking-support#home", title: "Seek Support", color: 2, category: 3),
        
        articleItem(url: "https://www.healthhub.sg/programmes/mindsg/other-useful-websites#home", title: "More Websites", color: 3, category: 4),
        articleItem(url: "https://www.healthhub.sg/programmes", title: "Programs", color: 3, category: 4),
        articleItem(url: "https://www.mindline.sg/home", title: "The Mindline", color: 1, category: 4)
    ]
    
    let trueGrey : Color
    var light: Bool
    @State private var isLinkSelected: Bool = false
    @State private var selectedCategory: Int = 0
    
    var v: some View {
        Text("Resources")
            .font(.system(size: 50, weight: .heavy))
            .foregroundColor(.white)
    }
    
    var filteredArticles: [articleItem] {
        if selectedCategory == 0 {
            return articlesItems
        } else {
            return articlesItems.filter { $0.cat == selectedCategory }
        }
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    (light ? .white : trueGrey).ignoresSafeArea()
                    
                    
                    ScrollView {
                        
                        ZStack {
                            regRR(widthDiv: 1.5, heightDiv: 20, color: (light ? .white : trueGrey), text: "", tColor: .white)
                                .shadow(color: (light ? .black : .white), radius: 3)
                                
                            
                            Picker("Category", selection: $selectedCategory) {
                                Text("Show All").tag(0)
                                Text("Articles").tag(1)
                                Text("Self Assessment").tag(2)
                                Text("Seeking Support").tag(3)
                                Text("More").tag(4)
                            }
                            .pickerStyle(MenuPickerStyle())
                            
                        }
                        .offset(y: 80)
                        .padding(5)
                        
                        LazyVStack {
                            invisBox(height: 75)
                            
                            // Calculate the number of rows and create an array of row indices
                            let numberOfRows = (articlesItems.count + 1) / 2
                            let rowIndices = Array(0..<numberOfRows)
                            
                            // Iterate over the array of row indices
                            ForEach(0..<numberOfRows, id: \.self) { rowIndex in
                                HStack {
                                    // Left item (even index)
                                    let leftIndex = rowIndex * 2
                                    if leftIndex < filteredArticles.count {
                                        let item = filteredArticles[leftIndex]
                                        NavigationLink(destination: LinkEmbedd(trueGrey: (light ? .white : trueGrey), regRRColor: item.color, link: item.url)) {
                                                listThing(title: item.title, color: item.color, color2: item.color2, widthDiv: 2.1, heightDiv: 7.5)
                                            }
                                        }
                                        Spacer()
                                                                    
                                        // Right item (odd index)
                                    let rightIndex = rowIndex * 2 + 1
                                    if rightIndex < filteredArticles.count {
                                        let item = filteredArticles[rightIndex]
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
                    
                    
                    topBanner(c1: (Color(red: 232/255, green: 167/255, blue: 240/255)), c2: (light ? .white : .black), c3: Color(red: 232/255, green: 167/255, blue: 28/255), heightDiv: 3, padding: -UIScreen.main.bounds.height*0.35 + 15, image: "scroll")
                    
                    LinearGradient(colors: [Color(red: 232/255, green: 167/255, blue: 240/255), Color(red: 232/255, green: 98/255, blue: 176/255), Color(red: 232/255, green: 167/255, blue: 28/255)], startPoint: .leading, endPoint: .bottomTrailing)
                        .frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/5)
                        .mask(v)
                        .offset(x: UIScreen.main.bounds.width * -0.1, y: UIScreen.main.bounds.height * -0.25)
                }
            }
            .frame(height: UIScreen.main.bounds.height/0.9)
            .offset(y: UIScreen.main.bounds.height * -0.08)
            
        }
    }
}

struct articles_Previews: PreviewProvider {
    static var previews: some View {
        articles(trueGrey: Color(red: 0.1725, green: 0.188, blue: 0.188), light: false)
    }
}
