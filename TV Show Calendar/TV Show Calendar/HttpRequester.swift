//
//  HttpRequester.swift
//  TV Show Calendar
//
//  Created by Todor on 3/23/17.
//  Copyright © 2017 Todor. All rights reserved.
//

import Foundation

class HttpRequester {
    enum HttpMethods: String {
        case options = "OPTIONS"
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
        case trace   = "TRACE"
        case connect = "CONNECT"
    }
    
    var delegate: HttpRequesterDelegate?
    
    func send(toUrl urlString: String, withMethod method: HttpMethods, withBody bodyDict: Dictionary<String, Any>? = nil, andHeaders headers: Dictionary<String, String> = [:]) {
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue
        
        if(bodyDict != nil) {
            do {
                let body = try JSONSerialization.data(withJSONObject: bodyDict!, options: .prettyPrinted)
                request.httpBody = body
            }
            catch {
                
            }
        }
        
        headers.forEach() { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        weak var weakSelf = self
        
        let dataTask = URLSession.shared.dataTask(with: request) { (bodyData, urlResponse, error) in
            do {
                let body = try JSONSerialization.jsonObject(with: bodyData!, options: .allowFragments)
                weakSelf?.delegate?.dataReceived(data: body)
            }
            catch {
                
            }
        }
        
        dataTask.resume()

    }
    
    func get(fromUrl url: String) {
        self.send(toUrl: url, withMethod: .get)
    }
    
    func post(fromUrl url: String, withBody bodyDict: Dictionary<String, Any>, andHeaders headers: Dictionary<String, String>) {
        self.send(toUrl: url, withMethod: .post, withBody: bodyDict, andHeaders: headers)
    }
    
    func put(fromUrl url: String, withBody bodyDict: Dictionary<String, Any>, andHeaders headers: Dictionary<String, String>) {
        self.send(toUrl: url, withMethod: .put, withBody: bodyDict, andHeaders: headers)
    }
}

