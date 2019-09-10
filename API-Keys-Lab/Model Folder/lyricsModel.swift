//
//  lyricsModel.swift
//  API-Keys-Lab
//
//  Created by Mr Wonderful on 9/9/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit

struct LyricsWrapper:Codable{
    let message:Messages
}

struct Messages:Codable{
    let body:Bodys
}

struct Bodys:Codable{
    let lyrics:Lyrics
}

struct Lyrics:Codable{
    let lyrics_body:String
}
