//
//  BrushPickerView.swift
//  SketchBook
//
//  Created by Cory Kim on 2019/11/21.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

class BrushPickerView: UIView {
    
    private let strokeWidthLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Stroke Width"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let strokeWidthSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 30
        slider.addTarget(self, action: #selector(handleStrokeWidthChanged), for: .valueChanged)
        return slider
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            strokeWidthLabel,
            strokeWidthSlider
        ])
        sv.axis = .vertical
        sv.spacing = 4
        return sv
    }()
    
    var strokeWidthSliderWorker: ((CGFloat) -> Void)?
    
    @objc private func handleStrokeWidthChanged() {
        strokeWidthSliderWorker?(CGFloat(strokeWidthSlider.value))
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
//        constrainHeight(64)
        constrainWidth(200)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 12, right: 16))
    }
}
