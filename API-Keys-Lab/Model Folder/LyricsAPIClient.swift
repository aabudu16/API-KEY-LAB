//
//  LyricsAPIClient.swift
//  API-Keys-Lab
//
//  Created by Mr Wonderful on 9/9/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit

class LyricsAPIClient{
    
    private init (){}
    static let shared = LyricsAPIClient()
    
    func fetchData(track:Int?, completionHandler: @escaping (Result<Lyrics,AppError>) -> ()){
        
        var lyricsURL = "http://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=17641638&apikey=3445509192b50cd7ccfe4df777f38cb2"
        
        
        if let trackID = track {
            
            lyricsURL = "http://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=\(trackID)&apikey=3445509192b50cd7ccfe4df777f38cb2"
        }
        NetworkManager.shared.fetchData(urlString: lyricsURL) { (result) in
            switch result{
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                
                do {
                    let artistData = try JSONDecoder().decode(LyricsWrapper.self, from: data)
                    completionHandler(.success(artistData.message.body.lyrics))
                }catch{
                    completionHandler(.failure(.noDataError))
                }
            }
        }
    }
}

