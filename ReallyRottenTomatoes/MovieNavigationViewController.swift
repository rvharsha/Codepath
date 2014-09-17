//
//  MovieNavigationController.swift
//
//
//  Created by Harsha Vashisht on 9/16/14.
//
//

import UIKit

class MovieNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 131, green: 139, blue: 131, alpha: 1.0)]
        self.navigationBar.tintColor = UIColor(red: 131, green: 139, blue: 131, alpha: 1.0)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
