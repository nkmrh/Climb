//
//  Mountain.swift
//  Climb
//
//  Created by Hajime Nakamura on 2019/02/18.
//  Copyright © 2019 Hajime Nakamura. All rights reserved.
//

import Foundation

enum DifficultyLevel: Int, Codable {
    case low = 1, middle, high
}

enum PhysicalLevel: Int, Codable {
    case low = 1, middle, high
}

struct Mountain: Equatable, Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnailURL: URL
    let imageURL: URL
    let elevation: Double
    let latitude: Double
    let longitude: Double
    let prefectures: [String]
    let areaId: Int
    let likeCount: Int
    let isLike: Bool
    let activityCount: Int
    let viewCount: Int
    let difficultyLevel: DifficultyLevel
    let physicalLevel: PhysicalLevel

    static func == (lhs: Mountain, rhs: Mountain) -> Bool {
        return lhs.id == rhs.id
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnailURL = "thumbnail_url"
        case imageURL = "image_url"
        case elevation
        case latitude
        case longitude
        case prefectures
        case areaId = "area_id"
        case likeCount = "like_count"
        case isLike = "is_like"
        case activityCount = "activity_count"
        case viewCount = "view_count"
        case difficultyLevel = "difficulty_level"
        case physicalLevel = "physical_level"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        thumbnailURL = try values.decode(URL.self, forKey: .thumbnailURL)
        imageURL = try values.decode(URL.self, forKey: .imageURL)
        elevation = try values.decode(Double.self, forKey: .elevation)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
        prefectures = try values.decode([String].self, forKey: .prefectures)
        areaId = try values.decode(Int.self, forKey: .areaId)
        likeCount = try values.decode(Int.self, forKey: .likeCount)
        isLike = try Bool(values.decode(String.self, forKey: .isLike)) ?? false
        activityCount = try values.decode(Int.self, forKey: .activityCount)
        viewCount = try values.decode(Int.self, forKey: .viewCount)
        difficultyLevel = try values.decode(DifficultyLevel.self, forKey: .difficultyLevel)
        physicalLevel = try values.decode(PhysicalLevel.self, forKey: .physicalLevel)
    }
}
