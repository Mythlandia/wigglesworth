//
//  Background.swift
//  IgniteStarter
//
//  Created by Phil Wigglesworth on 8/15/24.
//

import Foundation
import Ignite

struct Background: StaticPage {
    var title: String = "Background"

    func body(context: PublishingContext) -> [BlockElement] {
        Text(/*@START_MENU_TOKEN@*/"Welcome to my World!"/*@END_MENU_TOKEN@*/)
    }
}
