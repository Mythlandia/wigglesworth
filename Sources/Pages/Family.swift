//
//  Family.swift
//  IgniteStarter
//
//  Created by Phil Wigglesworth on 8/15/24.
//

import Foundation
import Ignite

struct Family: StaticPage {
    var title: String = "Family"
    
    func body(context: PublishingContext) -> [BlockElement] {
        Text("Family rules..")
    }
}
