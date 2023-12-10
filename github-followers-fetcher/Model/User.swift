//
//  User.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 10/30/23.
//


struct User{
    var id: Int
    var username: String?
    var name: String?
    var follows: Int?
    var bio: String?
    var avatarURL: String
    
    init(id: Int, name : String, follows: Int, bio : String, avatarURL: String){
        self.id = id
        self.name = name
        self.follows = follows
        self.avatarURL = avatarURL
        self.bio = bio
    }
    
    init(id: Int, username: String, avatarURL: String){
        self.id = id
        self.username = username
        self.avatarURL = avatarURL
    }
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
        id = try values.decode(Int.self, forKey: .id)
        username = try values.decode(String.self, forKey: .username)
        name = try values.decode(String.self, forKey: .name)
        follows = try values.decode(Int.self, forKey: .follows)
        bio = try values.decode(String.self, forKey: .bio)
        avatarURL = try values.decode(String.self, forKey: .avatarURL)
    }
}
