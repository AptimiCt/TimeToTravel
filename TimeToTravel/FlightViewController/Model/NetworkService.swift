//
//  NetworkService.swift
//  TimeToTravel
//
//  Created by Александр Востриков on 04.06.2022.
//

import Foundation

final class NetworkService {
    
    private init(){}
    
    static let shared = NetworkService()
    
    func fetchData(url: String, completion: @escaping (_ flights: [Flight]) -> ()) {
        
        guard let currentURL = URL(string: url) else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: currentURL) { data, response, error in
            guard let data = data else { return }
            let json = try! JSONDecoder().decode(Travel.self, from: data)
            DispatchQueue.main.async {
                completion(json.data)
            }
        }.resume()
    }

}
