//
//  ImageSearchPreviewRouter.swift
//  Image Search
//
//  Created Mayank Gupta on 30/03/18.
//  Copyright © 2018 Mayank Gupta. All rights reserved.
//


import UIKit

class ImageSearchPreviewRouter: ImageSearchPreviewWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule(searches : ImageSearchResults?, index : Int = 0) -> UIViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageSearchPreviewViewController") as! ImageSearchPreviewViewController
        view.searches = searches
        view.index = index
        
        let interactor = ImageSearchPreviewInteractor()
        let router = ImageSearchPreviewRouter()
        let presenter = ImageSearchPreviewPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
