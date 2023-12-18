//
//  User.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 10/30/23.
//


struct User{
    var id: Int
    var username: String
    var name: String?
    var follows: Int?
    var bio: String?
    var avatarURL: String
    
//    init(id: Int, name: String?, follows: Int?, bio: String, avatarURL: String, username: String){
//        self.id = id
//        self.name = name ?? ""
//        self.follows = follows ?? 0
//        self.avatarURL = avatarURL
//        self.bio = bio
//        self.username = username
//    }
    
//    init(id: Int, username: String, avatarURL: String){
//        self.id = id
//        self.username = username
//        self.avatarURL = avatarURL
//    }
}

extension User: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case username = "login"
        case name
        case follows = "followers"
        case bio
        case avatarURL = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(Int.self, forKey: .id)
        self.username = try values.decode(String.self, forKey: .username)
        self.name = try values.decodeIfPresent(String?.self, forKey: .name) ?? ""
        self.follows = try values.decodeIfPresent(Int?.self, forKey: .follows) ?? 0
        self.bio = try values.decodeIfPresent(String?.self, forKey: .bio) ?? ""
        self.avatarURL = try values.decode(String.self, forKey: .avatarURL)
    }
}
