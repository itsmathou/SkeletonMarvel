//
//  CharactersDataController.swift
//  SkeletonMarvel
//
//  Created by Mathilde Ferrand on 15/06/2020.
//  Copyright © 2020 Mathilde Ferrand. All rights reserved.
//

import Foundation

typealias CharactersListCompletion = (Result<CharactersResponseModel, Error>) -> Void

enum FetchListErrors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

protocol CharactersDataControllerType {
    func fetchList(completion: @escaping CharactersListCompletion)
}

final class CharactersDataController: CharactersDataControllerType {
    
    func fetchList(completion: @escaping CharactersListCompletion) {
        let urlString: String = "https://gateway.marvel.com/v1/public/characters?ts=1&apikey=\(APIKey.marvelKey)&limit=10&orderBy=name"
        
        guard let url = URL(string: urlString) else {
            completion(Result.failure(FetchListErrors.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession(configuration: .default).dataTask(with: request) { data, response, error in
            if let error = error {
                // TODO: retrieve from persistence
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(FetchListErrors.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(FetchListErrors.invalidData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let model = try jsonDecoder.decode(CharactersResponseModel.self, from: data)
                // TODO: persiste data
                DispatchQueue.main.async {
                    completion(.success(model))
                }
            } catch {
                print("error:", error)
            }
        }.resume()
    }
}
