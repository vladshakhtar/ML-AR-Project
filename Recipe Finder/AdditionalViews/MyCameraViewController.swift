//
//  MyCameraViewController.swift
//  Recipe Finder
//
//  Created by Vladislav Stolyarov on 09.07.2023.
//

import Foundation
import SwiftUI

struct MyCameraViewController: UIViewControllerRepresentable {
    
    // MARK: - Properties
    @Binding private var selectedImage: Image?

    // MARK: - init
    init(selectedImage: Binding<Image?>) {
        self._selectedImage = selectedImage
    }
    
    func makeUIViewController(context: Context) -> some UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .camera
        
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> MyCameraViewControllerCoordinator {
        MyCameraViewControllerCoordinator(parentView: self)
    }
    
    
    class MyCameraViewControllerCoordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        private let parentView: MyCameraViewController

        init(parentView: MyCameraViewController) {
            self.parentView = parentView
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                self.parentView.selectedImage = Image(uiImage: image )
            }
        }
        
    }
    
}

