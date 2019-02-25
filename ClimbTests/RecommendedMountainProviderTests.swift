//
//  RecommendedMountainProviderTests.swift
//  ClimbTests
//
//  Created by Hajime Nakamura on 2019/02/24.
//  Copyright © 2019 Hajime Nakamura. All rights reserved.
//

@testable import Climb
import XCTest

class RecommendedMountainProviderTests: XCTestCase {
    func testMakeRecommendedMountainsNotIncludeTargetMountain() {
        let targetMountain = Mountain(id: 0,
                                      name: "",
                                      description: "",
                                      thumbnailURL: URL(string: "https://")!,
                                      imageURL: URL(string: "https://")!,
                                      elevation: 0,
                                      latitude: 0,
                                      longitude: 0,
                                      prefectures: [],
                                      areaId: 0,
                                      likeCount: 0,
                                      isLike: false,
                                      activityCount: 0,
                                      viewCount: 0,
                                      difficultyLevel: .low,
                                      physicalLevel: .low)
        let mountain1 = Mountain(id: 1,
                                 name: "",
                                 description: "",
                                 thumbnailURL: URL(string: "https://")!,
                                 imageURL: URL(string: "https://")!,
                                 elevation: 0,
                                 latitude: 0,
                                 longitude: 0,
                                 prefectures: [],
                                 areaId: 0,
                                 likeCount: 0,
                                 isLike: false,
                                 activityCount: 0,
                                 viewCount: 0,
                                 difficultyLevel: .low,
                                 physicalLevel: .low)
        let mountains = [targetMountain, mountain1]
        let subject = RecommendedMountainProvider.makeRecommendedMountains(for: targetMountain, from: mountains)
        XCTAssertFalse(subject.contains(targetMountain))
        XCTAssertTrue(subject.count == 1)
    }

    func testMakeRecommendedMountainsNotIncludeLikedMountain() {
        let targetMountain = Mountain(id: 0,
                                      name: "",
                                      description: "",
                                      thumbnailURL: URL(string: "https://")!,
                                      imageURL: URL(string: "https://")!,
                                      elevation: 0,
                                      latitude: 0,
                                      longitude: 0,
                                      prefectures: [],
                                      areaId: 0,
                                      likeCount: 0,
                                      isLike: false,
                                      activityCount: 0,
                                      viewCount: 0,
                                      difficultyLevel: .low,
                                      physicalLevel: .low)
        let mountain1 = Mountain(id: 1,
                                 name: "",
                                 description: "",
                                 thumbnailURL: URL(string: "https://")!,
                                 imageURL: URL(string: "https://")!,
                                 elevation: 0,
                                 latitude: 0,
                                 longitude: 0,
                                 prefectures: [],
                                 areaId: 0,
                                 likeCount: 0,
                                 isLike: true,
                                 activityCount: 0,
                                 viewCount: 0,
                                 difficultyLevel: .low,
                                 physicalLevel: .low)
        let mountains = [targetMountain, mountain1]
        let subject = RecommendedMountainProvider.makeRecommendedMountains(for: targetMountain, from: mountains)
        XCTAssertTrue(subject.count == 0)
    }

    func testMakeRecommendedMountainsSortedByNearLocations() {
        let targetMountain = Mountain(id: 0,
                                      name: "",
                                      description: "",
                                      thumbnailURL: URL(string: "https://")!,
                                      imageURL: URL(string: "https://")!,
                                      elevation: 0,
                                      latitude: 0,
                                      longitude: 0,
                                      prefectures: [],
                                      areaId: 0,
                                      likeCount: 0,
                                      isLike: false,
                                      activityCount: 0,
                                      viewCount: 0,
                                      difficultyLevel: .low,
                                      physicalLevel: .low)
        let mountain1 = Mountain(id: 1,
                                 name: "",
                                 description: "",
                                 thumbnailURL: URL(string: "https://")!,
                                 imageURL: URL(string: "https://")!,
                                 elevation: 0,
                                 latitude: 1,
                                 longitude: 1,
                                 prefectures: [],
                                 areaId: 0,
                                 likeCount: 0,
                                 isLike: false,
                                 activityCount: 0,
                                 viewCount: 0,
                                 difficultyLevel: .low,
                                 physicalLevel: .low)
        let mountain2 = Mountain(id: 2,
                                 name: "",
                                 description: "",
                                 thumbnailURL: URL(string: "https://")!,
                                 imageURL: URL(string: "https://")!,
                                 elevation: 0,
                                 latitude: 0,
                                 longitude: 0,
                                 prefectures: [],
                                 areaId: 0,
                                 likeCount: 0,
                                 isLike: false,
                                 activityCount: 0,
                                 viewCount: 0,
                                 difficultyLevel: .low,
                                 physicalLevel: .low)
        let mountains = [targetMountain, mountain1, mountain2]
        let subject = RecommendedMountainProvider.makeRecommendedMountains(for: targetMountain, from: mountains)
        XCTAssertEqual(subject, [mountain2, mountain1])
        XCTAssertTrue(subject.count == 2)
    }
}
