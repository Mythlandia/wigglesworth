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
    
    var photoPages: [Photo] {
        // Creates a linked list of Photo() pages from images
        var pages: [Photo] = []
        var previous: Photo?
        for image in images {
            // already know the previous Photo(), if any, so create with that preset
            let photo = Photo(imageInfo: image, previous: previous)
            // only just know what the next photo for the previous photo will be (this one), so update it
            previous?.next = photo
            // the first time through the loop there will be no previous photo to save
            if let previous {
                // only append once updated with both previous and next values
                pages.append( previous )
            }
            // get ready for the next iteration
            previous = photo
        }
        // there will be one Photo() that has yet to be saved at the end of the loop
        if let previous {
            // save the final Photo()
            pages.append( previous )
        }
        return pages
    }

    var pages: [any StaticPage] {
        Home()
        Family()
        Background()
        Photos(photos: photoPages)
        
        for page in photoPages {
            page
        }
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


