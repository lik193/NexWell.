//
//  ContentView.swift
//  NexWell.
//
//  Created by Keoni Li on 8/12/23.
//


//Google site for problems?
// https://docs.google.com/forms/d/1FQSP2Ihq9J0-jx1jkGa1ZpnNi0ZgGLOT17T_abolfxM/edit

import SwiftUI
import CoreData

struct ContentView: View {
    @State var light = false

    let trueGrey = Color(red: 0.15, green: 0.188, blue: 0.188)
    
    var body: some View {
        ZStack {
            TabView {
                mainPage(trueGrey: trueGrey, light: $light)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                soundCenter(trueGrey: trueGrey, light: light)
                    .tabItem {
                        Image(systemName: "music.note")
                        Text("Music")
                    }
                gameCenter(trueGrey: trueGrey, light: light)
                    .tabItem {
                        Image(systemName: "gamecontroller")
                        Text("Games")
                    }
                articles(trueGrey: trueGrey, light: light)
                    .tabItem {
                        Image(systemName: "scroll")
                        Text("Articles")
                    }
                HelplineCenter(trueGrey: trueGrey, light: light)
                    .tabItem {
                        Image(systemName: "megaphone")
                        Text("Helpline")
                    }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
