//
//  imagePicker.swift
//  NexWell.
//
//  Created by Keoni Li on 10/22/23.
//

import SwiftUI
import UIKit
import CoreData

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.managedObjectContext) private var viewContext  // Access the managed object context
    @Binding var selectedImage: Image?
    @Binding var isPresented: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, context: viewContext)  // Pass the context to the coordinator
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker
        var context: NSManagedObjectContext  // Hold a reference to the managed object context

        init(parent: ImagePicker, context: NSManagedObjectContext) {
            self.parent = parent
            self.context = context
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = Image(uiImage: uiImage)
                saveImage(uiImage)  // Call saveImage here
            }

            parent.$isPresented.wrappedValue = false
        }

        func saveImage(_ image: UIImage) {
            let newItem = Item(context: context)
            newItem.imageData = image.pngData()  // Convert UIImage to Data
            newItem.timestamp = Date()
            
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


struct ImagePicker_Previews: PreviewProvider {
    @State static var dummyImage: Image? = nil
    @State static var dummyIsPresented: Bool = true

    static var previews: some View {
        ImagePicker(selectedImage: $dummyImage, isPresented: $dummyIsPresented)
    }
}
