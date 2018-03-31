//
//  ImageSearchListingPresenter.swift
//  Image Search
//
//  Created Mayank Gupta on 29/03/18.
//  Copyright © 2018 Mayank Gupta. All rights reserved.
//


import UIKit

class ImageSearchListingPresenter: ImageSearchListingPresenterProtocol {

    weak private var view: ImageSearchListingViewProtocol?
    var interactor: ImageSearchListingInteractorProtocol?
    private let router: ImageSearchListingWireframeProtocol

    init(interface: ImageSearchListingViewProtocol, interactor: ImageSearchListingInteractorProtocol?, router: ImageSearchListingWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    //MARK: Service Methods
    func searchImageForTerm(_ searchTerm: String, completion : @escaping (_ results: ImageSearchResults?, _ error : NSError?) -> Void) {
        //Proxying call to Interactor
        self.interactor?.searchImageForTerm(searchTerm, completion: completion)
    }
    
    //MARK: Router Methods
    func previewImage(searches : ImageSearchResults?, index : Int) {
        self.router.navigateToImagePreviewScreen(searches: searches, index: index)
    }
}
