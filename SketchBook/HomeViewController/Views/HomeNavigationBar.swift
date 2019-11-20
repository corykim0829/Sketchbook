//
//  HomeNavigationBar.swift
//  SketchBook
//
//  Created by Cory Kim on 2019/11/17.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

class HomeNavigationBar: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SketchBook"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    let newSketchButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "plus.circle.fill")
        button.setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = #colorLiteral(red: 0.161257118, green: 0.7255524993, blue: 0.4649934769, alpha: 1)
        button.addTarget(self, action: #selector(handleNewSketch), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleNewSketch() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        backgroundColor = #colorLiteral(red: 0.1105914637, green: 0.1099415794, blue: 0.1110958681, alpha: 1)
        
        addSubview(titleLabel)
        addSubview(newSketchButton)
        
        titleLabel.centerInSuperView()
        newSketchButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        newSketchButton.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: 24, height: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
