//
//  mainPage.swift
//  NexWell.
//
//  Created by Keoni Li on 8/12/23.
//

import SwiftUI
import CoreData

struct mainPage: View {
    @State var color1 : Color = Color(red: 130/255, green: 1, blue: 218/255)
    @State var color2 : Color = Color(red: 50/255, green: 247/255, blue: 250/255)
    @State var color3 : Color = Color(red: 7/255, green: 185/255, blue: 250/255)
    
    let accentColor = Color(red: 200/255, green: 1, blue: 1)
    let trueGrey : Color
    
    @State var searchFor = ""
    @State private var bookingAction = false
    @Binding var light : Bool
    
    // for images
    @State private var selectedImage: Image? = nil
    @State private var isImagePickerPresented: Bool = false
    @State private var isImageViewerPresented: Bool = false
    
    // for notifications
    @State private var notificationsPresented = false
    
    var body: some View {
        ZStack {
            (light ? .white : trueGrey)
                .ignoresSafeArea()
            
            //Use a top bar banner
            
            
            ScrollView {
                invisBox(height: UIScreen.main.bounds.height * 0.1 - 55)
                HStack {
                    Text("N  E  X  W  E  L  L")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(color3)
                        .offset(y: -7.5)
                    //Includes hamburger buttons and Bell Icon
                }
                
                VStack {
                    //On top is the search bar with the search button
                    HStack {
                        Button {
                            isImagePickerPresented.toggle()
                        } label: {
                            regRR(widthDiv: 3.5, heightDiv: 17.5, color: color2, text: "Select image", tColor: .white)
                                .presentationDetents([.fraction(0.75)])
                        }
                        .sheet(isPresented: $isImagePickerPresented) {
                            ImagePicker(selectedImage: $selectedImage, isPresented: $isImagePickerPresented)
                                .presentationDetents([.fraction(0.75)])
                        }
                        
                        Button {
                            isImageViewerPresented.toggle()
                        } label: {
                            regRR(widthDiv: 3.5, heightDiv: 17.5, color: color2, text: "View Image", tColor: .white)
                        }
                        .sheet(isPresented: $isImageViewerPresented) {
                            imageViewer()
                                .presentationDetents([.fraction(0.75)])
                        }
                        
                        Button {
                            notificationsPresented.toggle()
                        } label: {
                            regRR(widthDiv: 3.5, heightDiv: 17.5, color: color2, text: "Reminders", tColor: .white)
                        }
                        .sheet(isPresented: $notificationsPresented) {
                            NotificationsView(c1: color1, c2: color2, c3: color3)
                                .presentationDetents([.fraction(0.75)])
                        }
                        
                    }
                    .offset(y: -UIScreen.main.bounds.height * 0.025)
                    .onAppear {
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
                        // Handle permission granted or error
                        }
                    }
                    
                    ZStack {
                        perimeterRR(widthDiv: 1.05, heightDiv: 5, innerColor: accentColor, color2: color3, offY: 0.25, offX: 0)
                            .offset(y:-50)
                        
                        Text("Today's Quote")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(color3)
                            .offset(y: -5)
                            
                        
                         quoteView(light: light, widthDiv: 1.2)
                             .offset(y: 55)
                        
                    }
                    .offset(y: -UIScreen.main.bounds.height * 0.05 - 25)
                    
                    ZStack{
                        perimeterRR(widthDiv: 1.05, heightDiv: 6, innerColor: accentColor, color2: color3, offY: 0, offX: 0)
                        
                        VStack (alignment: .leading){
                            Text("Need Someone to Talk To? \nWe Are Here to Support you")
                                .foregroundStyle(light ? .black : .white)
                            Button(action: {
                                        bookingAction.toggle()
                                    }) {
                                        regRR(widthDiv: 1.9, heightDiv: 20, color: color3, text: "Book an appointment", tColor: .white)
                                    }
                                    .sheet(isPresented: $bookingAction) {
                                        booking(backgroundCol: (light ? .white: trueGrey))
                                            .presentationDetents([.fraction(0.9)])
                                    }
                        }
                    }
                    .offset(y: -UIScreen.main.bounds.height * 0.0125 - 10)
                    
                    wave(isAnimating: true, color: color3)
                        .offset(y: -UIScreen.main.bounds.height * 0.005)
                    
                    
                    mainButtonsStuff(color1: $color1, color2: $color2, color3: $color3, light: $light, trueGrey: light ? .white : trueGrey)
                    
                }
                
            }
            .frame(height: UIScreen.main.bounds.height/1)
            .offset(y: UIScreen.main.bounds.height * 0.12 - 70)

        }
        /*
         .onAppear {
             loadColors()
         }
         */
        
        
    }
    
    /*
     func loadColors() {
         let viewContext = PersistenceController.shared.container.viewContext
         let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()

         do {
             let results = try viewContext.fetch(fetchRequest)
             guard let entity = results.first else { return }

             self.color1 = Color(
                 red: Double(entity.c1r),
                 green: Double(entity.c1g),
                 blue: Double(entity.c1b)
             )

             self.color2 = Color(
                 red: Double(entity.c2r),
                 green: Double(entity.c2g),
                 blue: Double(entity.c2b)
             )

             self.color3 = Color(
                 red: Double(entity.c3r),
                 green: Double(entity.c3g),
                 blue: Double(entity.c3b)
             )

             self.light = entity.light
             
         } catch {
             let nsError = error as NSError
             fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
         }
     }
     */
    
    
}

struct mainPage_Previews: PreviewProvider {
    static var previews: some View {
        mainPage(trueGrey: Color(red: 0.1725, green: 0.188, blue: 0.188), light: .constant(false))
    }
}
