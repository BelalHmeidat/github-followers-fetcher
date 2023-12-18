import Foundation
import Alamofire
import UIKit


class FollowersAPI {
    static func downloadImage(url: URL, completion: @escaping (UIImage) -> ()){
        let destination = DownloadRequest.suggestedDownloadDestination(for: .cachesDirectory, options: .removePreviousFile)
        AF.download(
            url,
            to: destination).response(completionHandler: { response in
                do {
                    let imageData = try Data(contentsOf: response.fileURL!)
                    let image = UIImage(data: imageData)
                    completion(image!)
                } catch{
                    print("error loading asset")
                }
            })
    }
}

