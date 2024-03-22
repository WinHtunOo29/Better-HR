//
//  DetailRouter.swift
//  Better HR
//
//  Created by Win Htun Oo on 20/03/2024.
//

import UIKit

class DetailRouter {
    static func createModule(seriesDetail: TVDetailsModel) -> UIViewController {
        let view = DetailViewController(nibName: "DetailViewController", bundle: nil)
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        view.seriesDetail = seriesDetail
        return view
    }
}
