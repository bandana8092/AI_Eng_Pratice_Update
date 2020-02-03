//
//  ServiceManager.swift
//  Bandana_Update_2
//
//  Created by Rakesh Nangunoori on 03/02/20.
//  Copyright © 2020 Rakesh Nangunoori. All rights reserved.
//

import UIKit

class ServiceManager: NSObject {
    static let shared = ServiceManager()
    func getDetailsFromServer(url: String, pageCount: Int, total: Int, complitionHandler: @escaping([String:Any]?, ResponseStatus)-> Void) {
        let finalUrl = URL(string: "\(url)\(pageCount)")
        print(finalUrl!)
        let request = URLRequest(url: finalUrl!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (Data, urlResponse, error) in
            if Data == nil {
                
            }else {
                do{
                    let jsonResult = try JSONSerialization.jsonObject(with: Data!, options: .mutableContainers) as? [String:Any]
                    guard let response = jsonResult else{complitionHandler(nil, .badResponse)
                        return
                    }
                    complitionHandler(response, .succes)
                 } catch {
                    complitionHandler(nil, .error) 
                }
            }
        }
        task.resume()
    }
}
