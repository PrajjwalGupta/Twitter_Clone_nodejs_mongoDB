//
//  MultiLineTextField.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 22/11/24.
//

import SwiftUI

struct MultiLineTextField: UIViewRepresentable {
    func makeCoordinator() -> MultiLineTextField.Coordinator {
        return MultiLineTextField.Coordinator(parent1: self)
    }
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> some UITextView {
        let text = UITextView()
        text.isEditable = true
        text.text = "Type Something..."
        text.isUserInteractionEnabled = true
        text.textColor = .gray
        text.font = .systemFont(ofSize: 16)
        text.delegate = context.coordinator
        return text
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: MultiLineTextField
        init(parent1: MultiLineTextField) {
            parent = parent1
        }
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .black
        }
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
    }
}
//
//#Preview {
//    MultiLineTextField()
//}
