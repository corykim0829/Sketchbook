//
//  ViewController.swift
//  SketchBook
//
//  Created by Cory Kim on 2019/11/16.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, NewSketchDelegate {
    
    private let blackView = UIView()
    private let newSketchPopupView = NewSketchPopupView(frame: CGRect(x: 0, y: 0, width: 240, height: 300))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newSketchPopupView.delegate = self
        setupUI()
    }
    
    func didTabToNewSketch() {
        dismissPopupView {
            self.blackView.removeFromSuperview()
            self.newSketchPopupView.removeFromSuperview()
            let viewController = SketchViewController(nibName: "SketchViewController", bundle: nil)
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func newSketchButtonTapped(_ sender: Any) {
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        view.addSubview(blackView)
        blackView.frame = view.frame
        blackView.alpha = 0
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        view.addSubview(newSketchPopupView)
        newSketchPopupView.center = CGPoint(x: view.center.x, y: view.center.y + 1340)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 1
            self.newSketchPopupView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 80)
            
        }, completion: nil)
    }
    
    @objc fileprivate func handleDismiss() {
        
        dismissPopupView {
            self.blackView.removeFromSuperview()
            self.newSketchPopupView.removeFromSuperview()
        }
    }
    
    private func dismissPopupView(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            self.newSketchPopupView.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 1340)
        }) { _ in
            completion()
        }
    }

    private func setupUI() {
        
    }
}

