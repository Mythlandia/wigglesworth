//
//  IgnitePage.swift
//  IgniteStarter
//
//  Created by Phil Wigglesworth on 8/15/24.
//

import Foundation
import Ignite

struct IgnitePage: StaticPage {
    var title: String = "IgnitePage"

    func body(context: PublishingContext) -> [BlockElement] {
        Text(/*@START_MENU_TOKEN@*/"Welcome to my World!"/*@END_MENU_TOKEN@*/)
    }
}
