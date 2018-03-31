//
//  ImageSearchPreviewProtocols.swift
//  Image Search
//
//  Created Mayank Gupta on 30/03/18.
//  Copyright © 2018 Mayank Gupta. All rights reserved.
//


import Foundation

//MARK: Wireframe -
protocol ImageSearchPreviewWireframeProtocol: class {

}
//MARK: Presenter -
protocol ImageSearchPreviewPresenterProtocol: class {

}

//MARK: Interactor -
protocol ImageSearchPreviewInteractorProtocol: class {

  var presenter: ImageSearchPreviewPresenterProtocol?  { get set }
}

//MARK: View -
protocol ImageSearchPreviewViewProtocol: class {

  var presenter: ImageSearchPreviewPresenterProtocol?  { get set }
}
