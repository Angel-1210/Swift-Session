//
//  UIView+FirstResponder.swift
//  Session
//
//  Created by Dharmesh  on 08/01/16.
//  Copyright © 2016 Dharmesh. All rights reserved.
//

import UIKit

extension UIView {
    
    func currentFirstResponder() -> UIResponder? {
        
        if self.isFirstResponder() {
            return self
        }
        
        for view in self.subviews {
            if let responder = view.currentFirstResponder() {
                return responder
            }
        }
        return nil
    }
}
