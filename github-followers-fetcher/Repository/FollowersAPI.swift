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
        NetworkingManager.shared.excuteRequest(routerCase: FollowersRouter.getUser(user: username)) {
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
        NetworkingManager.shared.excuteRequest(routerCase: FollowersRouter.getFollowerList(user: username)) {
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

