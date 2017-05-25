//
//  PageViewController.swift
//  KYPageViewController
//
//  Created by kanchan yadav on 5/8/17.
//  Copyright © 2017 kanchan yadav. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController,UIPageViewControllerDataSource {
    
    private var currentIndex = 0
    
    /* computer property to store an array of view Controllers for UIPageViewController.
     */
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.getViewControllerWithId(id: "ThirdViewController"),
                self.getViewControllerWithId(id: "SecondViewController"),
                self.getViewControllerWithId(id: "FirstViewController")
                ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        if let lastVC = self.orderedViewControllers.last {
            setViewControllers([lastVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    /*returns a view controller from Main.storyboard with given id.
     */
    private func getViewControllerWithId(id:String) -> UIViewController{
        let storyboard = UIStoryboard(name:"Main" , bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        return vc
    }
}

/* UIPageViewController Delegate methods to handle forward nad backward swipe.
 */
extension PageViewController : UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //get current controller index in controllers array. if next is not nil, return it o/w return nil
        
//        guard orderedViewControllers.index(of: viewController) != nil else {
//            return nil
//        }
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1

        guard  previousIndex >= 0 && orderedViewControllers.count > previousIndex else {
            return nil
        }
        
         return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //get current controller index in controllers array. if previous is not nil, return it o/w return nil
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < orderedViewControllers.count else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}

