//
//  ArtistAPIClient.swift
//  API-Keys-Lab
//
//  Created by Mr Wonderful on 9/9/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit

class ArtistAPIClient{
    
    private init (){}
    static let shared = ArtistAPIClient()
    
    func fetchData(name:String?, completionHandler: @escaping (Result<[TrackList],AppError>) -> ()){
        
        var artistURL = "http://api.musixmatch.com/ws/1.1/track.search?q_artist=kayone&page_size=50&page=1&s_track_rating=desc&apikey=3445509192b50cd7ccfe4df777f38cb2"
        
        
        if let artistName = name {
            let newString = artistName.replacingOccurrences(of: " ", with: "-")
            artistURL = "http://api.musixmatch.com/ws/1.1/track.search?q_artist=\(newString)&page_size=50&page=1&s_track_rating=desc&apikey=3445509192b50cd7ccfe4df777f38cb2"
        }
        NetworkManager.shared.fetchData(urlString: artistURL) { (result) in
            switch result{
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                
                do {
                    let artistData = try JSONDecoder().decode(ArtistWrapper.self, from: data)
                    completionHandler(.success(artistData.message.body.track_list))
                }catch{
                    completionHandler(.failure(.noDataError))
                }
            }
        }
    }
}

