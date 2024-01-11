//
//  NetworkRouter.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 12/20/23.
//

import Foundation
import Alamofire

    
enum FollowersRouter: URLRequestConvertible {
    case getUser(user: String = "")
    case getFollowerList(user: String = "")
    
    static private var baseURL = "https://api.github.com"
    
    private var path: String {
        switch self {
        case .getUser(let user): return "/users/\(user)"
        case .getFollowerList(let user): return "/users/\(user)/followers"
        }
    }
    
    private var queryItems: [URLQueryItem] {
           switch self {
               default: return []
           }
       }
    
//    var baseURL: URL {
//        return URL(string: "https://api.github.com")
//    }
    
    private var httpMethod: String {
        switch self {
        case .getUser, .getFollowerList:
            return "GET"
        }
    }
    
    func asURLRequest() throws ->  URLRequest {
        let url = try URL(string: FollowersRouter.baseURL.asURL().appendingPathComponent(path).absoluteString.removingPercentEncoding!)
        var request = URLRequest.init(url: url!)
        request.httpMethod = httpMethod
//        request.timeoutInterval = TimeInterval(10*1000)
        return try URLEncoding.default.encode(request, with: nil)
    }
}
