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
    var photos: [Photo] = []
    var links: [Photo] {
        var links: [Photo] = []
        var previousSplit: [String] = []
        for photo in photos {
            // split the path into elements
            var split = photo.split
            // remove the file name
            split.removeLast()
            // ignore the top level images
            if split.count >= 1 {
                if previousSplit != split {
                    links.append(photo)
                }
            }
            previousSplit = split
        }
        return links
    }

    struct SavedLink {
        var title: String
        var destination: any StaticPage
    }

    func body(context: PublishingContext) -> [BlockElement] {
        var showing: [String] = []
        var buttons: [SavedLink] = []
        
        for photo in links {
            var splitVar: [String] {
                var split = photo.split
                split.removeLast()
                
                var ignore = 0
                for i in 0 ..< min(showing.count,split.count) {
                    if showing[i] == split[i] {
                        ignore += 1
                    }
                }
                if ignore > 0 {
                    split.removeFirst(ignore)
                }
                if showing.count > ignore {
                    showing.removeLast(showing.count - ignore)
                }
                if split.count > showing.count {
                    for i in 0 ..< split.count - 1 {
                        showing.append(split[i])
                    }
                }
                return split
            }
            // force the splitVar to be executed here
            let split = splitVar
            
            if split.count > 1 {
                Section {
                    for button in buttons {
                        Text {
                            Link(button.title, target: button.destination)
                                .linkStyle(.button)
                                .buttonSize(.small)
                        }
                        .horizontalAlignment(.leading)
                    }
                    if buttons.count < 8 {
                        for _ in buttons.count ..< 8 {
                            Text("")
                        }
                    }
                }

                var _: Bool = { buttons = []; return false }()
                for i in 0 ..< split.count - 1 {
                    if showing.count > 0, showing[0] == split[i] {
                        Text(split[i])
                            .font(.title2)
                            .margin(0)
                    } else {
                        Text(split[i])
                            .font(.title4)
                            .margin(0)
                    }
                }
            }
            
            if let last = split.last {
                var _: Bool = {
                    buttons.append( SavedLink(title: last, destination: photo))
                    return false
                }()
            }
        }
        Section {
            for button in buttons {
                Text {
                    Link(button.title, target: button.destination)
                        .linkStyle(.button)
                        .buttonSize(.small)
                }
                .horizontalAlignment(.leading)
            }
        }
    }
}

