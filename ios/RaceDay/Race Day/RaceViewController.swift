//
//  RaceViewController.swift
//  Race Day
//
//  Created by Dick Fickling on 1/3/15.
//  Copyright (c) 2015 Questionable Intent. All rights reserved.
//

import UIKit

class RaceViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var _race: Race!
    var pageViewController: UIPageViewController!
    var mapPage: MapViewController!
    var detailsPage: DetailsViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapPage = storyboard!.instantiateViewControllerWithIdentifier("mapViewController") as MapViewController
        self.mapPage.showRace(self._race)
        self.detailsPage = storyboard!.instantiateViewControllerWithIdentifier("detailsViewController") as DetailsViewController
        
        self.pageViewController.setViewControllers([self.detailsPage], direction: UIPageViewControllerNavigationDirection.Reverse, animated: false, completion: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embedSegue" {
            self.pageViewController = segue.destinationViewController as UIPageViewController
            self.pageViewController.delegate = self
            self.pageViewController.dataSource = self
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController is DetailsViewController {
            return self.mapPage
        } else {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController is MapViewController {
            return self.detailsPage
        } else {
            return nil
        }
    }

    @IBAction func segmentedControlChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.pageViewController.setViewControllers([self.detailsPage], direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
        } else {
            
            self.pageViewController.setViewControllers([self.mapPage], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
    }
}
