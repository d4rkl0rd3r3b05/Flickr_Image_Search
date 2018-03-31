//
//  ImageSearchPreviewViewController.swift
//  Image Search
//
//  Created Mayank Gupta on 30/03/18.
//  Copyright © 2018 Mayank Gupta. All rights reserved.
//


import UIKit

class ImageSearchPreviewViewController: UIPageViewController, ImageSearchPreviewViewProtocol {

	var presenter: ImageSearchPreviewPresenterProtocol?

    //MARK: - Properties
    var searches : ImageSearchResults?
    var index : Int = 0
    
	override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        
        self.dataSource = self
        self.setViewControllers([getViewControllerAtIndex(index: index)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
    }

    fileprivate func getViewControllerAtIndex(index: Int) -> ContentViewController
    {
        let contentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        contentViewController.pageIndex = index
        contentViewController.associateSearchListingImage = searches?.searchResults[index]
        
        return contentViewController
    }
}

//MARK: - UIPageViewControllerDataSource
extension ImageSearchPreviewViewController : UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContent: ContentViewController = viewController as! ContentViewController
        
        var index = pageContent.pageIndex
        if ((index == 0) || (index == NSNotFound)) {
            return nil
        }
        index -= 1
        
        return getViewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContent: ContentViewController = viewController as! ContentViewController
        
        var index = pageContent.pageIndex
        if (index == NSNotFound) {
            return nil
        }
        index += 1
        
        if (index == searches?.searchResults.count) {
            return nil
        }
        
        return getViewControllerAtIndex(index: index)
    }
}

