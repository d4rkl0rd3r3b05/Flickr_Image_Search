//
//  ImageSearchListingProtocols.swift
//  Image Search
//
//  Created Mayank Gupta on 29/03/18.
//  Copyright © 2018 Mayank Gupta. All rights reserved.
//


import Foundation

//MARK: Wireframe -
protocol ImageSearchListingWireframeProtocol: class {
    
    //MARK: Navigation Methods
    func navigateToImagePreviewScreen(searches : ImageSearchResults?, index : Int)
}

//MARK: Presenter -
protocol ImageSearchListingPresenterProtocol: class {
    
    //MARK: Router Methods
    func previewImage(searches : ImageSearchResults?, index : Int)
    
    //MARK: Interactor Methods
    func searchImageForTerm(_ searchTerm: String, completion : @escaping (_ results: ImageSearchResults?, _ error : NSError?) -> Void)
}

//MARK: Interactor -
protocol ImageSearchListingInteractorProtocol: class {

    var presenter: ImageSearchListingPresenterProtocol?  { get set }
    
    //MARK: Service Methods
    func searchImageForTerm(_ searchTerm: String, completion : @escaping (_ results: ImageSearchResults?, _ error : NSError?) -> Void)
}

//MARK: View -
protocol ImageSearchListingViewProtocol: class {

    var presenter: ImageSearchListingPresenterProtocol?  { get set }
}
