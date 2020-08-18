//
//  UIImage+Extension.swift
//  Eldo Luck
//
//  Created by Zimma on 16.05.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import UIKit

extension UIImage {
    func colored(in color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            color.set()
            self.withRenderingMode(.alwaysTemplate).draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
