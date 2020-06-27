//
//  CharactersViewModel.swift
//  SkeletonMarvel
//
//  Created by Mathilde Ferrand on 15/06/2020.
//  Copyright © 2020 Mathilde Ferrand. All rights reserved.
//

import Foundation

typealias FetchCharactersCompletion = (Result<[Character], Error>) -> Void

protocol CharactersViewModelType {
    var characters: [Character] { get }
    func fetchCharacters(completion: @escaping FetchCharactersCompletion)
    func setupPlaceholders() -> [Character]
}

final class CharactersViewModel: CharactersViewModelType {
    
    let dataController: CharactersDataControllerType
    var characters: [Character]
    
    init(dataController: CharactersDataControllerType) {
        self.dataController = dataController
        self.characters = []
    }
    
    func setupPlaceholders() -> [Character] {
        for _ in 0..<99 {
            characters.append(Character(identifier: UUID(), id: 1, name: "test", description: "", thumbnail: .init(path: "", thumbnailExtension: .jpg), resourceURI: "", urls: [.init(type: .comiclink, url: "")]))
        }
        return characters
    }
    
    func fetchCharacters(completion: @escaping FetchCharactersCompletion) {
        dataController.fetchList { result in
            switch result {
            case .success(let model):
                self.characters.removeAll()
                self.characters = model.data.results
                completion(.success(model.data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
