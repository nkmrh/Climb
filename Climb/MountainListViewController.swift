//
//  ViewController.swift
//  Climb
//
//  Created by Hajime Nakamura on 2019/02/18.
//  Copyright © 2019 Hajime Nakamura. All rights reserved.
//

import UIKit

class MountainListViewController: UIViewController {
    private let MountainsURL = "https://s3-ap-northeast-1.amazonaws.com/file.yamap.co.jp/ios/mountains.json"
    private var mountains: [Mountain] = []

    @IBOutlet weak var tableView: UITableView!

    private func fetchMountains(completion: @escaping ([Mountain]?, Error?) -> Void) {
//        let url = URL(string: MountainsURL)!
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data, let response = response {
//                print(response)
//                print(data)
//                do {
//                    let mountains = try JSONDecoder().decode([Mountain].self, from: data)
//                    completion(mountains, nil)
//                } catch {
//                    completion(nil, error)
//                }
//            } else {
//                completion(nil, error)
//            }
//        }
//        task.resume()


        if let filepath = Bundle.main.path(forResource: "response", ofType: "json") {
            let contents = try! String(contentsOfFile: filepath)
            let mountains = try! JSONDecoder().decode([Mountain].self, from: contents.data(using: .utf8)!)
            completion(mountains, nil)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchMountains { [weak self] mountains, error in
            if let mountains = mountains {
                self?.mountains = mountains
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension MountainListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mountains.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MountainCell", for: indexPath) as! MountainCell
        let mountain = mountains[indexPath.row]
        cell.configure(with: mountain)
        return cell
    }
}

extension MountainListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = MountainDetailViewController.makeInstance(mountain: mountains[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
    }
}
