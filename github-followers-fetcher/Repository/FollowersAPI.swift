import Foundation
import Alamofire


class FollowersAPI {
    
    static func getUserAvatarData(imageURL: String, completion: @escaping (_ imageData: Data?, _ errorMessage: String?) -> ()) {
        NetworkingManager.shared.getImage(url: imageURL) { data, error  in
                guard let data = data, error == nil else {
                    completion(nil, error)
                    return
                }
                completion(data, nil)
            }
        }
    
    static func fetchUserProfile(username: String, completion: @escaping (User?, String?)->()){
        let url = Endpoints.getUser(user: username).url!
        NetworkingManager.shared.excuteRequest(url: url, type: "User") {
            (response: User?, errorMessage) in
            if let errorMessage = errorMessage {
                completion(nil, errorMessage)
            }
            else {
                if let user = response {
                        completion(user, nil)
                } else {
                    completion(nil, "invalid response")
                    return
                }
            }
        }
    }
    
    static func fetchFollower(username: String, completion: @escaping ([User]?, String?)->()){
        let url = Endpoints.getFollowerList(user: username).url!
        NetworkingManager.shared.excuteRequest(url: url, type: "Follower") {
            (response: [User]?, error) in
            if let errorMessage = error {
                completion(nil, errorMessage)
            }
            else {
                guard let followersList = response else {
                    completion(nil, "invalid response")
                    return
                }
                completion(followersList, nil)
            }
        }
    }
}

