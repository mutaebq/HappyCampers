//
//  DataService.swift
//  Happy Campers
//
//  Created by axMxe on 8/30/18.
//  Copyright © 2018 axMxe. All rights reserved.
//

import Foundation
import ARKit
import Alamofire
import AlamofireImage

class DataService {
    static let instance = DataService()
    
    var imageUrlArray = [String]()
    var imageArray = [UIImage]()
    var searchTerm: String?
    
    func retrieveURL(completionHandler: @escaping (_ Success: Bool) -> ()) {
        Alamofire.request("https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=d3ef798348f144728fdb66f720928282&text=\(String(describing: searchTerm))&format=json&nojsoncallback=1").responseJSON { (response) in
            guard let json = response.result.value as? Dictionary<String, AnyObject> else { return }
            let photosDict = json["photos"] as! Dictionary<String, AnyObject>
            let photosDictArray = photosDict["photo"] as! [Dictionary<String, AnyObject>]
            
            for photo in photosDictArray {
                let postUrl = "https://farm\(photo["farm"]!).staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_h_d.jpg"
                self.imageUrlArray.append(postUrl)
            }
            completionHandler(true)
        }
    }
    
    func retrieveImages(completionHandler: @escaping (_ Success: Bool) -> ()) {
        for url in imageUrlArray {
            Alamofire.request(url).responseImage(completionHandler: { (response) in
                guard let image = response.result.value else { return }
                self.imageArray.append(image)
                
                if self.imageArray.count == self.imageUrlArray.count {
                    completionHandler(true)
                }
            })
        }
    }
}
