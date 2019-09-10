//
//  ViewController.swift
//  API-Keys-Lab
//
//  Created by Mr Wonderful on 9/9/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController {
    var songs = [TrackList](){
        didSet {
            DispatchQueue.main.async {
                self.artistTableView.reloadData()
            }
        }
    }
    
    var userSearchString:String? = nil{
        didSet{
            self.artistTableView.reloadData()
        }
    }
    
    var userFilteredSearch:[TrackList]{
        get{
            guard let searchString = userSearchString else {return songs}
            
            guard searchString != "" else {return songs}
            
            return songs
        }
    }
  
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var artistTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
}
    private func setUpView(){
        searchBar.delegate = self
        artistTableView.delegate = self
        artistTableView.dataSource = self
    }
    
    
    
    private func fetchArtistData(artistName:String?){
        ArtistAPIClient.shared.fetchData(name: artistName) { (result) in
            switch result{
            case .failure(let error):
                print("cant retrieve data \(error)")
            case .success(let artist):
                self.songs = artist
                
            }
        }
    }
}

extension ArtistViewController: UITableViewDelegate{}
extension ArtistViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userFilteredSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "artistCellID") else {return UITableViewCell()}
        
        let info = userFilteredSearch[indexPath.row]
        
        cell.textLabel?.text = info.track.track_name
        cell.detailTextLabel?.text = info.track.artist_name
        
        return cell
    }
    
    
}

extension ArtistViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       self.userSearchString = searchBar.text
        fetchArtistData(artistName: searchBar.text)
    }
}
