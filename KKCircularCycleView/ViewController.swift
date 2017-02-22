//
//  ViewController.swift
//  KKCircularCycleView
//
//  Created by 王铁山 on 2017/2/19.
//  Copyright © 2017年 kk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var begin: UIButton!
    
    var aaView: KKCircularCycleView = KKCircularCycleView.init(origin: CGPoint.init(x: 100, y: 100))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.aaView.hiddenWhenStoped = false
        
        self.view.addSubview(self.aaView)
        
    }

    @IBAction func beginAction(sender: AnyObject) {
        self.aaView.starAnimation()
    }
    
    @IBAction func stop(sender: AnyObject) {
        
        self.aaView.stopAnimation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

