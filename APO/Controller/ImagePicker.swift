//
//  ImagePicker.swift
//  APO
//
//  Created by Kacper on 30/08/2021.
//

import Foundation

import SwiftUI


struct ImagePicker : UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(imagePicker: self)
    }
    
    final class Coordinator : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        let imagePicker : ImagePicker
        init(imagePicker : ImagePicker){
            self.imagePicker = imagePicker
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                imagePicker.selectedImage = image
            } else{
                // erroe/alert
            }
            picker.dismiss(animated: true)
        }
    }
}
