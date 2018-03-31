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
    
    //MARK: - Properties
    var pageIndex = 0
    var associateSearchListingImage : SearchListingImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = self.associateSearchListingImage?.thumbnail
        self.associateSearchListingImage?.loadLargeImage{(searchListingImage, error) in
            self.imageView.image = searchListingImage.largeImage
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
