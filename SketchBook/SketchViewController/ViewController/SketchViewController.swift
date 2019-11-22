//
//  SketchViewController.swift
//  SketchBook
//
//  Created by Cory Kim on 2019/11/19.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

class SketchViewController: UIViewController {
    @IBOutlet weak var sketchView: SketchView!
    private let statusCoverBar = UIView(frame: .zero)
    private let sketchToolBar = SketchToolBar(frame: .zero)
    
    // MARK: - popup view
    private lazy var transparentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.frame = self.view.frame
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        return view
    }()
    
    private let colorPickerView = ColorPickerView(frame: .zero)
    private let brushPickerView = BrushPickerView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupToolBarWorkers()
        setupToolBarPopupWorkers()
        setupUI()
    }
    
    private func setupToolBarPopupWorkers() {
        colorPickerView.colorPickerWorker = { [weak self] (lineColor) in
            self?.sketchView.changeTool(.brush)
            self?.sketchView.changeLineColor(lineColor)
            self?.sketchToolBar.changeColorOfColorButton(to: lineColor)
            self?.handleDismiss()
        }
        colorPickerView.colorAlphaSliderWorker = { [weak self] (alphaValue) in
            self?.sketchView.changeLineAlpha(alphaValue)
        }
        brushPickerView.strokeWidthSliderWorker = { [weak self] (widthValue) in
            self?.sketchView.changeLineWidth(widthValue)
        }
    }
    
    private func setupToolBarWorkers() {
        sketchToolBar.colorBtnTouchedWorker = { [weak self] in
            self?.showColorPickerView()
        }
        sketchToolBar.brushBtnTouchedWorker = { [weak self] in
            self?.showBrushPickerView()
            self?.sketchView.changeTool(.brush)
        }
        sketchToolBar.eraserBtnTouchedWorker = { [weak self] in
            self?.sketchView.changeTool(.eraser)
        }
    }
    
    private func showColorPickerView() {
        view.addSubview(transparentView)
        _ = sketchView.currentLineColor
        colorPickerView.setCurrentLineAlpha(sketchView.currentLineAlpha)
        view.addSubview(colorPickerView)
        colorPickerView.anchor(top: sketchToolBar.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 8, bottom: 0, right: 0))
    }
    
    private func showBrushPickerView() {
        view.addSubview(transparentView)
        brushPickerView.setCurrentLineWidth(sketchView.currentLineWidth)
        view.addSubview(brushPickerView)
        brushPickerView.anchor(top: sketchToolBar.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 8, bottom: 0, right: 0))
    }
    
    @objc private func handleDismiss() {
        [transparentView, colorPickerView, brushPickerView].forEach({ $0.removeFromSuperview() })
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(statusCoverBar)
        statusCoverBar.backgroundColor = .yellow
        view.addSubview(sketchToolBar)
        if #available(iOS 11.0, *) {
            statusCoverBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
            sketchToolBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 40))
        } else {
            statusCoverBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: UIApplication.shared.statusBarFrame.height))
            sketchToolBar.anchor(top: statusCoverBar.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 40))
        }
    }

}
