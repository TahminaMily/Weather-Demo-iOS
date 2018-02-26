//
//  Webservice.swift
//  Weather
//
//  Created by Tahmina Khanam on 26/2/18.
//

import Foundation

final class Webservice {
    let session: URLSession
    init(_ session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    enum Error: Swift.Error {
        case networkError
        case jsonDecodingError
    }

    typealias LoadCompletionType<Model> = (Result<Model, Webservice.Error>) -> Void

    func load<Model: Decodable>(url: URL, completion: @escaping LoadCompletionType<Model> ) {
        session.dataTask(with: url) { (data, _, error) in
            if error != nil {
                return completion(.failure(.networkError))
            }
            guard
                let data = data,
                let model = try? JSONDecoder().decode(Model.self, from: data)
            else { return completion(.failure(.jsonDecodingError)) }
            
            completion(.success(model))
        }.resume()
    }
}
