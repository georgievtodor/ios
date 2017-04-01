////
////  HttpRequester.swift
////  TV Show Calendar
////
////  Created by Todor on 3/23/17.
////  Copyright © 2017 Todor. All rights reserved.
////
//
//import Foundation
//
//class HttpRequester: HttpRequesterBase {
//    enum HttpMethods: String {
//        case get     = "GET"
//        case post    = "POST"
//        case put     = "PUT"
//        case delete  = "DELETE"
//    }
//    
//    var delegate: HttpRequesterDelegate?
//    
//    func send(toUrl urlString: String, withMethod method: HttpMethods, withBody body: Any?, andHeaders headers: Dictionary<String, String> = [:]) {
//        let url = URL(string: urlString)
//        
//        var request = URLRequest(url: url!)
//        request.httpMethod = method.rawValue
//        
//        if(body != nil) {
//            do {
//                request.httpBody = try JSONSerialization.data(withJSONObject: body!, options: .prettyPrinted)
//            }
//            catch {
//                
//            }
//        }
//        
//        headers.forEach() { request.setValue($0.value, forHTTPHeaderField: $0.key) }
//        
//        weak var weakSelf = self
//        
//        let dataTask = URLSession.shared.dataTask(with: request) { (bodyData, urlResponse, error) in
//            do {
//                let body = try JSONSerialization.jsonObject(with: bodyData!, options: .allowFragments)
//                weakSelf?.delegate?.dataReceived(data: body)
//            }
//            catch {
//                
//            }
//        }
//        
//        dataTask.resume()
//        
//    }
//    
//    func get(fromUrl url: String, withHeaders headers: Dictionary<String, String>?) {
//        self.send(toUrl: url, withMethod: .get, withBody: nil, andHeaders: headers ?? [:])
//    }
//    
//    func post(toUrl url: String, withBody body: Any?, andHeaders headers: Dictionary<String, String>?) {
//        self.send(toUrl: url, withMethod: .post, withBody: body, andHeaders: headers ?? [:])
//    }
//    
//    func postJson(toUrl url: String, withBody body: Any?, andHeaders headers: Dictionary<String, String>?) {
//        var jsonHeaders = headers ?? [:]
//        jsonHeaders["Content-Type"] = "Application/Json"
//        self.send(toUrl: url, withMethod: .post, withBody: body, andHeaders: jsonHeaders)
//    }
//    func put(fromUrl url: String, withBody body: Any?, andHeaders headers: Dictionary<String, String>?) {
//        self.send(toUrl: url, withMethod: .put, withBody: body, andHeaders: headers ?? [:])
//    }
//    
//}
//
