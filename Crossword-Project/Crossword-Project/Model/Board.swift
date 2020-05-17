//
//  Board.swift
//  Crossword-Project
//
//  Created by CSUFTitan on 5/14/20.
//  Copyright © 2020 Nancy Badillo. All rights reserved.
//

import Foundation
import UIKit

class Board{
    var buttonAray = [UIButton]() // Might make this into a custom button later
    let currentView: UIViewController
    let buttonsSquared: Int
    let buttonSize: CGFloat
    let xValue: CGFloat
    let yValue: CGFloat
    
    let cellWidth: CGFloat
    let boardSize: CGFloat
    let bottomEnd: CGFloat
    
    
    var accentButtonIndex: Int
    
    init(numberSquared: Int, x: CGFloat, y: CGFloat, padding: CGFloat, view: UIViewController){
        buttonsSquared = numberSquared
        xValue = x
        yValue = y + padding
        currentView = view
        cellWidth = view.view.frame.width - (padding * 2)
        buttonSize = cellWidth / CGFloat(integerLiteral: numberSquared)
        boardSize = CGFloat(integerLiteral: numberSquared) * buttonSize
        bottomEnd = y + boardSize
        accentButtonIndex = 0
    }
    
    func buildBoard(){
        var currentXValue = xValue
        var currentYValue = yValue
        var index = 0
        for _ in 1 ... buttonsSquared {
            for _ in 1 ... buttonsSquared{
                index += 1
                let newCell : WordCell = WordCell(size: buttonSize, belongsTo: self, index: index)
                
                let cellFrame: CGRect = CGRect(x: currentXValue, y: currentYValue, width: buttonSize, height: buttonSize)
                newCell.frame = cellFrame
                newCell.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                newCell.setTitleColor(.black, for: .normal)
                newCell.layer.borderColor = UIColor.black.cgColor
                newCell.layer.borderWidth = 1
                newCell.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
                currentView.view.addSubview(newCell)
                buttonArray.append(newCell)
                
                currentXValue += buttonSize
                
            }
            currentYValue += buttonSize
            currentXValue = x
        }
    }
}
