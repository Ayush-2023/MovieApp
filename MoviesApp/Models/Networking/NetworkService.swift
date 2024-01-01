//
//  NetworkService.swift
//  MoviesApp
//
//  Created by Ayush Kumar Sinha on 31/12/23.
//

import Foundation
import UIKit

class NetworkService {
    
    //dependency
    let session = URLSession.shared
    
    static var shared = NetworkService()
    private init() {  }
    
    func fetchData(using request: URLRequest, onCompletion: @escaping (Data?) -> (Void)) {
        session.dataTask(with: request) { (data,response,error) in
            guard error == nil, let data = data else{
                onCompletion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Status code not 200")
                onCompletion(nil)
                return
            }
            onCompletion(data)
        }.resume()
    }
    
    
    func requestJsonData(from apiUrlString: String, using queryList: [String: String], onCompletion: @escaping (Data?)->(Void)) {
        
        var urlComponents = URLComponents(string: apiUrlString)
        urlComponents?.queryItems = queryList.map({ (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        })
        
        guard let url = urlComponents?.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.allHTTPHeaderFields = ["accept": "application/json"]
        
        self.fetchData(using: request) { response in
            onCompletion(response)
        }
    }
    
    func requestImageData(from imageUrl: String,onCompletion: @escaping (UIImage?) -> (Void)){
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        self.fetchData(using: URLRequest(url: url)) { (data) in
            if let imageData = data {
                onCompletion(UIImage(data: imageData))
            }
        }
    }
}
