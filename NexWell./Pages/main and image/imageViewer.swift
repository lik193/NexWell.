//
//  imageViewer.swift
//  NexWell.
//
//  Created by Keoni Li on 10/22/23.
//

import SwiftUI
import CoreData

struct imageViewer: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        if let uiImage = fetchImage(context: viewContext) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        } else {
            Text("No Image Selected")
        }
    }

    
    
    func fetchImage(context: NSManagedObjectContext) -> UIImage? {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        fetchRequest.fetchLimit = 1
        
        do {
            let items = try context.fetch(fetchRequest)
            guard let imageData = items.first?.imageData,
                  let image = UIImage(data: imageData) else {
                return nil
            }
            return image
        } catch {
            print("Error fetching image: \(error)")
            return nil
        }
    }
}


struct imageViewer_Previews: PreviewProvider {
    @State static var dummyImage: Image? = nil
    
    static var previews: some View {
        imageViewer()
    }
}
