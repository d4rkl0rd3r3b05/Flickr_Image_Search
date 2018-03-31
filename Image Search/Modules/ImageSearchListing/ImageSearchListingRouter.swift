//
//  ImageSearchListingRouter.swift
//  Image Search
//
//  Created Mayank Gupta on 29/03/18.
//  Copyright © 2018 Mayank Gupta. All rights reserved.
//


import UIKit

class ImageSearchListingRouter: ImageSearchListingWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageSearchListingViewController") as! ImageSearchListingViewController
        let interactor = ImageSearchListingInteractor()
        let router = ImageSearchListingRouter()
        let presenter = ImageSearchListingPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    //MARK: Navigation Methods
    func navigateToImagePreviewScreen(searches : ImageSearchResults?, index : Int) {
        //Creating Preview ViewController
        let previewViewController = ImageSearchPreviewRouter.createModule(searches: searches, index: index)
        self.viewController?.navigationController?.pushViewController(previewViewController, animated: true)
    }
}
