//
//  RedditService.swift
//  Reddit
//
//  Created by Juan Ortiz on 20/04/2019.
//  Copyright © 2019 Juan Ortiz. All rights reserved.
//

import Foundation

class RedditService: RedditServiceProtocol {
    private static let stringUrl = "https://reddit.com/top.json"
    
    func fetchEntries(limit: Int?, lastEntryId: String?, completion: @escaping (RedditNetworkResult) -> Void) {
        guard var components = URLComponents(string: RedditService.stringUrl),
            let url = components.url else {
                completion(.failure(with: .notFound))
                return
        }
        
        components.queryItems = []
        
        if let limit = limit {
            components.queryItems?.append(URLQueryItem(name: "limit", value: String(describing: limit)))
        }
        
        if let lastEntryId = lastEntryId {
            components.queryItems?.append(URLQueryItem(name: "after", value: "t3_\(lastEntryId)"))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(with: .defaultError))
                return
            }
            
            if let error = error {
                completion(.failure(with: .serverError(error: error)))
            } else if let data = data, response.statusCode == 200 {
                do {
                    let entries = try self.decodeResponse(data: data)
                    completion(.success(entries: entries))
                } catch {
                    completion(.failure(with: .parserError))
                }
            } else {
                completion(.failure(with: .defaultError))
            }
            }.resume()
    }
}

extension RedditService {
    fileprivate func decodeResponse(data: Data) throws -> [RedditEntryDto]{
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let response = try decoder.decode(RedditEntriesDto.self, from: data)
        return response.data.children.map { $0.data }
    }
}
