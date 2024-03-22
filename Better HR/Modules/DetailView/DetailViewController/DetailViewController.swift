//
//  DetailViewController.swift
//  Better HR
//
//  Created by Win Htun Oo on 20/03/2024.
//

import Foundation
import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var seasonTableView: UITableView!
    var interactor: DetailInteractor?
    var seriesDetail: TVDetailsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let url = seriesDetail?.backdropPath {
            backDropImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original/\(url)"))
        }
        nameLabel.text = seriesDetail?.originalName
        overviewLabel.text = seriesDetail?.overview
    }
    
    func setupTableView() {
        seasonTableView.delegate = self
        seasonTableView.dataSource = self
        
        let nib = UINib.init(nibName: "SeasonsTableViewCell", bundle: nil)
        self.seasonTableView.register(nib, forCellReuseIdentifier: "SeasonsTableViewCell")
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seriesDetail?.seasons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = seasonTableView.dequeueReusableCell(withIdentifier: String(describing: SeasonsTableViewCell.self), for: indexPath) as! SeasonsTableViewCell
        cell.render(season: seriesDetail?.seasons?[indexPath.row].name ?? "", episodeCount: seriesDetail?.seasons?[indexPath.row].episodeCount ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
