//
//  ListingPresenter.swift
//  Better HR
//
//  Created by Win Htun Oo on 20/03/2024.
//

import Foundation

class ListingPresenter {
    var view: ListingViewController?
    
    func getTVList(TVList: [Results]) {
        view?.getTVList(TVList: TVList)
    }
    
    func getSeriesDetail(seriesDetail: TVDetailsModel) {
        view?.getSeriesDetail(seriesDetail: seriesDetail)
    }
}
