//  ViewController.swift
//  Connect4Game
//
//  Created by William Du on 2017/4/25.
//  Copyright © 2017 Weiran (William) Du. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player:AVAudioPlayer?
    
    var rand = 0
    var modeAI = false
    var isAIactive = false
    var aiCurrentMoving = false
    var label : UILabel!
    var AIPosition = UILabel(frame: CGRect(x: 15, y: 150, width: 345, height: 30))
    var winnerDisplayLabel = UILabel(frame: CGRect(x: 15, y: 50, width: 345, height: 30))
    let modeSelect = UIButton(frame: CGRect(x: 15, y: 100, width: 345, height: 40))
    let restartBtn = UIButton(frame: CGRect(x: 15, y: 560, width: 345, height: 40))
    let addPieceBtn1 = UIButton(frame: CGRect(x: 15, y: 190, width: 40, height: 40))
    let addPieceBtn2 = UIButton(frame: CGRect(x: 65, y: 190, width: 40, height: 40))
    let addPieceBtn3 = UIButton(frame: CGRect(x: 115, y: 190, width: 40, height: 40))
    let addPieceBtn4 = UIButton(frame: CGRect(x: 165, y: 190, width: 40, height: 40))
    let addPieceBtn5 = UIButton(frame: CGRect(x: 215, y: 190, width: 40, height: 40))
    let addPieceBtn6 = UIButton(frame: CGRect(x: 265, y: 190, width: 40, height: 40))
    let addPieceBtn7 = UIButton(frame: CGRect(x: 315, y: 190, width: 40, height: 40))
    let soundButton = UIButton(frame: CGRect(x: 15, y: 615, width: 345, height: 40))
    
    var lastMove = "Yellow"
    
    
    // This array represents board
    var pieceValue = [[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]]
    
    // These arrays are for layout
    let yValueArray = [250,300,350,400,450,500]
    let xValueArray = [15,65,115,165,215,265,315]
    
    // Determine whether it is AI's turn or not
    var aiTurn = false
    var lastMovedPiece = "x"
    var soundEnabled = true
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    // Load the View
    override func viewDidLoad() {
        
        self.Play()
        let view = UIView(frame: CGRect())
        view.backgroundColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        
        label = UILabel(frame: CGRect(x: 15, y: 10, width: 345, height: 30))
        label.text = "Welcome to Connect-4 Game"  //Title
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        
        
        winnerDisplayLabel.textAlignment = .center
        winnerDisplayLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        winnerDisplayLabel.text = ""
        addPieceBtn1.setBackgroundImage(#imageLiteral(resourceName: "arrow"), for: .normal)
        addPieceBtn2.setBackgroundImage(#imageLiteral(resourceName: "arrow.png"), for: .normal)
        addPieceBtn3.setBackgroundImage(#imageLiteral(resourceName: "arrow.png"), for: .normal)
        addPieceBtn4.setBackgroundImage(#imageLiteral(resourceName: "arrow.png"), for: .normal)
        addPieceBtn5.setBackgroundImage(#imageLiteral(resourceName: "arrow.png"), for: .normal)
        addPieceBtn6.setBackgroundImage(#imageLiteral(resourceName: "arrow.png"), for: .normal)
        addPieceBtn7.setBackgroundImage(#imageLiteral(resourceName: "arrow.png"), for: .normal)
        
        restartBtn.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        restartBtn.setTitle("Restart", for: .normal)
        restartBtn.layer.cornerRadius = 10
        
        modeSelect.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        modeSelect.setTitle("Play Against AI", for: .normal)
        modeSelect.layer.cornerRadius = 10
        
        soundButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        soundButton.layer.cornerRadius = 10
        soundButton.setTitle("Turn off the background music", for: .normal)
        
        addPieceBtn1.addTarget(self, action: #selector(addOne), for:.touchUpInside)
        addPieceBtn2.addTarget(self, action: #selector(addTwo), for: .touchUpInside)
        addPieceBtn3.addTarget(self, action: #selector(addThree), for: .touchUpInside)
        addPieceBtn4.addTarget(self, action: #selector(addFour), for: .touchUpInside)
        addPieceBtn5.addTarget(self, action: #selector(addFive), for: .touchUpInside)
        addPieceBtn6.addTarget(self, action: #selector(addSix), for: .touchUpInside)
        addPieceBtn7.addTarget(self, action: #selector(addSeven), for: .touchUpInside)
        restartBtn.addTarget(self, action: #selector(remove), for: .touchUpInside)
        modeSelect.addTarget(self, action: #selector(changeMode), for: .touchUpInside)
        soundButton.addTarget(self, action: #selector(changeSound), for: .touchUpInside)
        
        AIPosition.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        AIPosition.textAlignment = .center
        
        
        // Configuration of display of board
        for index in xValueArray{
            for jndex in yValueArray{
                let pieceBackground = UIView(frame: CGRect(x: CGFloat(index), y: CGFloat(jndex), width: 40, height: 40))
                pieceBackground.layer.cornerRadius = 20
                pieceBackground.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                view.addSubview(pieceBackground)
            }
        }
        
        // Add buttons on the screen
        view.addSubview(modeSelect)
        view.addSubview(addPieceBtn1)
        view.addSubview(addPieceBtn2)
        view.addSubview(addPieceBtn3)
        view.addSubview(addPieceBtn4)
        view.addSubview(addPieceBtn5)
        view.addSubview(addPieceBtn6)
        view.addSubview(addPieceBtn7)
        view.addSubview(restartBtn)
        view.addSubview(label)
        view.addSubview(winnerDisplayLabel)
        view.addSubview(AIPosition)
        view.addSubview(soundButton)
        
        
        self.view = view
    }
    
    // Enable or disable sound
    func changeSound (){
        if soundEnabled == true{
            player?.volume = 0.0
            soundButton.setTitle("Turn on the background music", for: .normal)
            soundEnabled = false
        }else{
            player?.volume = 0.5
            soundButton.setTitle("Turn off the background music", for: .normal)
            soundEnabled = true
        }
    }
    
    
    // Play sound
    func Play(){
        let url = Bundle.main.url(forResource: "background", withExtension: "mp3")!
        do{
            try player = AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
            player?.volume = 0.5
            player?.numberOfLoops = -1
        }catch{
            print("error")
        }
    }
    
    // Change game mode
    func changeMode(){
        remove()
        if modeAI == false{
            modeSelect.setTitle("Play with a human partner", for: .normal)
            modeAI = true
        }else{
            modeSelect.setTitle("Play against AI", for: .normal)
            modeAI = false
        }
    }
    
    // Erase the board and screen
    func remove(){
        lastMove = "Yellow"
        pieceValue = [[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]]
        
        for v in self.view.subviews{
            if (v != winnerDisplayLabel){
                if (v.backgroundColor == #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1) || v.backgroundColor == #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)){
                    v.removeFromSuperview()
                }
            }
        }
        
        self.winnerDisplayLabel.backgroundColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        self.winnerDisplayLabel.text = ""
        enableAllButtons()
    }
    
    // Display pieces on screen
    func addPieceOnScreen(columnPosition:Int){
        var point = CGPoint()
        point.x = CGFloat(xValueArray[columnPosition])
        var zeroPosition = 6
        for index in 0...5{
            if (pieceValue[columnPosition][index] == 0){
                zeroPosition = index
                break
            }
        }
        if (zeroPosition <= 5){
            if (lastMove == "Yellow"){
                pieceValue[columnPosition][zeroPosition] = 1
            }else{
                pieceValue[columnPosition][zeroPosition] = 2
            }
        }
        switch zeroPosition{
        case 0:
            point.y = 500
        case 1:
            point.y = 450
        case 2:
            point.y = 400
        case 3:
            point.y = 350
        case 4:
            point.y = 300
        case 5:
            point.y = 250
        default:
            break
        }
        let pieceView = UIView(frame: CGRect(origin: point, size: CGSize(width: 40, height: 40)))
        pieceView.layer.cornerRadius = 20
        if (lastMove == "Yellow"){
            pieceView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            lastMove = "Red"
        }else{
            pieceView.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            lastMove = "Yellow"
        }
        if (zeroPosition <= 5){
            view.addSubview(pieceView)
        }
    }
    
    // Functions for buttons
    func addOne(){
        addPieceOnScreen(columnPosition: 0)
        winnerCheck()
        getPossibleMoves(array: pieceValue)
        aiPlay()
        
        
    }
    
    func addTwo(){
        addPieceOnScreen(columnPosition: 1)
        winnerCheck()
        getPossibleMoves(array: pieceValue)
        aiPlay()
    }
    
    func addThree(){
        addPieceOnScreen(columnPosition: 2)
        winnerCheck()
        getPossibleMoves(array: pieceValue)
        aiPlay()
    }
    
    func addFour(){
        addPieceOnScreen(columnPosition: 3)
        winnerCheck()
        getPossibleMoves(array: pieceValue)
        aiPlay()
    }
    
    func addFive(){
        addPieceOnScreen(columnPosition: 4)
        winnerCheck()
        getPossibleMoves(array: pieceValue)
        aiPlay()
    }
    
    func addSix(){
        addPieceOnScreen(columnPosition: 5)
        winnerCheck()
        getPossibleMoves(array: pieceValue)
        aiPlay()
    }
    func addSeven(){
        addPieceOnScreen(columnPosition: 6)
        winnerCheck()
        getPossibleMoves(array: pieceValue)
        aiPlay()
    }
    
    // AI player
    
    func aiPlay(){
        if modeAI == true{
            if isWin(board: pieceValue) == false{
                let theMove = getNextMove(board: pieceValue)
                addPieceOnScreen(columnPosition:theMove)
                AIPosition.text = "AI went to column \(theMove+1)"
                winnerCheck()
            }
        }
        getPossibleMoves(array: pieceValue)
        
    }
    
    func disableAllButtons(){
        self.addPieceBtn1.isEnabled = false
        self.addPieceBtn2.isEnabled = false
        self.addPieceBtn3.isEnabled = false
        self.addPieceBtn4.isEnabled = false
        self.addPieceBtn5.isEnabled = false
        self.addPieceBtn6.isEnabled = false
        self.addPieceBtn7.isEnabled = false
    }
    
    func disableButtonByIndex(index:Int){
        switch index{
        case 0:
            self.addPieceBtn1.isEnabled = false
        case 1:
            self.addPieceBtn2.isEnabled = false
        case 2:
            self.addPieceBtn3.isEnabled = false
        case 3:
            self.addPieceBtn4.isEnabled = false
        case 4:
            self.addPieceBtn5.isEnabled = false
        case 5:
            self.addPieceBtn6.isEnabled = false
        case 6:
            self.addPieceBtn7.isEnabled = false
        default:
            break
            
        }
    }
    
    func enableAllButtons(){
        self.addPieceBtn1.isEnabled = true
        self.addPieceBtn2.isEnabled = true
        self.addPieceBtn3.isEnabled = true
        self.addPieceBtn4.isEnabled = true
        self.addPieceBtn5.isEnabled = true
        self.addPieceBtn6.isEnabled = true
        self.addPieceBtn7.isEnabled = true
    }
    
    func winnerCheck(){
        var con = true // The variable determines whether to continue the winner checking
        // Check four pieces connected vertically
        if (con == true){
            for index in 0...6 {
                for jndex in 0...2{
                    if (pieceValue[index][jndex] == 1 && pieceValue[index][jndex+1] == 1 && pieceValue[index][jndex+2] == 1 && pieceValue[index][jndex+3] == 1){
                        self.winnerDisplayLabel.text = "The RED player wins"
                        self.winnerDisplayLabel.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                        disableAllButtons()
                        con = false
                        break
                    }else{
                        if (pieceValue[index][jndex] == 2 && pieceValue[index][jndex+1] == 2 && pieceValue[index][jndex+2] == 2 && pieceValue[index][jndex+3] == 2){
                            self.winnerDisplayLabel.text = "The YELLOW player wins"
                            self.winnerDisplayLabel.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                            disableAllButtons()
                            con = false
                            break
                        }
                    }
                }
            }
        }
        
        // Check four pieces connected horizontally
        if (con == true){
            for index in 0...3{
                for jndex in 0...5{
                    if (pieceValue[index][jndex] == 1 && pieceValue[index+1][jndex] == 1 && pieceValue[index+2][jndex] == 1 && pieceValue[index+3][jndex] == 1){
                        self.winnerDisplayLabel.text = "The RED player wins"
                        self.winnerDisplayLabel.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                        disableAllButtons()
                        con = false
                        break
                    }else{
                        if (pieceValue[index][jndex] == 2 && pieceValue[index+1][jndex] == 2 && pieceValue[index+2][jndex] == 2 && pieceValue[index+3][jndex] == 2){
                            self.winnerDisplayLabel.text = "The YELLOW player wins"
                            self.winnerDisplayLabel.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                            disableAllButtons()
                            con = false
                            break
                        }
                    }
                }
            }
        }
        
        // Check four pieces connected diagonally "/"
        if (con == true){
            for index in 0...3{
                for jndex in 0...2{
                    if (pieceValue[index][jndex] == 1 && pieceValue[index+1][jndex+1] == 1 && pieceValue[index+2][jndex+2] == 1 && pieceValue[index+3][jndex+3] == 1){
                        self.winnerDisplayLabel.text = "The RED player wins"
                        self.winnerDisplayLabel.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                        disableAllButtons()
                        con = false
                        break
                    }else{
                        if (pieceValue[index][jndex] == 2 && pieceValue[index+1][jndex+1] == 2 && pieceValue[index+2][jndex+2] == 2 && pieceValue[index+3][jndex+3] == 2){
                            self.winnerDisplayLabel.text = "The YELLOW player wins"
                            self.winnerDisplayLabel.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                            disableAllButtons()
                            con = false
                            break
                        }
                    }
                }
            }
        }
        
        // Check four pieces connected diagonally "\"
        if (con == true){
            for index in 3...6{
                for jndex in 0...2{
                    if (pieceValue[index][jndex] == 1 && pieceValue[index-1][jndex+1] == 1 && pieceValue[index-2][jndex+2] == 1 && pieceValue[index-3][jndex+3] == 1){
                        self.winnerDisplayLabel.text = "The RED player wins"
                        self.winnerDisplayLabel.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                        disableAllButtons()
                        con = false
                        break
                    }else{
                        if (pieceValue[index][jndex] == 2 && pieceValue[index-1][jndex+1] == 2 && pieceValue[index-2][jndex+2] == 2 && pieceValue[index-3][jndex+3] == 2){
                            self.winnerDisplayLabel.text = "The YELLOW player wins"
                            self.winnerDisplayLabel.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                            disableAllButtons()
                            con = false
                            break
                        }
                    }
                }
            }
        }
        
        
        
    }
    
    
    func addPieceOnBoard(board:Array<[Int]>,column:Int,piece:Int) -> Array<[Int]>{
        var newBoard = board
        var zeroPosition = 0
        for row in 0...5{
            if board[column][row] != 1 && board[column][row] != 2{
                zeroPosition = row
                break
            }
        }
        newBoard[column][zeroPosition] = piece
        return newBoard
    }
    
    func getNextMove(board:Array<[Int]>) -> Int{
        
        let player = 2
        var ret = 0
        var score = [Int]()
        let movable = possibleMoves(board: board)
        
        for index in movable{
            var newBoard = board
            newBoard = addPieceOnBoard(board: newBoard, column: index, piece: player)
            score.append(miniMax(board: newBoard, depth: 4, mini: false))
        }
        for index in 0...(score.count-1){
            if score[index] == score.max() {
                ret = movable[index]
            }
        }
        
        
        return ret
    }
    
    
    func possibleMoves(board:Array<[Int]>) -> Array<Int>{
        var possibleMovesArray = [Int]()
        for index in 0...6{
            if board[index].contains(0) == true{
                possibleMovesArray.append(index)
            }
        }
        return possibleMovesArray
    }
    
    
    func getPossibleMoves(array:Array<[Int]>){
        var possibleMovesArray = [Int]()
        for index in 0...6{
            if array[index].contains(0) == true{
                possibleMovesArray.append(index)
            }
        }
        for index in 0...6{
            if possibleMovesArray.contains(index) == false{
                disableButtonByIndex(index: index)
            }
        }
    }
    
    func getCurrentScore(board:Array<[Int]>,opponent:Int) -> Int{
        var nextMove = [Array<Int>]()
        var returnValue = 0
        var aiPiece = 0
        if opponent == 1{
            aiPiece = 2
        }else{
            if opponent == 2{
                aiPiece = 1
            }
        }
        
        
        func opponentTwoConnected(row:Int,col:Int){
            // for horizontal right action
            if col <= 4{
                if board[col+1][row] == 1 && board[col+2][row] == 1{
                    returnValue -= 100
                }
            }
            // for horizontal middle action
            if col >= 1 && col <= 5{
                if board[col-1][row] == 1 && board[col+1][row] == 1{
                    returnValue -= 100
                }
            }
            // for horizontal left action
            if col >= 2 && col <= 6{
                if board[col-1][row] == 1 && board[col-2][row] == 1{
                    returnValue -= 100
                }
            }
            // for vertical down action
            if row >= 2{
                if board[col][row-1] == 1 && board[col][row-2] == 1{
                    returnValue -= 100
                }
            }
            // for "/" right action
            if col <= 4 && row <= 3{
                if board[col+1][row+1] == 1 && board[col+2][row+2] == 1{
                    returnValue -= 100
                }
            }
            // for "/" middle action
            if col <= 5 && col >= 1 && row >= 1 && row <= 4{
                if board[col-1][row-1] == 1 && board[col+1][row+1] == 1{
                    returnValue -= 100
                }
            }
            // for "/" left action
            if col >= 2 && row >= 2{
                if board[col-1][row-1] == 1 && board[col-2][row-2] == 1{
                    returnValue -= 100
                }
            }
            // for "\" right action
            if col <= 4 && row >= 2{
                if board[col+1][row-1] == 1 && board[col+2][row-2] == 1{
                    returnValue -= 100
                }
            }
            // for "\" middle action
            if col <= 5 && col >= 1 && row >= 1 && row <= 4{
                if board[col-1][row+1] == 1 && board[col+1][row-1] == 1{
                    returnValue -= 100
                }
            }
            // for "\" left action
            if col >= 2 && row <= 3{
                if board[col-1][row+1] == 1 && board[col-2][row+2] == 1{
                    returnValue -= 100
                }
            }
        }
        
        func aiTwoConnected(row:Int,col:Int){
            // for horizontal right action
            if col <= 4{
                if board[col+1][row] == 2 && board[col+2][row] == 2{
                    returnValue += 100
                }
            }
            // for horizontal middle action
            if col >= 1 && col <= 5{
                if board[col-1][row] == 2 && board[col+1][row] == 2{
                    returnValue += 100
                }
            }
            // for horizontal left action
            if col >= 2 && col <= 6{
                if board[col-1][row] == 2 && board[col-2][row] == 2{
                    returnValue += 100
                }
            }
            // for vertical down action
            if row >= 2{
                if board[col][row-1] == 2 && board[col][row-2] == 2{
                    returnValue += 100
                }
            }
            // for "/" right action
            if col <= 4 && row <= 3{
                if board[col+1][row+1] == 2 && board[col+2][row+2] == 2{
                    returnValue += 100
                }
            }
            // for "/" middle action
            if col <= 5 && col >= 1 && row >= 1 && row <= 4{
                if board[col-1][row-1] == 2 && board[col+1][row+1] == 2{
                    returnValue += 100
                }
            }
            // for "/" left action
            if col >= 2 && row >= 2{
                if board[col-1][row-1] == 2 && board[col-2][row-2] == 2{
                    returnValue += 100
                }
            }
            // for "\" right action
            if col <= 4 && row >= 2{
                if board[col+1][row-1] == 2 && board[col+2][row-2] == 2{
                    returnValue += 100
                }
            }
            // for "\" middle action
            if col <= 5 && col >= 1 && row >= 1 && row <= 4{
                if board[col-1][row+1] == 2 && board[col+1][row-1] == 2{
                    returnValue += 100
                }
            }
            // for "\" left action
            if col >= 2 && row <= 3{
                if board[col-1][row+1] == 2 && board[col-2][row+2] == 2{
                    returnValue += 100
                }
            }
        }
        
        func opponentThreeConnected(row:Int,col:Int){
            
            // for horizontal right action
            if col <= 3{
                if board[col+1][row] == 1 && board[col+2][row] == 1 && board[col+3][row] == 1{
                    returnValue -= 600
                }
            }
            
            // for horizontal semi-right action
            if col >= 1 && col <= 4{
                if board[col-1][row] == opponent && board[col+1][row] == opponent && board[col+2][row] == opponent{
                    returnValue -= 600
                }
            }
            
            // for horizontal semi-left action
            if col >= 2 && col <= 5{
                if board[col-1][row] == opponent && board[col-2][row] == opponent && board[col+1][row] == opponent{
                    returnValue -= 600
                }
            }
            
            // for horizontal left action
            if col >= 3{
                if board[col-1][row] == opponent && board[col-2][row] == opponent && board[col-3][row] == opponent{
                    returnValue -= 600
                }
            }
            
            //for "\" left action
            if col >= 3 && row <= 2{
                if board[col-1][row+1] == opponent && board[col-2][row+2] == opponent && board[col-3][row+3] == opponent{
                    returnValue -= 600
                }
            }
            
            //for "\" right action
            if col <= 3 && row >= 3{
                if board[col+1][row-1] == opponent && board[col+2][row-2] == opponent && board[col+3][row-3] == opponent{
                    returnValue -= 600
                }
            }
            
            //for "\" semi-right action
            if col >= 1 && col <= 4 && row <= 4 && row >= 2{
                if board[col-1][row+1] == opponent && board[col+1][row-1] == opponent && board[col+2][row-2] == opponent{
                    returnValue -= 600
                }
            }
            
            //for "\" semi-left action
            if col >= 2 && col <= 5 && row >= 1 && row <= 3{
                if board[col-1][row+1] == opponent && board[col-2][row+2] == opponent && board[col+1][row-1] == opponent{
                    returnValue -= 600
                }
            }
            
            //for "/" right action
            if col <= 3 && row <= 2{
                if board[col+1][row+1] == opponent && board[col+2][row+2] == opponent && board[col+3][row+3] == opponent{
                    returnValue -= 600
                }
            }
            
            //for "/" left action
            if col >= 3 && row >= 3{
                if board[col-1][row-1] == opponent && board[col-2][row-2] == opponent && board[col-3][row-3] == opponent{
                    returnValue -= 600
                }
            }
            
            //for "/" semi-right action
            if col >= 1 && col <= 4 && row >= 1 && row <= 3{
                if board[col-1][row-1] == opponent && board[col+1][row+1] == opponent && board[col+2][row+2] == opponent{
                    returnValue -= 600
                }
            }
            
            //for "/" semi-left action
            if col >= 2 && col <= 5 && row >= 2 && row <= 4{
                if board[col-1][row-1] == opponent && board[col-2][row-2] == opponent && board[col+1][row+1] == opponent{
                    returnValue -= 600
                }
            }
            
            //for vertical action
            if row <= 5 && row >= 3{
                if board[col][row-1] == opponent && board[col][row-2] == opponent && board[col][row-3] == opponent{
                    returnValue -= 600
                }
            }
        }
        
        func aiPieceThreeConnected(row:Int,col:Int){
            
            // for horizontal right action
            if col <= 3{
                if board[col+1][row] == aiPiece && board[col+2][row] == aiPiece && board[col+3][row] == aiPiece{
                    returnValue += 600
                }
            }
            
            // for horizontal semi-right action
            if col >= 1 && col <= 4{
                if board[col-1][row] == aiPiece && board[col+1][row] == aiPiece && board[col+2][row] == aiPiece{
                    returnValue += 600
                }
            }
            
            // for horizontal semi-left action
            if col >= 2 && col <= 5{
                if board[col-1][row] == aiPiece && board[col-2][row] == aiPiece && board[col+1][row] == aiPiece{
                    returnValue += 600
                }
            }
            
            // for horizontal left action
            if col >= 3{
                if board[col-1][row] == aiPiece && board[col-2][row] == aiPiece && board[col-3][row] == aiPiece{
                    returnValue += 600
                }
            }
            
            //for "\" left action
            if col >= 3 && row <= 2{
                if board[col-1][row+1] == aiPiece && board[col-2][row+2] == aiPiece && board[col-3][row+3] == aiPiece{
                    returnValue += 600
                }
            }
            
            //for "\" right action
            if col <= 3 && row >= 3{
                if board[col+1][row-1] == aiPiece && board[col+2][row-2] == aiPiece && board[col+3][row-3] == aiPiece{
                    returnValue += 600
                }
            }
            
            //for "\" semi-right action
            if col >= 1 && col <= 4 && row <= 4 && row >= 2{
                if board[col-1][row+1] == aiPiece && board[col+1][row-1] == aiPiece && board[col+2][row-2] == aiPiece{
                    returnValue += 600
                }
            }
            
            //for "\" semi-left action
            if col >= 2 && col <= 5 && row >= 1 && row <= 3{
                if board[col-1][row+1] == aiPiece && board[col-2][row+2] == aiPiece && board[col+1][row-1] == aiPiece{
                    returnValue += 600
                }
            }
            
            //for "/" right action
            if col <= 3 && row <= 2{
                if board[col+1][row+1] == aiPiece && board[col+2][row+2] == aiPiece && board[col+3][row+3] == aiPiece{
                    returnValue += 600
                }
            }
            
            //for "/" left action
            if col >= 3 && row >= 3{
                if board[col-1][row-1] == aiPiece && board[col-2][row-2] == aiPiece && board[col-3][row-3] == aiPiece{
                    returnValue += 600
                }
            }
            
            //for "/" semi-right action
            if col >= 1 && col <= 4 && row >= 1 && row <= 3{
                if board[col-1][row-1] == aiPiece && board[col+1][row+1] == aiPiece && board[col+2][row+2] == aiPiece{
                    returnValue += 600
                }
            }
            
            //for "/" semi-left action
            if col >= 2 && col <= 5 && row >= 2 && row <= 4{
                if board[col-1][row-1] == aiPiece && board[col-2][row-2] == aiPiece && board[col+1][row+1] == aiPiece{
                    returnValue += 600
                }
            }
            
            //for vertical action
            if row <= 5 && row >= 3{
                if board[col][row-1] == aiPiece && board[col][row-2] == aiPiece && board[col][row-3] == aiPiece{
                    returnValue += 600
                }
            }
        }
        
        
        
        
        for col in 0...6{
            for row in 0...5{
                if board[col][row] != 2 && board[col][row] != 1{
                    nextMove.append([col,row])
                    break
                }
            }
        }
        
        for index in nextMove{
            opponentTwoConnected(row: index[1], col: index[0])
            aiTwoConnected(row: index[1], col: index[0])
            opponentThreeConnected(row: index[1], col: index[0])
            aiPieceThreeConnected(row: index[1], col: index[0])
        }
        return returnValue
    }
    
    func isWin(board:Array<[Int]>) -> Bool{
        var con = true
        var ret = false
        
        //Vertical
        if con == true{
            for index in 0...3{
                for jndex in 0...5{
                    if board[index][jndex] == 1 && board[index+1][jndex] == 1 && board[index+2][jndex] == 1 && board[index+3][jndex] == 1{
                        ret = true
                        con = false
                        break
                    }else{
                        if board[index][jndex] == 2 && board[index+1][jndex] == 2 && board[index+2][jndex] == 2 && board[index+3][jndex] == 2{
                            ret = true
                            con = false
                            break
                        }
                    }
                }
            }
        }
        //Horizontal
        if con == true{
            for index in 0...6 {
                for jndex in 0...2{
                    if board[index][jndex] == 1 && board[index][jndex+1] == 1 && board[index][jndex+2] == 1 && board[index][jndex+3] == 1{
                        ret = true
                        con = false
                        break
                    }else{
                        if board[index][jndex] == 2 && board[index][jndex+1] == 2 && board[index][jndex+2] == 2 && board[index][jndex+3] == 2{
                            ret = true
                            con = false
                            break
                        }
                    }
                }
            }
        }
        // Diagonally "/"
        if con == true{
            for index in 0...3{
                for jndex in 0...2{
                    if board[index][jndex] == 1 && board[index+1][jndex+1] == 1 && board[index+2][jndex+2] == 1 && board[index+3][jndex+3] == 1{
                        ret = true
                        con = false
                        break
                    }else{
                        if board[index][jndex] == 2 && board[index+1][jndex+1] == 2 && board[index+2][jndex+2] == 2 && board[index+3][jndex+3] == 2{
                            ret = true
                            con = false
                            break
                        }
                    }
                }
            }
        }
        
        // Diagonally "\"
        if con == true{
            for index in 3...6{
                for jndex in 0...2{
                    if board[index][jndex] == 1 && board[index-1][jndex+1] == 1 && board[index-2][jndex+2] == 1 && board[index-3][jndex+3] == 1{
                        ret = true
                        con = false
                        break
                    }else{
                        if board[index][jndex] == 2 && board[index-1][jndex+1] == 2 && board[index-2][jndex+2] == 2 && board[index-3][jndex+3] == 2{
                            ret = true
                            con = false
                            break
                        }
                    }
                }
            }
        }
        
        return ret
    }
    
    //minimax algorithm
    func miniMax(board:Array<[Int]>,depth:Int,mini:Bool) -> Int{
        if isWin(board: board) == true{
            return getCurrentScore(board: board, opponent: 1)
        }else{
            if depth <= 0{
                return getCurrentScore(board: board, opponent: 1)
            }else{
                let nextMove = possibleMoves(board: board)
                var testBoardState = [Array<[Int]>]()
                for index in nextMove {
                    var newBoard = board
                    if mini == false{
                        newBoard = addPieceOnBoard(board: newBoard, column: index, piece:1)
                    }else{
                        if mini == true{
                            newBoard = addPieceOnBoard(board: newBoard, column: index, piece: 2)
                        }
                    }
                    testBoardState.append(newBoard)
                }
                var scoreOfBoard = [Int]()
                
                for index in testBoardState {
                    scoreOfBoard.append(miniMax(board: index, depth: depth-1, mini:!mini))
                }
                if mini == false{
                    return scoreOfBoard.max()!
                }else{
                    return scoreOfBoard.min()!
                }
            }
            
            
        }
    }



}

