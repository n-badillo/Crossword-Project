//
//  ViewController.swift
//  Crossword-Project
//
//  Created by CSUFTitan on 4/13/20.
//  Copyright © 2020 Nancy Badillo. All rights reserved.
//

import UIKit

//@Environment(\.colorScheme) var colorScheme: ColorScheme

class CrosswordViewController: UIViewController {
    
    let acrossWords = ["MIHAYLO", "LANGSDORF", "NUTWOOD", "CLAYES"]
    let acrossWordsRow = [1, 3, 7, 11]
    let acrossWordsCol = [0, 3, 2, 1]
    
    let downWords = ["MCCARTHY", "PALLOK", "TUFFY", "GORDON", "DAILY", "FULLERTON"]
    let downWordsRow = [1, 0, 7, 3, 7, 3]
    let downWordsCol = [0, 3, 4, 6, 8, 11]
    
    let wordCellSize: CGFloat = 34  // Size of the buttons in the buttonArray
    
    let hintArray = ["The name of the business building", "Name of the library", "Rumored to be haunted", "The name of the administrative building", "Previously named University Hall", "The parking structure by the visual and performing arts colleges",  "School's mascot name", "______ Performing Arts Center", "The _____ Titan", "California State University, _________ is the home of the Titans!"]
    
    var buttonArray = [[UIButton]]()
    var boardArray = [[String]]()
    var userArray = [[String]]() // Will hold the guesses of the user to display them as labels on to the buttons
    
    let numberOfSquares = 12  // The number of squares for both the rows and columns
    
    func generate2DBoardArray () {
        for _ in 0 ... (numberOfSquares-1){
            var stringArray = [String]()
            for _ in 0 ... (numberOfSquares-1){
                stringArray.append("")
            }
            boardArray.append(stringArray)
        }
    }

// MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generate2DBoardArray()
        buildCrosswordBoard(size: numberOfSquares)
        
        // Make all buttons black by default
        for secondaryArray in buttonArray{
            for button in secondaryArray{
                button.backgroundColor = .black
            }
        }
        
        fillingAcross()
        fillingDown()
        
        generateVoidCells()
        generateHintBoxes()
        createHintSection(hintString: "You are currently viewing this in DEBUG MODE.  Be sure to comment out the section marked Debugging to see blank cell generation. Cells in Orange indicate the word is going DOWN, cells in BLUE indicate across")
    
        // MARK: - Debugging
        // Uncomment this to see if the board is filling correctly
        
        
        func fillCellsWithLetters() {
            for row in 0 ... numberOfSquares-1 {
                for col in 0...numberOfSquares-1 {
                    let currentCell = buttonArray[row][col]
                    currentCell.setTitle(boardArray[row][col], for: .normal)
                    currentCell.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                    currentCell.setTitleColor(.black, for: .normal)
                    buttonArray[row][col] = currentCell
                }
            }
        }

        fillCellsWithLetters()
    }
    
    
    
    
    
