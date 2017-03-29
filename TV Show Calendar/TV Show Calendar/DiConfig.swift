//
//  DiConfig.swift
//  TV Show Calendar
//
//  Created by Todor on 3/29/17.
//  Copyright © 2017 Todor. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class DiConfigHttp {
    public static func setup(container: Container) {
        container.register(HttpRequesterBase.self) { _ in HttpRequester() }
    }
}

extension SwinjectStoryboard {
    public static func setup() {
        DiConfigHttp.setup(container: defaultContainer)
    }
}
