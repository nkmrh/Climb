//
//  ViewController.swift
//  Climb
//
//  Created by Hajime Nakamura on 2019/02/18.
//  Copyright © 2019 Hajime Nakamura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let MountainsURL = "https://s3-ap-northeast-1.amazonaws.com/file.yamap.co.jp/ios/mountains.json"

    private func fetchMountains(completion: @escaping ([Mountain]?, Error?) -> Void) {
        let url = URL(string: MountainsURL)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let response = response {
                print(response)
                print(data)
                do {
                    let mountains = try JSONDecoder().decode([Mountain].self, from: data)
                    completion(mountains, nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchMountains { mountains, error in
            debugPrint(mountains, error)
        }
    }
}
