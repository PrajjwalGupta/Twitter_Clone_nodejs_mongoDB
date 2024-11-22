//
//  Extensions.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 22/11/24.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resolveInstanceMethod(_:)), to: nil, from: nil, for: nil)
    }
}
