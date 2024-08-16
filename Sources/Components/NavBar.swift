//
//  NavBar.swift
//  IgniteStarter
//
//  Created by Phil Wigglesworth on 8/10/24.
//


import Foundation
import Ignite

/// An example navigation bar, demonstrating how to create reusable components.
struct NavBar: Component {
    func body(context: PublishingContext) -> [any PageElement] {
        
        NavigationBar(
            logo: Text("Phil Wigglesworth")
                .font(.title1)
                .foregroundStyle(Color.darkBlue)
                .padding()
        ) {
            Dropdown("Quick Links") {
                Link("Family", target: Family() )
                Link("Background", target: Background() )
            }
        }
        .navigationItemAlignment(.trailing)
        .background(Color.lightBlue)
        .position(.fixedTop)
        .navigationItemAlignment(.trailing)
        
        Spacer(size: 100)
    }
}
