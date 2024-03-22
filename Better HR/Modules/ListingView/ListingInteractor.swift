//
//  ListingInteractor.swift
//  Better HR
//
//  Created by Win Htun Oo on 20/03/2024.
//

import Foundation

class ListingInteractor {
    var presenter: ListingPresenter?
    
    func getMovieList() {
        NetworkingManager.shared.request(endpoint: "/discover/tv") { (result: Result<TVListModel, APIError>) in
            switch result {
            case .success(let tv):
                self.presenter?.getTVList(TVList: tv.results)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func getSeriesDetail(seriesId: Int) {
        NetworkingManager.shared.request(endpoint: "/tv/\(seriesId)") { (result: Result<TVDetailsModel, APIError>) in
            switch result {
            case .success(let details):
                self.presenter?.getSeriesDetail(seriesDetail: details)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
