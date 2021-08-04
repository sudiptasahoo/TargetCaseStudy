//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo
import Kingfisher

struct ProductListComponent: Component {
    var dispatcher: Dispatcher?

    func prepareView(_ view: ProductListView, item: ListItemViewState) {
        // Called on first view or ProductListView
    }
    
    func configureView(_ view: ProductListView, item: ListItemViewState) {
        view.titleLbl.text = item.product.title
        view.priceLbl.text = item.product.salePrice?.displayString ?? item.product.regularPrice.displayString
        view.productImage.kf.setImage(with: item.product.imageLink)
    }
    
    func selectView(_ view: ProductListView, item: ListItemViewState) {
        dispatcher?.triggerEvent(ListItemPressed(product: item.product))
    }
}

extension ProductListComponent: HarmonyLayoutComponent {
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        return 100.0
    }
}
