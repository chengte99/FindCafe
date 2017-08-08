//
//  APIManager.swift
//  FindCafe
//
//  Created by ChengTeLin on 2017/8/7.
//  Copyright © 2017年 Let'sGoBuildApp. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class APIManager{
    
    static let shared = APIManager()
    
    func getCoffeeAPI(completionHandler: @escaping (JSON) -> Void){
        if let url = URL(string: API_URL){
            Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding(), headers: nil).responseJSON(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    let jsonData = JSON(value)
                    completionHandler(jsonData)
                case .failure:
                    completionHandler(nil)
                }
            })
        }
    }
    
}
