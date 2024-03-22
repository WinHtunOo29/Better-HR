//
//  HomeViewController.swift
//  Better HR
//
//  Created by Win Htun Oo on 19/03/2024.
//

import Foundation
import UIKit

class ListingViewController: UIViewController {
    @IBOutlet weak var listingTableView: UITableView!
    var interactor: ListingInteractor?
    var TVList: [Results] = []
    var seriesOriginalNames: [String] = []
    var seriesReleaseDates: [String] = []
    let fetchedItems = SQLiteManager.shared.fetchItems()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        interactor?.getMovieList()
    }
    
    func setupTableView() {
        listingTableView.delegate = self
        listingTableView.dataSource = self
        
        let nib = UINib.init(nibName: "ListingTableViewCell", bundle: nil)
        self.listingTableView.register(nib, forCellReuseIdentifier: "ListingTableViewCell")
    }
}

extension ListingViewController {
    func getTVList(TVList: [Results]) {
        self.TVList = TVList
        for i in 0..<TVList.count {
            self.seriesOriginalNames.append(TVList[i].originalName)
            self.seriesReleaseDates.append(TVList[i].firstAirDate)
        }
        if TVList.count > 0 {
            SQLiteManager.shared.deleteAllItems()
            SQLiteManager.shared.addItem(names: self.seriesOriginalNames, releaseDates: self.seriesReleaseDates)
        }
        self.listingTableView.reloadData()
    }
    
    func getSeriesDetail(seriesDetail: TVDetailsModel) {
        let vc = DetailRouter.createModule(seriesDetail: seriesDetail)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.TVList.count == 0 {
            return self.fetchedItems.names.count
        } else {
            return self.TVList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listingTableView.dequeueReusableCell(withIdentifier: String(describing: ListingTableViewCell.self), for: indexPath) as! ListingTableViewCell
        if self.TVList.count == 0 {
            cell.render(title: self.fetchedItems.names[indexPath.row], releaseDate: self.fetchedItems.releaseDates[indexPath.row], banner: "")
        } else {
            cell.render(title: self.TVList[indexPath.row].originalName, releaseDate: self.TVList[indexPath.row].firstAirDate, banner: "https://image.tmdb.org/t/p/original/\(self.TVList[indexPath.row].backdropPath)")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.getSeriesDetail(seriesId: self.TVList[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
