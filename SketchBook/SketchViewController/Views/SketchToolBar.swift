//
//  SketchToolBar.swift
//  SketchBook
//
//  Created by Cory Kim on 2019/11/21.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

class SketchToolBar: UIView {
    
    private func generateButton(selector: Selector, color: UIColor, text: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.titleLabel?.textColor = .white
        button.constrainWidth(32)
        button.constrainHeight(32)
        button.backgroundColor = color
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    private lazy var colorButton: UIButton = generateButton(selector: #selector(handleColorBtnTouched), color: .black, text: "C")
    private lazy var brushButton: UIButton = generateButton(selector: #selector(handleBrushBtnTouched), color: .blue, text: "B")
    private lazy var eraserButton: UIButton = generateButton(selector: #selector(handleEraserBtnTouched), color: .magenta, text: "E")
    
    public var colorBtnTouchedWorker: (() -> Void)?
    public var brushBtnTouchedWorker: (() -> Void)?
    public var eraserBtnTouchedWorker: (() -> Void)?
    
    @objc private func handleColorBtnTouched() {
        colorBtnTouchedWorker?()
    }
    
    @objc private func handleBrushBtnTouched() {
        brushBtnTouchedWorker?()
    }
    
    @objc private func handleEraserBtnTouched() {
        eraserBtnTouchedWorker?()
    }
    
    private lazy var toolsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            colorButton,
            brushButton,
            eraserButton
        ])
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    }()
        

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .yellow
        addSubview(toolsStackView)
        toolsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0))
    }
}
