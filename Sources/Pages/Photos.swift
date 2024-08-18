//
//  Photos.swift
//  IgniteStarter
//
//  Created by Phil Wigglesworth on 8/17/24.
//

import Foundation
import Ignite

struct Photos: StaticPage {
    var title: String = "Photos"
    var images: [ImageInfo] = []
    
    func body(context: PublishingContext) -> [BlockElement] {
        for image in images {
            Text{
                Link(image.name, target: Photo(imageInfo: image) )
            }
        }
    }
}
