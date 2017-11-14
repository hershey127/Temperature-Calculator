//
//  AnalyzeData.swift
//  Temperature Calculator

//  Created by Harshitha Tadinada on 10/7/2017.
//  Copyright © 2017 UGA. All right
//

import Foundation
import UIKit

class AnalyzeData{
    func pixel(in image: UIImage, at point: CGPoint) -> (UInt8, UInt8, UInt8)? {
        let width = Int(image.size.width)
        let height = Int(image.size.height)
        let x = Int(point.x)
        let y = Int(point.y)
        guard x < width && y < height else {
            return nil
        }
        guard let cfData:CFData = image.cgImage?.dataProvider?.data, let pointer = CFDataGetBytePtr(cfData) else {
            return nil
        }
        let bytesPerPixel = 4
        let offset = (x + y * width) * bytesPerPixel
        return (pointer[offset], pointer[offset + 1], pointer[offset + 2])
    }
}

