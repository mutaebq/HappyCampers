//
//  ViewController.swift
//  Happy Campers
//
//  Created by axMxe on 8/30/18.
//  Copyright © 2018 axMxe. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SearchVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataService.instance.imageUrlArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else { return UICollectionViewCell() }
        let imageFromIndex = DataService.instance.imageArray[indexPath.row]
        let imageView = UIImageView(image: imageFromIndex)
        cell.addSubview(imageView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numOfColumns: CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numOfColumns = 4
        }
        
        let spaceBetweenCells: CGFloat = 0
        let padding: CGFloat = 0
        let cellDimension = ((collectionView.bounds.width - padding) - (numOfColumns - 1) * spaceBetweenCells) / numOfColumns
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    
    @IBOutlet weak var searchBar: CustomTextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.searchBar.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DataService.instance.searchTerm = searchBar.text
        searchBar.text = ""
        
        self.view.endEditing(true)
        return false
    }
    
    func getImages() {
        DataService.instance.retrieveURL { (success) in
            if success {
                DataService.instance.retrieveImages(completionHandler: { (success) in
                    if success {
                        self.collectionView?.reloadData()
                    }
                })
            }
        }
    }
    
    func clearCollectionView() {
        DataService.instance.imageUrlArray = []
        DataService.instance.imageArray = []
        collectionView.reloadData()
    }
    
    func cancelAllSessions() {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach({ $0.cancel() })
            uploadData.forEach({ $0.cancel() })
            downloadData.forEach({ $0.cancel() })
        }
    }
}
