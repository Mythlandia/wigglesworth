import Foundation
import Ignite

struct Home: StaticPage {
    var title = "Welcome"

    func body(context: PublishingContext) -> [BlockElement] {
        Text("Phil Wigglesworth")
            .font(.title1)
    }
}
