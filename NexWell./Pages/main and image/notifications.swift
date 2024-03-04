//
//  notifications.swift
//  NexWell.
//
//  Created by Keoni Li on 10/22/23.
//


import SwiftUI
import UserNotifications
import CoreData

struct NotificationsView: View {
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(
        entity: CDNotification.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CDNotification.date, ascending: true)]
    ) private var notifications: FetchedResults<CDNotification>
    
    @State private var showNotificationOptions = false
    @State private var selectedDate = Date()
    @State var message = ""
    
    let c1 : Color
    let c2 : Color
    let c3 : Color
    
    var body: some View {
        VStack {
            
            
            if showNotificationOptions {
                VStack {
                    ZStack {
                        regRR(widthDiv: 1.3, heightDiv: 4.5, color: .white, text: "", tColor: .white)
                            .opacity(0.5)
                            .shadow(color: .black, radius: 5)
                        
                        DatePicker("Select Time", selection: $selectedDate, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                    }
                    
                    ZStack {
                        regRR(widthDiv: 1.3, heightDiv: 12, color: c2, text: "", tColor: .white)
                            .opacity(0.5)
                        
                        TextField("Message", text: $message)
                            .frame(width: UIScreen.main.bounds.width / 1.75)
                    }.offset(y: 10)
                    
                    
                        
                        
                    Button {
                        let id = UUID().uuidString
                        let cdNotification = CDNotification(context: self.managedObjectContext)
                        cdNotification.id = id
                        cdNotification.date = self.selectedDate
                        cdNotification.message = self.message  // Set the message attribute here

                        do {
                            try self.managedObjectContext.save()
                            scheduleNotification(id: id)
                            showNotificationOptions.toggle()
                        } catch {
                            print("Error saving to Core Data: \(error)")
                        }
                    } label: {
                        ZStack {
                            regRR(widthDiv: 2, heightDiv: 15, color: c3, text: "", tColor: .white)
                                .opacity(0.8)
                            Text("Set Reminder")
                                .foregroundStyle(.white)
                        }
                        
                    }
                    .offset(y: 20)
                }
                
                
            }
            
                        
            Button {
                showNotificationOptions.toggle()
            } label: {
                ZStack {
                    regRR(widthDiv: 2, heightDiv: 15, color: .blue, text: "", tColor: .white)
                        .opacity(0.8)
                    Text(showNotificationOptions ? "Cancel" : "Add reminder")
                        .foregroundStyle(.white)
                        
                }
                .offset(y: showNotificationOptions ? 25 : 0)
            }
            
            if !showNotificationOptions {
                Text("\nNotifications will be sent daily for the following reminders: ")
                    .frame(width: UIScreen.main.bounds.width / 1.4)
            }
            
            if !showNotificationOptions {
                ScrollView {
                    VStack {
                        ForEach(notifications, id: \.self) { notification in
                            ZStack {
                                regRR(widthDiv: 1.3, heightDiv: 10, color: .blue, text: "", tColor: .white)
                                    .opacity(0.5)
                                
                                
                                VStack {
                                    Text(notification.message ?? "No message")
                                    Text(notification.date!, style: .time)
                                }
                                .frame(width: UIScreen.main.bounds.width / 1.5)
                                
                                Button {
                                    deleteNotification(notification)
                                } label: {
                                    buttonCirc(color: .red, r1: 45, r2: 35, text: "trash.circle.fill", textColor: .white, size: 30)
                                }
                                .offset(x: UIScreen.main.bounds.width * 0.3)
                                
                            }
                        }
                    }
                }
                .offset(y: 15)
                
            }
            
        }
        .padding()
        .offset(y:25)
    }
    
    func scheduleNotification(id: String) {
        guard let notification = notifications.first(where: { $0.id == id }) else { return }
            let content = UNMutableNotificationContent()
            content.title = notification.message ?? "No message"  // Use the message from Core Data
            content.sound = UNNotificationSound.default
        
        var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: selectedDate)
        dateComponents.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    func deleteNotification(_ notification: CDNotification) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notification.id!])
        self.managedObjectContext.delete(notification)

        do {
            try self.managedObjectContext.save()
        } catch {
            print("Error deleting from Core Data: \(error)")
        }
    }

}


struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView(c1: .blue, c2: .cyan, c3: .green)
    }
}
