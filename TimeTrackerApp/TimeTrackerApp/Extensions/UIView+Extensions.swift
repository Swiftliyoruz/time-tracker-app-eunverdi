//
//  UIView+Extensions.swift
//  TimeTrackerApp
//
//  Created by Ensar Batuhan Ünverdi on 13.09.2022.
//

import Foundation
import UIKit

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
