//
//  SketchToolBar.swift
//  SketchBook
//
//  Created by Cory Kim on 2019/11/21.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

class SketchToolBar: UIView {
    
    private func generateButton(selector: Selector, color: UIColor = .clear, text: String = "", image: UIImage?) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        if let image = image {
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitleColor(.white, for: .normal)
        button.constrainWidth(32)
        button.constrainHeight(32)
        button.layer.cornerRadius = 32 / 2
        button.backgroundColor = color
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    private lazy var undoButton: UIButton = generateButton(selector: #selector(handleUndoBtnTouched), image: #imageLiteral(resourceName: "icons8-undo-60"))
    private lazy var redoButton: UIButton = generateButton(selector: #selector(handleRedoBtnTouched), image: #imageLiteral(resourceName: "icons8-redo-60"))
    private lazy var colorButton: UIButton = generateButton(selector: #selector(handleColorBtnTouched), color: .black, image: nil)
    private lazy var brushButton: UIButton = generateButton(selector: #selector(handleBrushBtnTouched), image: #imageLiteral(resourceName: "icons8-paint-brush-48"))
    private lazy var eraserButton: UIButton = generateButton(selector: #selector(handleEraserBtnTouched), image: #imageLiteral(resourceName: "icons8-erase-60"))
    
    var undoBtnTouchedWorker: (() -> Void)?
    var redoBtnTouchedWorker: (() -> Void)?
    var colorBtnTouchedWorker: (() -> Void)?
    var brushBtnTouchedWorker: (() -> Void)?
    var eraserBtnTouchedWorker: (() -> Void)?
    
    @objc private func handleUndoBtnTouched() {
        undoBtnTouchedWorker?()
    }
    
    @objc private func handleRedoBtnTouched() {
        redoBtnTouchedWorker?()
    }
    
    @objc private func handleColorBtnTouched() {
        colorBtnTouchedWorker?()
    }
    
    @objc private func handleBrushBtnTouched() {
        brushBtnTouchedWorker?()
    }
    
    @objc private func handleEraserBtnTouched() {
        eraserBtnTouchedWorker?()
    }
    
    func changeColorOfColorButton(to: UIColor) {
        colorButton.backgroundColor = to
    }
    
    private lazy var toolsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            undoButton,
            redoButton,
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
