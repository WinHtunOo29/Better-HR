//
//  HomeRouter.swift
//  Better HR
//
//  Created by Win Htun Oo on 19/03/2024.
//

import UIKit

class ListingRouter {
    static func createModule() -> UIViewController {
        let view = ListingViewController(nibName: "ListingViewController", bundle: nil)
        let presenter = ListingPresenter()
        let interactor = ListingInteractor()
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
}
