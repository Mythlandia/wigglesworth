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
    var next: (any StaticPage)?
    var previous: (any StaticPage)?
    
    init(imageInfo: ImageInfo, previous: (any StaticPage)? = nil) {
        self.imageInfo = imageInfo
        self.previous = previous
    }
    
    
    func body(context: PublishingContext) -> [BlockElement] {
        Text(title)
        Section {
            if let previous {
                Text{
                    Link("Previous", target: previous)
                        .linkStyle(.button)
                }
            } else {
                Text("")
            }

            if let next {
                Text{
                    Link("Next", target: next)
                        .linkStyle(.button)
                }
                .horizontalAlignment(.trailing)
                
            }
        }
        Section {
            Image(decorative: imageInfo.webPath)
                .resizable()
                .frame(width: imageInfo.suggestedWidth, height: imageInfo.suggestedHeight)
        }
        .horizontalAlignment(.center)

        Text(imageInfo.name)
    }
}
