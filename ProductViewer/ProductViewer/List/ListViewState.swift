//
//  ListViewState.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

/// List view state
struct ListViewState: TempoViewState, TempoSectionedViewState {
    var listItems: [TempoViewStateItem]
    
    var sections: [TempoViewStateItem] {
        return listItems
    }
}

/// View state for each list item.
struct ListItemViewState: TempoViewStateItem, Equatable {
    let product: Product
}

func ==(lhs: ListItemViewState, rhs: ListItemViewState) -> Bool {
    return lhs.product.title == rhs.product.title
        && lhs.product.id == rhs.product.id
}
