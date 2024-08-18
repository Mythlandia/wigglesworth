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
    var name = "Phil Wigglesworth"
    var titleSuffix = " - wigglesworth.us"
    var url:URL = URL("https://wigglesworth.us")
    var builtInIconsEnabled = true
    
    var author = "Phil Wigglesworth"
    
    var homePage = Home()
    var theme = MyTheme()
    
    var images: [ImageInfo] = ExampleSite.loadImageInfo()
    
    var pages: [any StaticPage] {
        Home()
        Family()
        Background()
        Photos(images: images)
        for image in images {
            Photo(imageInfo: image)
        }
//        Photo(imageInfo: images[1])
    }
    
    static func loadImageInfo() -> [ImageInfo] {
        var imagesPath: String {
            "/" +
            #filePath
                .split(separator: "/")
                .dropLast(2)
                .joined(separator: "/")
            + "/Assets"
        }
        let subPath = imagesPath + "/images"
        
        var images: [ImageInfo] = []
        
//        do {
//            let fileManager = FileManager.default
//            let contents = try fileManager.contentsOfDirectory(atPath: subPath)
//            for file in contents {
//                if file.hasSuffix(".jpeg") {
//                    images.append(ImageInfo(path: subPath, name: file))
//                }
//            }
//        } catch {
//            print("Error: \(error.localizedDescription)")
//        }
        
//        print()
//        print("Deep dive files from \(subPath)")
//        print()
        let docsDir = subPath
        let localFileManager = FileManager.default
        
        let dirEnum = localFileManager.enumerator(atPath: docsDir)
        
        while let file = dirEnum?.nextObject() as? String {
            if file.hasSuffix(".jpeg") {
//                print(docsDir.appending("/\(file)"))
                images.append(ImageInfo(path: docsDir, name: file))
            }
        }

  
        return images
//        return [
//            ImageInfo(imageName: "/images/Disney World 2024/Epcot/Frozen/0B091324-DBB6-4C17-AC34-DCD0845CAA1D_1_105_c.jpeg")
//        ]
    }
}


