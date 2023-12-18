//
//  NetworkManager.swift
//  UIKitTableExample
//
//  Created by irna fitriani on 18/12/23.
//

import Foundation

enum NetworkError: String, Error {
    case invalidUrl = "Invalid URL"
    case invalidResponse = "Invalid response"
    case invalidData = "Invalid data"
}

class NetworkManager {
    static let shared = NetworkManager()
    let urlString = "https://zenquotes.io/api/quotes"
    let decoder         = JSONDecoder()
    
    func getQuote() async throws -> [Quote] {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidUrl
            
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try decoder.decode([Quote].self, from: data)
        } catch {
            throw NetworkError.invalidData
        }
    }
}
