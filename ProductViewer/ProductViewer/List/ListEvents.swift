//
//  ListEvents.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

struct ListItemPressed: EventType {
    
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
}
