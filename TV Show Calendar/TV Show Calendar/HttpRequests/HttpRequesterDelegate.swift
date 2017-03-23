//
//  HttpRequesterDelegate.swift
//  TV Show Calendar
//
//  Created by Todor on 3/23/17.
//  Copyright © 2017 Todor. All rights reserved.
//

import Foundation

protocol HttpRequesterDelegate {
    func dataReceived(data: Any)
    
    func errorReceived(error: Error)
}

extension HttpRequesterDelegate {
    func dataReceived(data: Any) {
        
    }
    
    func errorReceived(error: Error) {
        
    }
}
