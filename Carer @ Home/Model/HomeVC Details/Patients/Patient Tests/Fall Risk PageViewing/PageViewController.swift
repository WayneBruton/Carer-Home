//
//  PageViewController.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/16.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit


class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  
    
    
    
    
    // MARK: IB Outlets
    
    //MARK: Variables & Constants
    
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVc(viewController: "FallRiskVCFirst"),
                self.newVc(viewController: "FallRiskVCSecond"),
                self.newVc(viewController: "FallRiskVCThird")]
    }()
    var pageControl = UIPageControl()
    
    
    // MARK: viewDidLoad etc
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = title
        self.dataSource = self
        // This sets up the first view that will show up on our page control
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        self.delegate = self
        configurePageControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: PageViewController
    
    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            // return nil
        }
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            // return nil
        }
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    
    // MARK: Methods
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.green
        self.pageControl.currentPageIndicatorTintColor = UIColor.blue
        self.view.addSubview(pageControl)
    }
    // MARK: Delegate functions
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }


}
