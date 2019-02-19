//
//  MountainTests.swift
//  ClimbTests
//
//  Created by Hajime Nakamura on 2019/02/19.
//  Copyright © 2019 Hajime Nakamura. All rights reserved.
//

@testable import Climb
import Foundation
import XCTest

class MountainTests: XCTestCase {
    func testDecode() {
        let json = """
        {
            "view_count": 875,
            "area_id": 1,
            "elevation": 196.2,
            "description": "test",
            "difficulty_level": 1,
            "activity_count": 157,
            "physical_level": 2,
            "prefectures": ["test"],
            "like_count": 175,
            "is_like": "false",
            "longitude": 130.551485,
            "thumbnail_url": "https://test",
            "image_url": "https://test",
            "latitude": 33.5596366666667,
            "id": 1,
            "name": "test"
        }
        """
        let subject = try! JSONDecoder().decode(Mountain.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(subject.viewCount, 875)
        XCTAssertEqual(subject.areaId, 1)
        XCTAssertEqual(subject.elevation, 196.2)
        XCTAssertEqual(subject.description, "test")
        XCTAssertEqual(subject.difficultyLevel, .low)
        XCTAssertEqual(subject.activityCount, 157)
        XCTAssertEqual(subject.physicalLevel, .middle)
        XCTAssertEqual(subject.prefectures, ["test"])
        XCTAssertEqual(subject.likeCount, 175)
        XCTAssertFalse(subject.isLike)
        XCTAssertEqual(subject.longitude, 130.551485)
        XCTAssertEqual(subject.thumbnailURL, URL(string: "https://test")!)
        XCTAssertEqual(subject.imageURL, URL(string: "https://test")!)
        XCTAssertEqual(subject.latitude, 33.5596366666667)
        XCTAssertEqual(subject.id, 1)
        XCTAssertEqual(subject.name, "test")
    }
}
