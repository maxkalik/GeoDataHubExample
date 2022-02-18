//
//  ContentViewModel.swift
//  GeoHUB
//
//  Created by Maksim Kalik on 17/02/2022.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    @Published var predictableValues: Array<String> = []
    @Published var text = ""
    
    let apikey = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJSZXN0cGVuIiwianRpIjoiMTU5IiwidHMiOjE2NDUxMDYxMDU3MzEsImlzcyI6Imh0dHA6Ly9yZWFjaC11LmNvbSJ9.sjnyLqq_jIOVuz2HTHxv9rLn4AycxSQbVL58wJipPro"
    
    func searchAddress(_ text: String) {
        guard let address = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let endpoint: String = "https://api.geodatahub.eu/gc?apikey=\(apikey)&q=\(address)&include_apartments=true"

        guard let url = URL(string: endpoint) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let value = try self.jsonDecoder.decode(GeoDataHubModel.self, from: data)
                value.features.forEach {
                    print($0.properties)
                }
                DispatchQueue.main.async {
                    self.predictableValues = value.features.map {
                        let postalCode: String = $0.properties.postalCode ?? ""
                        return "\(postalCode) \($0.properties.fullAddress)"
                    }
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
