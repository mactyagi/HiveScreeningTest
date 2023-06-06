//
//  NetworkManager.swift
//  HiveScreeningTest
//
//  Created by Manu on 06/06/23.
//

import Foundation
import UIKit



class NetworkManager {
    func fetchData(searchString: String, comp: @escaping(_ data: DataModel?, _ isError: Bool) -> Void){
        let endpoint = "https://en.wikipedia.org/w/api.php"
        var urlComponent = URLComponents(string: endpoint)
        urlComponent?.queryItems = [
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "prop", value: "pageimages|extracts"),
            URLQueryItem(name: "pilimit", value: "20"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "generator", value: "search"),
            URLQueryItem(name: "gsrsearch", value: searchString),
            URLQueryItem(name: "gsrlimit", value: "20"),
            URLQueryItem(name: "gsrnamespace", value: "0"),
            URLQueryItem(name: "exintro", value: "1"),
            URLQueryItem(name: "explaintext", value: "1"),
            URLQueryItem(name: "exsentences", value: "1"),
            URLQueryItem(name: "exlimit", value: "max")
        ]
        
        let request = URLRequest(url: (urlComponent?.url!)!)
        URLSession.shared.dataTask(with: request) { (data,response,error)in
            if let _ = error{
                comp(nil, true)
                return
            }
            if let data = data{
                do{
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(DataModel.self, from: data)
                    comp(decodedData, false)
                }catch{
                   comp(nil, true)
                }
            }
        }.resume()
    }
}
