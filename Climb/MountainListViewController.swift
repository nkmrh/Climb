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

    @IBOutlet private var tableView: UITableView!

    private func updateMountains(with mountain: Mountain) {
        guard let index = mountains.firstIndex(of: mountain) else { return }
        mountains[index] = mountain
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

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

        fetchMountains { [weak self] mountains, _ in
            if let mountains = mountains {
                self?.mountains = mountains
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension MountainListViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
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
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mountain = mountains[indexPath.row]
        let recommendedMountains = RecommendedMountainProvider.makeRecommendedMountains(for: mountain, from: mountains)
        let viewController = MountainDetailViewController.makeInstance(mountain: mountain,
                                                                       recommendedMountains: recommendedMountains)
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MountainListViewController: MountainDetailViewControllerDelegate {
    func mountainDetailViewControllerDidUpdate(_ mountain: Mountain) {
        updateMountains(with: mountain)
    }
}
