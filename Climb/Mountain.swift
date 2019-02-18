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

struct Mountain: Equatable, Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnailUrl: URL
    let imageUrl: URL
    let elevation: Double
    let latitude: Double
    let longitude: Double
    let prefectures: [String]
    let areaId: Int
    let likeCount: Int
    let isLike: String
    let activityCount: Int
    let viewCount: Int
    let difficultyLevel: DifficultyLevel
    let physicalLevel: PhysicalLevel

    static func == (lhs: Mountain, rhs: Mountain) -> Bool {
        return lhs.id == rhs.id
    }
}