// MARK: - Creating Board
    // This is the code for creating the board, filling the array with the words, generating the void cells, and highlighted buttons with numbering
    
    func buildCrosswordBoard (size: Int) {
        var horizontalValue = self.view.frame.height / 12
        for _ in 1 ... size {
            buttonArray.append(makeButtonRow(x: 6, y:Int(horizontalValue), numberOfButtons: size))
            horizontalValue += wordCellSize
        }
        
    }
    
    func makeButtonRow (x: Int, y: Int, numberOfButtons: Int) -> [UIButton]{
        var buttonArray = [UIButton]()
        var xInt = CGFloat(integerLiteral: x)
        for _ in 1 ... numberOfButtons{
            
            let currentXValue = CGFloat(xInt)
            let currentYValue = CGFloat (y)
            let button = UIButton(frame: CGRect(x:currentXValue, y: currentYValue, width: CGFloat(wordCellSize), height: CGFloat(wordCellSize)))
            
            button.backgroundColor = .white
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1
            
            self.view.addSubview(button)
            
            buttonArray.append(button)
            xInt += wordCellSize
        }
        
        return buttonArray
    }
    
    
    func generateVoidCells(){
        for row in 0 ..< 12 {
            for col in 0 ..< 12 {
                if boardArray[row][col] == "" || boardArray[row][col] == " " {
                    buttonArray[row][col].backgroundColor = .black
                    // Change this later if you want to make it support darkmode with another if statement...
                } else {
                    continue
                }
            }
        }
    }
    
    func generateHintBoxes(){
        // Could probably make this more efficent but it works for now...
        for row in 0 ..< 12 {
            for col in 0 ..< 12 {
                if(row == 0 && col == 3){
                    buttonArray[row][col].backgroundColor = .orange
                    buttonArray[row][col].tag = 1
                    
                     buttonArray[row][col].addTarget(self, action: #selector(hintButtonClicked), for: .touchUpInside)
                    generateCrosswordNumbers(row: row, col: col, num: 1)
                }
                else if(row == 1 && col == 0){
                    buttonArray[row][col].backgroundColor = .blue
                    buttonArray[row][col].tag = 2
                    
                    buttonArray[row][col].addTarget(self, action: #selector(hintButtonClicked), for: .touchUpInside)
                    generateCrosswordNumbers(row: row, col: col, num: 2)
                    
                }
                else if (row == 3 && col == 3){
                    buttonArray[row][col].backgroundColor = .blue
                    buttonArray[row][col].tag = 3
                   
                     buttonArray[row][col].addTarget(self, action: #selector(hintButtonClicked), for: .touchUpInside)
                    generateCrosswordNumbers(row: row, col: col, num: 3)
                }
                else if(row == 3 && col == 6){
                    buttonArray[row][col].backgroundColor = .orange
                    buttonArray[row][col].tag = 4
                   
                     buttonArray[row][col].addTarget(self, action: #selector(hintButtonClicked), for: .touchUpInside)
                    generateCrosswordNumbers(row: row, col: col, num: 4)
                }
                else if (row == 7 && col == 2){
                    buttonArray[row][col].backgroundColor = .blue
                    buttonArray[row][col].tag = 5
                   
                     buttonArray[row][col].addTarget(self, action: #selector(hintButtonClicked), for: .touchUpInside)
                    generateCrosswordNumbers(row: row, col: col, num: 5)
                }
                else if(row == 7 && col == 4){
                    buttonArray[row][col].backgroundColor = .orange
                    buttonArray[row][col].tag = 6
                    
                     buttonArray[row][col].addTarget(self, action: #selector(hintButtonClicked), for: .touchUpInside)
                    generateCrosswordNumbers(row: row, col: col, num: 6)
                }
                else if (row == 11 && col == 1){
                    buttonArray[row][col].backgroundColor = .blue
                    buttonArray[row][col].tag = 7
                    
                     buttonArray[row][col].addTarget(self, action: #selector(hintButtonClicked), for: .touchUpInside)
                    generateCrosswordNumbers(row: row, col: col, num: 7)
                }
                else if(row == 7 && col == 8){
                    buttonArray[row][col].backgroundColor = .orange
                    buttonArray[row][col].tag = 8
                   
                     buttonArray[row][col].addTarget(self, action: #selector(hintButtonClicked), for: .touchUpInside)
                    generateCrosswordNumbers(row: row, col: col, num: 8)
                }
                else if (row == 3 && col == 11){
                    buttonArray[row][col].backgroundColor = .orange
                    buttonArray[row][col].tag = 9
                    
                    buttonArray[row][col].addTarget(self, action: #selector(hintButtonClicked), for: .touchUpInside)
                    generateCrosswordNumbers(row: row, col: col, num: 9)
                }
                else {
                    continue
                }
            }
        }
    }
    
    func generateCrosswordNumbers (row: Int, col: Int, num: Int){
        let currentCell = buttonArray[row][col]
        let upperX = currentCell.frame.origin.x
        let upperY = currentCell.frame.origin.y
        let numberLabel = UILabel(frame: CGRect(x: upperX + 2, y: upperY + 1, width: 10, height: 10))
        
        numberLabel.text = String(num)
        numberLabel.font = numberLabel.font.withSize(10)
        self.view.addSubview(numberLabel)
    }
    

    
// MARK: - Filling the board
    func fillingAcross(){
        let currentWord = acrossWords[0]
        func fillAcross (word: String, row: Int, column: Int){
            let length = word.count
            var currentColumn = column
            var offset = 0
            
            for _ in 0 ..< length {
                let index = word.index(word.startIndex, offsetBy: offset)
                let currentLetter = word[index]
                print(currentLetter)
                buttonArray[row][currentColumn].backgroundColor = .white
                boardArray[row][currentColumn] = String(currentLetter)
                
                offset += 1
                currentColumn += 1
            }
        }
        
        for word in 0 ..< acrossWords.count {
            fillAcross(word: acrossWords[word], row: acrossWordsRow[word], column: acrossWordsCol[word])
        }
    }
    
    func fillingDown () {
        let currentWord = downWords[0]
        
        func fillDown (word: String, row: Int, column: Int){
            let length = word.count
            var currentRow = row
            var offset = 0
            
            for _ in 0 ..< length {
                let index = word.index(word.startIndex, offsetBy: offset)
                let currentLetter = word[index]
                print(currentLetter)
                buttonArray[currentRow][column].backgroundColor = .white
                boardArray[currentRow][column] = String(currentLetter)
                
                offset += 1
                currentRow += 1
            }
        }
        
        for word in 0 ..< downWords.count {
            fillDown(word: downWords[word], row: downWordsRow[word], column: downWordsCol[word])
        }
    }
    
    // MARK: - Creating the Hint section
    
    func createHintSection (hintString: String) {
        let hintSection: CGFloat = self.view.frame.width - (self.view.frame.width / 2)
        let hint = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 30, height: 150))
        hint.center = CGPoint(x: hintSection, y: (view.frame.height / 1.25))
        hint.textAlignment = .center
        hint.text = hintString
        hint.numberOfLines = 0
        hint.lineBreakMode = .byWordWrapping
        hint.backgroundColor = .gray
        self.view.addSubview(hint)
    }
    
       
    @objc func hintButtonClicked (sender: UIButton) {
        if (sender.tag == 2){
            if sender.backgroundColor == .orange {
                
                
                createHintSection(hintString: hintArray[3])
                sender.backgroundColor = .blue
            }
            else if sender.backgroundColor == .blue {
                createHintSection(hintString: hintArray[2])
                sender.backgroundColor = .orange
            }
        } else {
            createHintSection(hintString: hintArray[sender.tag])
            
        }
    }
 
}

