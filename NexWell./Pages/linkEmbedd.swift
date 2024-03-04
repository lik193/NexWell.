//
//  linkEmbedd.swift
//  NexWell.
//
//  Created by Keoni Li on 8/27/23.
//

import SwiftUI
import WebKit

//Seeds game author is Andrew MacMurray - should i include?

struct LinkEmbedd: View {
    let trueGrey : Color
    let color1 = Color(red: 130/255, green: 1, blue: 218/255)
    let regRRColor : Color
    
    let link : String
    @State private var viewLink = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            trueGrey
                .ignoresSafeArea()
            VStack {
                
                ZStack {
                    
                    regRR(widthDiv: 1.05, heightDiv: 1, color: regRRColor, text: "", tColor: .white)
                        .offset(y: UIScreen.main.bounds.width * -0.23  + 25)
                    
                    WebView(url: URL(string: link)!)
                        .frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height * 0.65 + 90)
                        .cornerRadius(35)
                        .offset(y: UIScreen.main.bounds.width * 0.12 - 75)
                }
                
                if !viewLink {
                    Button {
                        viewLink.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            viewLink.toggle()
                        }
                    } label: {
                        Text("Reveal link")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .bold))
                    }
                    .offset(y: -UIScreen.main.bounds.width * 0.85 + 220)
                }
                
                if viewLink {
                    Text(link)
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .bold))
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                        .offset(y: -UIScreen.main.bounds.width * 0.85 + 220)
                }
                
                
            }
            .offset(y:25)
            
            
            Button(action: { dismiss() } ) {
                ZStack {
                    Circle()
                        .foregroundStyle(.black)
                        .frame(width: 45)
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(.white)
                        
                }
                
                    
            }
            .navigationBarBackButtonHidden(true)
            .offset(x: -UIScreen.main.bounds.width / 2.75 + 5, y: -UIScreen.main.bounds.height/3.4 - 55)
            
        }
        .offset(y: -UIScreen.main.bounds.height * 0.03 + 65)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: self.url)
        uiView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Failed to load: \(error.localizedDescription)")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished loading")
    }

    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        // Add delegate methods if needed
    }
}


struct linkEmbedd_Previews: PreviewProvider {
    static var previews: some View {
        LinkEmbedd(trueGrey: Color(red: 0.1725, green: 0.188, blue: 0.188), regRRColor: .cyan, link: "https://www.seedsgame.com")
    }
}
