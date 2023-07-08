//
//  MyPhPickerController.swift
//  Recipe Finder
//
//  Created by Vladislav Stolyarov on 06.07.2023.
//

import Foundation
import SwiftUI
import PhotosUI

struct MyPhPickerController: UIViewControllerRepresentable {

    // MARK: - Properties
    @Binding private var selectedImage: Image?

    // MARK: - init
    init(selectedImage: Binding<Image?>) {
        self._selectedImage = selectedImage
    }

    // MARK: - UIViewControllerRepresentable
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let pickerController = PHPickerViewController(configuration: configuration)

        // IMPORTANT!
        pickerController.delegate = context.coordinator

        return pickerController
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // intentionally empty
    }

    // MARK: - Coordinator
    func makeCoordinator() -> Coordinator {
        Coordinator(parentView: self)
    }

    class Coordinator: PHPickerViewControllerDelegate {

        private let parentView: MyPhPickerController

        init(parentView: MyPhPickerController) {
            self.parentView = parentView
        }

        func picker(
            _ picker: PHPickerViewController,
            didFinishPicking results: [PHPickerResult]
        ) {
            picker.dismiss(animated: true)

            guard
                let provider = results.first?.itemProvider,
                provider.canLoadObject(ofClass: UIImage.self)
            else { return }

            provider.loadObject(ofClass: UIImage.self) { image, _ in
                self.parentView.selectedImage = Image(uiImage: image as! UIImage)
            }
        }
    }
}

