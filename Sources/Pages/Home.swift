import Foundation
import Ignite

struct Home: StaticPage {
    var title = "Welcome"
    let imageName: String = "/images/Phil Wigglesworth.jpg"
    
    func body(context: PublishingContext) -> [BlockElement] {
        Section {
           Image(decorative: imageName)
                    .resizable()
                    .width(3)

            Text( """
Welcome to the personal website of Phil Wigglesworth giving a little bit of background to me and my life. Originally a lot of this content was added to Facebook over the years, particular the photos, but over time Facebook has taken too much control over their presentation and I rarely post there.
""")
        }
    }
    
}
