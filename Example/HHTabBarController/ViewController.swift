//
//  ViewController.swift
//  HHTabBarController
//
//  Created by michaelstrongself@outlook.com on 03/01/2024.
//  Copyright (c) 2024 michaelstrongself@outlook.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button: UIButton = UIButton(type: .custom)
        button.setTitle("仿头条栏目", for: .normal)
        button.backgroundColor = .blue
        view.addSubview(button)
        button.frame = CGRect(x: 100, y: 200, width: 100, height: 80)
        button.addTarget(self, action: #selector(jumpHHViewController), for: .touchUpInside)
        
    }
    
    @objc func jumpHHViewController() {
        let vc: HHViewController = HHViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

