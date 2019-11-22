//
//  ColorPickerView.swift
//  SketchBook
//
//  Created by Cory Kim on 2019/11/21.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

class ColorPickerView: UIView {
    
    private let colorPickerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Color"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private func randomColorButtons(_ rangeOfRGB: ClosedRange<Int>) -> UIButton {
        let button = UIButton(type: .system)
        let r = Int.random(in: rangeOfRGB)
        let g = Int.random(in: rangeOfRGB)
        let b = Int.random(in: rangeOfRGB)
        let color = UIColor(displayP3Red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
        button.backgroundColor = color
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(greaterThanOrEqualTo: button.heightAnchor).isActive = true
        button.addTarget(self, action: #selector(handlePickColor), for: .touchUpInside)
        return button
    }
    
    @objc private func handlePickColor(button: UIButton) {
        guard let color = button.backgroundColor else { return }
        
        colorPickerWorker?(color)
    }
    
    private func randomColorButtonsHorizontalStackView(_ rangeOfRGB: ClosedRange<Int>) -> UIStackView {
        let stackView = UIStackView()
        for _ in 0..<5 {
            stackView.addArrangedSubview(randomColorButtons(rangeOfRGB))
        }
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        return stackView
    }
    
    private lazy var colorStackView: UIStackView = {
        let stackView = UIStackView()
        for _ in 0..<2 {
            stackView.addArrangedSubview(randomColorButtonsHorizontalStackView(0...255))
        }
        if let firstLineSV = stackView.arrangedSubviews.first as? UIStackView {
            firstLineSV.arrangedSubviews.first?.backgroundColor = .black
        }
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        return stackView
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
        slider.value = 1
        slider.addTarget(self, action: #selector(handleColorAlphaChanged), for: .valueChanged)
        return slider
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            colorPickerLabel,
            colorStackView,
            colorAlphaLabel,
            colorAlphaSlider
        ])
        sv.axis = .vertical
        sv.spacing = 4
        return sv
    }()
    
    var colorPickerWorker: ((UIColor) -> Void)?
    var colorAlphaSliderWorker: ((CGFloat) -> Void)?
    
    @objc private func handleColorAlphaChanged() {
        colorAlphaSliderWorker?(CGFloat(colorAlphaSlider.value))
    }
    
    func setCurrentLineAlpha(_ value: CGFloat) {
        colorAlphaSlider.value = Float(value)
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
        constrainHeight(160)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 12, right: 16))
    }
}
