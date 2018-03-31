//
//  ImageSearchListingViewController.swift
//  Image Search
//
//  Created Mayank Gupta on 29/03/18.
//  Copyright © 2018 Mayank Gupta. All rights reserved.
//


import UIKit

fileprivate enum TileSize : Int {
    case small
    case large
}

class ImageSearchListingViewController: UIViewController, ImageSearchListingViewProtocol {

	var presenter: ImageSearchListingPresenterProtocol?
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    fileprivate let reuseIdentifier = "ImageSearchListingCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    fileprivate var searches : ImageSearchResults?
    fileprivate var preferredTileSize : TileSize = .small
    
    fileprivate var itemsPerRow: CGFloat {
        get {
            //Potrait
            if UIDeviceOrientationIsPortrait(UIDevice.current.orientation){
                return preferredTileSize == .small ? 3 : 2
            }
            //Rest of the state are treated as landscape
            else {
                return preferredTileSize == .small ? 6 : 4
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func changeSizeAction(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "SELECT DISPLAY SIZE FOR IMAGE TILES", preferredStyle: .actionSheet)
        
        //Actions
        let smallAction = UIAlertAction(title: "Small", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.preferredTileSize = .small
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
        
        let largeAction = UIAlertAction(title: "Large", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
            self.preferredTileSize = .large
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(smallAction)
        alertController.addAction(largeAction)
        alertController.addAction(cancelAction)
        
        //Attributes for Popover
        let sizeOptionButton = sender as! UIView
        alertController.popoverPresentationController?.sourceView = sizeOptionButton
        alertController.popoverPresentationController?.sourceRect = CGRect(x: sizeOptionButton.bounds.midX, y: sizeOptionButton.bounds.maxY, width: 0, height: 0)
        alertController.popoverPresentationController?.permittedArrowDirections = [UIPopoverArrowDirection.up]
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Refreshing collectionview on device rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        flowLayout.invalidateLayout()
    }
}

//MARK: - UISearchBarDelegate
extension ImageSearchListingViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.collectionView.addSubview(activityIndicator)
        searchBar.isUserInteractionEnabled = false
        activityIndicator.frame = self.collectionView.bounds
        activityIndicator.startAnimating()
        
        self.presenter?.searchImageForTerm(searchBar.text!) {
            results, error in
            activityIndicator.removeFromSuperview()
            searchBar.isUserInteractionEnabled = true
            
            if let error = error {
                print("Error searching : \(error)")
                return
            }
            
            if let results = results {
                print("Found \(results.searchResults.count) matching \(results.searchTerm)")
                self.searches = results
                self.collectionView?.reloadData()
            }
        }
        
        //Emptying current collection
        self.searches = nil
        self.collectionView?.reloadData()
        
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
}

//MARK: - UICollectionViewDataSource
extension ImageSearchListingViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.searches?.searchResults != nil ? 1 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return self.searches?.searchResults.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! ImageSearchListingCell
        let searchListingImage = searches!.searchResults[(indexPath as NSIndexPath).row]
        cell.backgroundColor = UIColor.white
        
        //Setting Image
        cell.imageView.image = nil
        cell.imageView.layer.borderWidth = 1
        cell.imageView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        
        searchListingImage.loadThumbnailImage{(searchImage, error) in
            cell.imageView.layer.borderWidth = 0
            cell.imageView.image = searchImage.thumbnail
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ImageSearchListingViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Cell Size Calculation
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

//MARK: - UICollectionViewDelegate
extension ImageSearchListingViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       self.presenter?.previewImage(searches: self.searches, index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}
