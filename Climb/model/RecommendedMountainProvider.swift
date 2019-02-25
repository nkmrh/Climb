//
//  RecommendedMountainProvider.swift
//  Climb
//
//  Created by Hajime Nakamura on 2019/02/24.
//  Copyright © 2019 Hajime Nakamura. All rights reserved.
//

import CoreLocation
import Foundation

struct RecommendedMountainProvider {
    static func makeRecommendedMountains(for mountain: Mountain, from mountains: [Mountain]) -> [Mountain] {
        let mLocation = CLLocation(latitude: mountain.latitude, longitude: mountain.longitude)
        return mountains
            .filter { $0.id != mountain.id && !$0.isLike }
            .sorted { m1, m2 -> Bool in
                let m1Location = CLLocation(latitude: m1.latitude, longitude: m1.longitude)
                let m2Location = CLLocation(latitude: m2.latitude, longitude: m2.longitude)
                let distance1 = m1Location.distance(from: mLocation)
                let distance2 = m2Location.distance(from: mLocation)
                return distance1 < distance2
            }
    }
}
