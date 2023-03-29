//
//  NetworkWeatherManager.swift
//  3.02
//
//  Created by Айдар Оспанов on 20.03.2023.
//

import Foundation
import Alamofire

enum Link {
    case personeURL
    
    var url: URL {
        switch self {
        case .personeURL:
            return URL(string: "https://rickandmortyapi.com/api/character")!
        }
    }
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchPersona(from url: URL, completion: @escaping(Result<[Hero], AFError>) -> Void) {
        
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let heroes = Persona.getHeroes(from: value)
                    completion(.success(heroes))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchImage(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

