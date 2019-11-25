//
//  RepositoryModel.swift
//  iOSDesignPatterns
//
//  Created by 阿部竜大 on 2019/11/22.
//  Copyright © 2019 阿部竜大. All rights reserved.
//

import Foundation

struct RepositoriesList: Decodable {
    let repositories: [Repository]
    
    private enum CodingKeys: String, CodingKey {
        case repositories = "items"
    }
}

struct Repository: Decodable {
    let name: String
    let description: String
    let url: URL
    let language: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "full_name"
        case description
        case url = "html_url"
        case language
    }
}


protocol RepositoryModelDelegate: class {
    func repositoryModel(_ repositoryModel: RepositoryModel, didChange repositories: [Repository])
}

class RepositoryModel {
    
    let BASE_URL = "https://api.github.com/search/repositories?q="
    
    weak var delegate: RepositoryModelDelegate?
    
    private(set) var repositories: [Repository] = [] {
        didSet {
            delegate?.repositoryModel(self, didChange: repositories)
        }
    }
    
    func fetchRepositories(_ query: String) {
//        let url = URL(string: BASE_URL + query)!
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else { return }
//            if let error = error {
//                print("error: \(error.localizedDescription)")
//                return
//            }
//
//            do {
//                let repositoriesList = try JSONDecoder().decode(RepositoriesList.self, from: data)
//                self.repositories = repositoriesList.repositories
//            } catch let err {
//                print("decode error: \(err.localizedDescription)")
//                return
//            }
//
//        }
//        task.resume()
        
        var repositories: [Repository] = []
        for i in 0..<10 {
            let repository = Repository(
                name: "repo_\(i)",
                description: "description_\(i)",
                url: URL(string: "https://github.com/TatsuhiroAbe")!,
                language: "swift"
            )
            repositories.append(repository)
        }
        self.repositories = repositories
    }
}
