//
//  NewSketchPopupView.swift
//  SketchBook
//
//  Created by Cory Kim on 2019/11/17.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

class NewSketchPopupView: UIView {
    private let xibName = "NewSketchPopupView"
    
    var newBtnTouchedWorker: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibInit()
    }
    
    private func xibInit() {
        if let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
        clipsToBounds = true
        layer.cornerRadius = 8
    }
    
    @IBAction func toNewSketchTapped(_ sender: Any) {
        newBtnTouchedWorker?()
    }
}
