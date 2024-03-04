//
//  HelplineCenter.swift
//  NexWell.
//
//  Created by Keoni Li on 9/19/23.
//

import SwiftUI

struct HelplineCenter: View {
    
    struct callItem {
        let number: String
        let title: String
        let description: String
        private let colorValue: Int
        private let colorValue2: Int
        
        var color: Color {
            switch colorValue {
            case 1:
                return Color(red: 235/255, green: 110/255, blue: 206/255)
            case 2:
                return Color(red: 28/255, green: 198/255, blue: 232/255)
            case 3:
                return Color(red: 102/255, green: 127/255, blue: 1)
            default:
                return Color.black
            }
        }
        
        var color2: Color {
            switch colorValue2 {
            case 1:
                return Color(red: 235/255, green: 110/255, blue: 206/255)
            case 2:
                return Color(red: 28/255, green: 198/255, blue: 232/255)
            case 3:
                return Color(red: 102/255, green: 127/255, blue: 1)
            default:
                return Color.black
            }
        }

        init(number: String, title: String, description: String, color: Int) {
            self.number = number
            self.title = title
            self.description = description
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
    
    let contacts: [callItem] = [
        callItem(number: "+65-6389-2222", title: "IMH Mental Health Helpline", description: "", color: 1),
        callItem(number: "1800-377-2252", title: "TOUCHline (Counselling)", description: "", color: 2),
        callItem(number: "+65-6732-683", title: "All addictions (NAMS)", description: "", color:3),
        callItem(number: "1800-202-6868", title: "National Care Hotline", description: "(Psychological and emotional support to those who need a listening ear. After midnight, interactive voice recording directs callers to 24 hour helplines).", color: 1),
        callItem(number: "+65-6978-2728", title: "Hear4U Care Singapore", description: "Offers non-crises psychological first aid and support to anyone in Singapore on WhatsApp Tel/WA 6978 2728. Mon-Fri 10am-10pm", color: 2),
        callItem(number: "+65-6655-0000", title: "Assisline / Brahm Centre", description: "Provides support, for youth who are struggling emotionally and parents who need support in better parenting and communication strategies.  Tel: 6655 0000  /  8823 0000 WhatsApp", color: 3),
        callItem(number: "1800-274-478", title: "Tinkle Friend Helpline ", description: "Provides support, advice and information to primary school children in distress, especially in situations where the parents or main caregivers are unavailable. Mon-Fri 2.30-5pm", color: 1),
        callItem(number: "1800-777-5555", title: "Association of Women for Action and Research", description: "Offers information, help, empathy and support for women in need. Services include crisis counselling, assistance in dealing with authorities, and legal advice. Mon - Fri: 10am - 6pm", color: 2),
        callItem(number: "1800-353-5800", title: "Care Corner Counselling Hotline (Mandarin)", description: "Provide support for individuals who need a listening ear. Mon - Sun: 10am - 10pm (excluding PH)", color: 3),
        callItem(number: "1800-6123-123", title: "HELP123 by TOUCH Youth Integrated Team", description: "For individuals who would like to find out more or get help on cyber wellness issues. Mon - Fri: 9am - 6pm (excluding PH)", color: 1),
        callItem(number: "1800-283-7019", title: "Singapore Association for Mental Health (SAMH)", description: "For individuals, couples and families with psychological, psychiatric and/or relationship problems. Mon - Fri: 9am - 6pm (excluding PH)", color: 2),
        callItem(number: "+65-6555-0390", title: "PAVE: Individual and Family Protection", description: "", color: 3),
        callItem(number: "+65-6449-9088", title: "TRANS SAFE Centre", description: "", color: 1)
        
    ]
     
    var v: some View {
        Text("Call")
            .font(.system(size: 60, weight: .heavy))
            .foregroundColor(.white)
    }
    
    @State private var selectedNumber: String? = nil
    @State private var numberDesciption: String? = nil
    @State private var showAlert = false

    var body: some View {
        ZStack {
            (light ? .white : trueGrey)
                .ignoresSafeArea()
            
                ScrollView {
                    VStack {
                        invisBox(height: 75)
                        ForEach(contacts, id: \.number) { item in
                            Button(action: {
                                self.selectedNumber = item.number
                                self.numberDesciption = item.description
                                self.showAlert = true
                            }) {
                                ZStack {
                                    listThing(title: item.title, color: item.color, color2: item.color2, widthDiv: 1.05, heightDiv: 10)
                                }
                                    
                            }
                        }
                        invisBox(height: 150)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Confirm Call"),
                            message: Text("Are you sure you want to call \(selectedNumber ?? "")? \(numberDesciption ?? "")"),
                            primaryButton: .default(Text("Call"), action: {
                                if let number = selectedNumber,
                                    let encodedNumber = number.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
                                    let url = URL(string: "tel://\(encodedNumber.replacingOccurrences(of: "-", with: ""))") {
                                        UIApplication.shared.open(url)
                                }
                            }),
                            secondaryButton: .cancel()
                        )
                    }
                }
                .offset(y: UIScreen.main.bounds.height * 0.13 - 15)
            
            topBanner(c1: (Color(red: 235/255, green: 110/255, blue: 206/255)), c2: (light ? .white : .black), c3: Color(red: 102/255, green: 127/255, blue: 1), heightDiv: 3.2, padding: -UIScreen.main.bounds.height*0.365 - 25, image: "megaphone")
            
            LinearGradient(colors: [Color(red: 235/255, green: 110/255, blue: 206/255), Color(red: 28/255, green: 198/255, blue: 232/255), Color(red: 102/255, green: 127/255, blue: 1)], startPoint: .leading, endPoint: .bottomTrailing)
                    .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height/7)
                    .mask(v)
                    .offset(x: UIScreen.main.bounds.width * -0.285, y: UIScreen.main.bounds.height * -0.31 - 10)
            
        }
        
    }
}

struct HelplineCenter_Previews: PreviewProvider {
    static var previews: some View {
        HelplineCenter(trueGrey: Color(red: 0.1725, green: 0.188, blue: 0.188), light: true)
    }
}
