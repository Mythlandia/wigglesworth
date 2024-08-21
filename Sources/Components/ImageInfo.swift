//
//  File.swift
//  IgniteStarter
//
//  Created by Phil Wigglesworth on 8/17/24.
//

import Foundation
import SwiftUI

private let fitWidth: Double = 800
private let fitHeight: Double = 600
private let viewAspectRatio:Double = fitWidth / fitHeight

struct ImageInfo {
    
    var name: String
    var path: String
    var width: Int
    var height: Int
    var webPath: String { "/images/\(name)" }
    var latitude: String = ""
    var longitude: String = ""
    var latitudeRef: String = ""
    var longitudeRef: String = ""
    var location: String  {
        if latitude.isEmpty { "" }
        else { latitude + latitudeRef + ", " + longitude + longitudeRef}
    }
    private var imageAspectRatio: Double { Double(width) / Double(height) }
    var suggestedWidth: Int {
        if imageAspectRatio <= viewAspectRatio {
            Int( fitHeight * imageAspectRatio )
        } else {
            Int( fitWidth)
        }
    }
    var suggestedHeight: Int {
        if imageAspectRatio <= viewAspectRatio {
            Int( fitHeight)
        } else {
            Int( fitWidth / imageAspectRatio )
        }
    }
    
    //        let imageAspectRatio = image.size.width / image.size.height
    //        let viewAspectRatio = imageView.frame.width / imageView.frame.height
    //
    //        var fitWidth:  CGFloat   // scaled width in points
    //        var fitHeight: CGFloat   // scaled height in points
    //        var offsetX:   CGFloat   // horizontal gap between image and frame
    //        var offsetY:   CGFloat   // vertical gap between image and frame
    //
    //        if imageAspectRatio <= viewAspectRatio {
    //            // Image is narrower than view so with aspectFit, it will touch
    //            // the top and bottom of the view, but not the sides
    //            fitHeight = imageView.frame.height
    //            fitWidth = fitHeight * imageAspectRatio
    //            offsetY = 0
    //            offsetX = (imageView.frame.width - fitWidth) / 2
    //        } else {
    //            // Image is wider than view so with aspectFit, it will touch
    //            // the sides of the view but not the top and bottom
    //            fitWidth = imageView.frame.width
    //            fitHeight = fitWidth / imageAspectRatio
    //            offsetX = 0
    //            offsetY = (imageView.frame.height - fitHeight) / 2
    //        }
    
    
    init(path: String, name: String) {
        self.name = name
        self.path = path
        
        let fullName = path+"/"+name
        let image = CIImage(contentsOf: URL(filePath: fullName))
        
        if let image {
            width = Int(image.extent.width)
            height = Int(image.extent.height)
            
            image.properties.forEach {
                
                if $0.key == "{GPS}" {
                    let gps: [String:Any] = $0.value as! [String:Any]
                    gps.forEach {
                        if $0.key == "Latitude" {
                            self.latitude = String(describing: $0.value)
                        }
                        if $0.key == "Longitude" {
                            self.longitude = String(describing: $0.value)
                        }
                        if $0.key == "LatitudeRef" {
                            self.latitudeRef = String(describing: $0.value)
                        }
                        if $0.key == "LongitudeRef" {
                            self.longitudeRef = String(describing: $0.value)
                        }
                    }
                }
            }
        } else {
            width = 100
            height = 100
        }
        
    }
    
    
}
