//
//  ImageSearchPreviewPresenter.swift
//  Image Search
//
//  Created Mayank Gupta on 30/03/18.
//  Copyright © 2018 Mayank Gupta. All rights reserved.
//


import UIKit

class ImageSearchPreviewPresenter: ImageSearchPreviewPresenterProtocol {

    weak private var view: ImageSearchPreviewViewProtocol?
    var interactor: ImageSearchPreviewInteractorProtocol?
    private let router: ImageSearchPreviewWireframeProtocol

    init(interface: ImageSearchPreviewViewProtocol, interactor: ImageSearchPreviewInteractorProtocol?, router: ImageSearchPreviewWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
