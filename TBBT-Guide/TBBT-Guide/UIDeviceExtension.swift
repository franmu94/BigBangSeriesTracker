//
//  UIDeviceExtension.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 18/9/24.
//

import SwiftUI

extension UIDevice {
    static var width: CGFloat {
        UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first { $0.isKeyWindow }?
            .screen
            .bounds
            .width ?? 0
    }
    
    static var height: CGFloat {
        UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first { $0.isKeyWindow }?
            .screen
            .bounds
            .height ?? 0
    }
}
