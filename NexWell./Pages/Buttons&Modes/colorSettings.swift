//
//  colorSettings.swift
//  NexWell.
//
//  Created by Keoni Li on 10/16/23.
//

import SwiftUI
import CoreData
import UIKit

struct colorSettings: View {
    @Binding var color1: Color
    @Binding var color2: Color
    @Binding var color3: Color
    @Binding var light: Bool
    let trueGrey : Color
    
    @State private var c1 = Color(red: 130/255, green: 1, blue: 218/255)
    @State private var c2 = Color(red: 50/255, green: 247/255, blue: 250/255)
    @State private var c3 = Color(red: 7/255, green: 185/255, blue: 250/255)
    
    
    @Environment(\.presentationMode) var presentationMode

        var body: some View {
            ZStack {
                (light ? Color.white : trueGrey)
                    .ignoresSafeArea()
                
                ZStack {
                    
                    Text("Appearances")
                        .foregroundStyle(light ? .black : .white)
                        .font(.system(size: 25, weight: .heavy))
                        .offset(y: -UIScreen.main.bounds.height * 0.05 - 180)
                    
                    LinearGradient(colors: [color1,color2,color3], startPoint: .leading, endPoint: .bottomTrailing)
                        .frame(width: 335, height: 375)
                        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 325, height: 365)
                        .foregroundStyle(.black)
                        .opacity(0.5)
                    
                    VStack {
                        
                        VStack {
                            ColorPicker("Select Color 1", selection: $c1)
                                .padding(10)
                            ColorPicker("Select Color 2", selection: $c2)
                                .padding(10)
                            ColorPicker("Select Color 3", selection: $c3)
                                .padding(10)
                                
                        }
                        .font(.system(size: 25, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: UIScreen.main.bounds.width / 1.5)
                        .offset(y: -20)
                        
                        
                        
                        HStack {
                            Button(action: {
                                color1 = c1
                                color2 = c2
                                color3 = c3
                                self.presentationMode.wrappedValue.dismiss()
                                /*
                                 saveColors(color1: c1, color2: c2, color3: c3, light: self.light)

                                 */
                            }) {
                                buttonCirc(color: .green, r1: 70, r2: 60, text: "checkmark.circle.fill", textColor: .white, size: 40)
                            }
                            
                            Button {
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                buttonCirc(color: .red, r1: 70, r2: 60, text: "x.circle.fill", textColor: .white, size: 40)
                            }
                            
                            Button {
                                light.toggle()
                            } label: {
                                ZStack {
                                    Circle()
                                        .frame(width: 70)
                                        .foregroundStyle(light ? .black : .white)
                                
                                    (light ? Image(systemName: "moon.stars.circle") : Image(systemName: "sun.max.circle"))
                                        .font(.system(size: 50))
                                        .foregroundStyle(light ? .white: .black)
                                }
                            }
                        }
                        .offset(y:20)
                        
                    }
                    
                    Text("Colors are autimatically at default.")
                        .frame(width: 270)
                        .foregroundStyle(light ? .black : .white)
                        .offset(y:220)
                }
            }
        }
    /*
     func saveColors(color1: Color, color2: Color, color3: Color, light: Bool) {
         let viewContext = PersistenceController.shared.container.viewContext
         let entity = Item(context: viewContext)
         
         let uiColor1 = UIColor(color1)
         let uiColor2 = UIColor(color2)
         let uiColor3 = UIColor(color3)
         
         let (r1, g1, b1, _) = uiColor1.rgba
         let (r2, g2, b2, _) = uiColor2.rgba
         let (r3, g3, b3, _) = uiColor3.rgba
         
         entity.c1r = (r1)
         entity.c1g = (g1)
         entity.c1b = (b1)
         
         entity.c2r = (r2)
         entity.c2g = (g2)
         entity.c2b = (b2)
         
         entity.c3r = (r3)
         entity.c3g = (g3)
         entity.c3b = (b3)
         
         entity.light = light

         do {
             try viewContext.save()
         } catch {
             let nsError = error as NSError
             fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
         }
     }
     */
    
    
}

/*
 extension UIColor {
     var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
         var red: CGFloat = 0
         var green: CGFloat = 0
         var blue: CGFloat = 0
         var alpha: CGFloat = 0
         getRed(&red, green: &green, blue: &blue, alpha: &alpha)
         return (red, green, blue, alpha)
     }
 }

 */


#Preview {
    colorSettings(color1: .constant(.blue), color2: .constant(.cyan), color3: .constant(.green), light: .constant(false), trueGrey: Color.gray)
}
