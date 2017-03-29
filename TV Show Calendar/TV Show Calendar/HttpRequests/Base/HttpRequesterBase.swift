//
//  HttpRequesterBase.swift
//  TV Show Calendar
//
//  Created by Todor on 3/29/17.
//  Copyright © 2017 Todor. All rights reserved.
//

protocol HttpRequesterBase {
    var delegate: HttpRequesterDelegate? {get set}
    
    func get(fromUrl url: String, withHeaders headers: Dictionary<String, String>?)
    
    func post(toUrl url: String, withBody body: Any?, andHeaders headers: Dictionary<String, String>?)
    
    func postJson(toUrl url: String, withBody body: Any?, andHeaders headers: Dictionary<String, String>?)
}
