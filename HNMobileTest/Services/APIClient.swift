//
//  APIClient.swift
//  HNMobileTest
//
//  Created by Oscar Cuadra on 1/27/18.
//  Copyright © 2018 Oscar Cuadra. All rights reserved.
//

import Foundation

class APIClient {
    
    func  loadJSONData() {
        let urlString = "http://hn.algolia.com/api/v1/search_by_date?query=ios"
        
        if let url = URL(string: urlString) {
            if let data = try? String(contentsOf: url) {
                let jsonT = JSON(parseJSON: data)
                let hits = Hit().customInit(json: jsonT)
                if hits.isEmpty {
                    return
                }
                for hit in hits {
                    RealmService.shared.create(hit)
                }
            }
            else {
                print("Error en RealmService.loadJSONData()")
            }
        }
    }
}
