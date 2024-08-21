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
    var split: [String] { imageInfo.name.components(separatedBy:  "/") }
    var headline: String {
        var name = split.last ?? ""
        if name.hasSuffix(".jpeg") {
            name = String(name.prefix( name.count - 5 ))
        }
        if name.count > 24 {
            let parts = name.split(separator: "-")
            if parts.count > 4,
               parts[0].count == 8,
               parts[1].count == 4,
               parts[2].count == 4,
               parts[3].count == 4 {
                name = "<Uncategorized>"
            }
        }
        if name.contains("-") {
            let parts = name.split(separator: "-")
            name = String(parts.first!)
        }
        return name
    }
    
    init(imageInfo: ImageInfo, previous: (any StaticPage)? = nil) {
        self.imageInfo = imageInfo
        self.previous = previous
    }
    
    
    func body(context: PublishingContext) -> [BlockElement] {
        
        if split.count > 0 {
            Text(split[0])
                .font(.title1)
                .margin(0)
        }
        if split.count == 4 {
            Text( "\(split[1]): \(split[2])" )
                .font(.title2)
        } else if split.count == 3 {
            Text( "\(split[1])" )
                .font(.title2)
        } else {
            for s in split {
                Text(s)
                    .font(.title2)
            }
        }
        Section {
            if let previous {
                Text{
                    Link("Previous", target: previous)
                        .linkStyle(.button)
                }
            } else {
                Text("")
            }
            
            Text(headline)
                .horizontalAlignment(.center)
            
            if let next {
                Text{
                    Link("Next", target: next)
                        .linkStyle(.button)
                }
                .horizontalAlignment(.trailing)
                
            } else { Text("") }
        }
        Section {
            if imageInfo.name.hasSuffix(".mp4") {
                Video(imageInfo.webPath)
                    .addCustomAttribute(name: "autoplay", value: "true")
                    .frame(maxWidth: imageInfo.suggestedWidth, maxHeight: imageInfo.suggestedHeight)
            } else {
                Image(decorative: imageInfo.webPath)
                    .resizable()
                    .frame(maxWidth: imageInfo.suggestedWidth, maxHeight: imageInfo.suggestedHeight)
            }
        }
        .horizontalAlignment(.center)
        
        Section {
            Text(imageInfo.location)
                .horizontalAlignment(.leading)
                .width(2)
            Text(imageInfo.name)
                .horizontalAlignment(.trailing)
            
        }
        
        //        Section {
        //            for s in split {
        //                Text(s)
        //            }
        //        }
    }
}
