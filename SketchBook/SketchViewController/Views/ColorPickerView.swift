//
//  ColorPickerView.swift
//  SketchBook
//
//  Created by Cory Kim on 2019/11/21.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

class ColorPickerView: UIView {
    
    private let colorPicker: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .red
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let colorAlphaLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Alpha"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let colorAlphaSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.addTarget(self, action: #selector(handleColorAlphaChanged), for: .valueChanged)
        return slider
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            colorPicker,
            colorAlphaLabel,
            colorAlphaSlider
        ])
        sv.axis = .vertical
        sv.spacing = 4
        return sv
    }()
    
    var colorAlphaSliderWorker: ((CGFloat) -> Void)?
    
    @objc private func handleColorAlphaChanged() {
        colorAlphaSliderWorker?(CGFloat(colorAlphaSlider.value))
    }

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
        backgroundColor = .white
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 16
        constrainWidth(200)
        constrainHeight(200)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 12, right: 16))
    }
}
