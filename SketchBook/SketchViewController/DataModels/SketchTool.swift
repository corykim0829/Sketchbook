//
//  SketchTool.swift
//  SketchBook
//
//  Created by Cory Kim on 2019/11/20.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

protocol SketchTool {
    var lineColor: UIColor { get set }
    var lineWidth: CGFloat { get set }
    var lineAlpha: CGFloat { get set }
    
    func initializeFirstPoint(_ point: CGPoint)
    func draw()
}

class BrushTool: UIBezierPath, SketchTool {
    var path: CGMutablePath
    var lineAlpha: CGFloat
    var lineColor: UIColor
    var firstPoint: CGPoint
    
    override init() {
        path = CGMutablePath()
        lineColor = .black
        lineAlpha = 1
        firstPoint = CGPoint(x: 0, y: 0)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeFirstPoint(_ point: CGPoint) {
        firstPoint = point
    }
    
    func moveToNextPoint(previousPoint: CGPoint, currentPoint: CGPoint) {
        let tempPath = CGMutablePath()
        tempPath.move(to: previousPoint)
        tempPath.addLine(to: currentPoint)
        path.addPath(tempPath)
    }
    
    func draw() {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.addPath(path)
        context.setAlpha(lineAlpha)
        context.setLineWidth(lineWidth)
        context.setStrokeColor(lineColor.cgColor)
        context.setBlendMode(.normal)
        context.strokePath()
    }
}
