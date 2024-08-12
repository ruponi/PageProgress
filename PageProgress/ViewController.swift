//
//  ViewController.swift
//  PageProgress
//
//  Created by Ruslan Ponomarenko on 8/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var progressIndicatorView : ProgressIndicatorView = {
       let indicatorView = ProgressIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(progressIndicatorView)

        NSLayoutConstraint.activate([
            progressIndicatorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            progressIndicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            progressIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}


