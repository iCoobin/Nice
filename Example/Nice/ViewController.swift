//
//  ViewController.swift
//  Nice
//
//  Created by iCoobin on 03/11/2019.
//  Copyright (c) 2019 iCoobin. All rights reserved.
//

import UIKit
import Nice

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = Nice.Const.kScreenWidth
        print(Nice.Const.isiPhoneX)
        print(Nice.Const.isSimulator)
        
        let _ = BBView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class BBView: Nice.BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeUI() {
        
    }
    
    override func makeEvent() {
        
    }
    
    override func makeConstraint() {
        
    }
    
    override func refreshUI(viewModel: Any?) {
        
    }
    
}
