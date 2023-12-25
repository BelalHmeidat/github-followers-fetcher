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
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        follows = try values.decodeIfPresent(Int.self, forKey: .follows) ?? 0
        bio = try values.decodeIfPresent(String.self, forKey: .bio) ?? ""
        avatarURL = try values.decode(String.self, forKey: .avatarURL)
    }
}
