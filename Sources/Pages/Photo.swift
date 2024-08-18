//
//  Photo.swift
//  IgniteStarter
//
//  Created by Phil Wigglesworth on 8/17/24.
//

import Foundation
import Ignite

struct Photo: StaticPage {
    var title: String { imageInfo.name.replacingOccurrences(of: "/", with: "-") }
    var imageInfo: ImageInfo
    var path: String { "/photo/\(title)" }
    
    init(imageInfo: ImageInfo) {
        self.imageInfo = imageInfo
        print("Creating photo page for \(title)")
    }
    
    func body(context: PublishingContext) -> [BlockElement] {
        Card {
            Text(title)
            Image(decorative: imageInfo.webPath)
                .resizable()
                .frame(width: imageInfo.suggestedWidth, height: imageInfo.suggestedHeight)
            Text(imageInfo.name)
        }
    }
}
