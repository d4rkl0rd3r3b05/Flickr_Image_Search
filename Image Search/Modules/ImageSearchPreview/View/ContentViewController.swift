//
//  ContentViewController.swift
//  Image Search
//
//  Created by Mayank Gupta on 30/03/18.
//  Copyright © 2018 Mayank Gupta. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    //MARK: - Properties
    var pageIndex = 0
    var associateSearchListingImage : SearchListingImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let thumbnail = self.associateSearchListingImage?.thumbnail {
            self.imageView.image = thumbnail
            self.infoLabel.isHidden = true
        }else{
            self.infoLabel.text = "Loading image..."
            self.infoLabel.isHidden = false
        }

        self.associateSearchListingImage?.loadLargeImage{(searchListingImage, error) in
            
            if searchListingImage.largeImage == nil {
                if let error = error {
                    print("Error loading : \(error)")
                }
                self.infoLabel.text = "Error Loading image!!!"
                self.imageView.image = nil
                self.infoLabel.isHidden = false
                
                return
            }
            
            self.imageView.image = searchListingImage.largeImage
            self.infoLabel.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
