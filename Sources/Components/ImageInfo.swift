//
//  File.swift
//  IgniteStarter
//
//  Created by Phil Wigglesworth on 8/17/24.
//

import Foundation
import SwiftUI

struct ImageInfo {
    
    static let sugggestedWidth: Int = 400
    static let suggestedHeight: Int = 400
    
    var name: String
    var path: String
    var width: Int
    var height: Int
    var webPath: String { "/images/\(name)" }
    var suggestedWidth: Int { if width > height { ImageInfo.sugggestedWidth } else { (ImageInfo.sugggestedWidth * width) / height } }
    var suggestedHeight: Int { if width > height { ImageInfo.suggestedHeight } else { (ImageInfo.suggestedHeight * height) / width } }
    
    init(path: String, name: String) {
        self.name = name
        self.path = path
        
        let fullName = path+"/"+name
//        print("Image Name: \(fullName)")
        let image = CIImage(contentsOf: URL(filePath: fullName))
        
        if let image {
            width = Int(image.extent.width)
            height = Int(image.extent.height)
        } else {
            width = 100
            height = 100
        }
        
    }
    
    
}
