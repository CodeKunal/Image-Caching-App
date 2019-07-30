//
//  UserModel.swift
//  Bounce
//
//  Created by Kunal on 30/07/19.
//  Copyright © 2019 Kunal. All rights reserved.
//

import Foundation

struct User {
    
    static func endpointForUsers() -> String {
        return "https://api.github.com/users?since=135"
    }
    var id: Int
    var name: String
    var followersUrl: String
    var avatarUrl: String
    
//    init(_ dictionary: [String: Any]) {
//        self.id = dictionary["id"] as? Int ?? 0
//        self.name = dictionary["login"] as? String ?? ""
//        self.followersUrl = dictionary["followers_url"] as? String ?? ""
//        self.avatarUrl = dictionary["avatar_url"] as? String ?? ""
//    }
}

enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "login"
    case followersUrl = "followers_url"
    case avatarUrl = "avatar_url"
}

extension User: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        followersUrl = try container.decode(String.self, forKey: .followersUrl)
        avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(followersUrl, forKey: .followersUrl)
        try container.encode(avatarUrl, forKey: .avatarUrl)
    }

}

