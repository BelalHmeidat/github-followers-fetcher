//
//  NetworkRouter.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 12/20/23.
//

import Foundation

    
enum Endpoints {
    case getUser(user: String = "")
    case getFollowerList(user: String = "")
    
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
    
    var url: URL? {
        var comps = URLComponents()
        comps.scheme = "https"
        comps.host = "api.github.com"
        comps.path = self.path
        return comps.url
    }
    
    private var httpMethod: String {
        switch self {
        case .getUser, .getFollowerList:
            return "GET"
        }
    }
    
//    var request: URLRequest? {
//        guard let url = self.url else { return nil }
//        print(url)
//        var request = URLRequest(url: url)
//        request.httpMethod = self.httpMethod
//        return request
//    }
}
