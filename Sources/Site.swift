import Foundation
import Ignite

@main
struct IgniteWebsite {
    static func main() async {
        let site = ExampleSite()

        do {
            try await site.publish(buildDirectoryPath: "docs")
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ExampleSite: Site {    
    var name = "Hello World, Phil"
    var titleSuffix = " - wigglesworth.us"
    var url:URL = URL("https://wigglesworth.us")
    var builtInIconsEnabled = true

    var author = "Phil Wigglesworth"

    var homePage = Home()
    var theme = MyTheme()
}


