//
//  ViewController.swift
//  TicTacToe
//
//  Created by Nguyễn Tuấn Dũng on 03/03/2024.
//

import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case Cross
        case Nought
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    @IBOutlet weak var Xwin: UILabel!
    @IBOutlet weak var drawXO: UILabel!
    @IBOutlet weak var Owin: UILabel!
    
    var CROSS = "X"
    var NOUGHT = "O"
    
    var crossScore = 0
    var noughtScore = 0
    var drawScore = 0
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var board = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }
    
    func initBoard() {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }
    
    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        if checkVictory(CROSS){
            crossScore += 1
            Xwin.text = "X win \(crossScore)"
            drawXO.text = "Draw \(drawScore)"
            Owin.text = "O win \(noughtScore)"
            resultAlert(title: "Cross win!")
        } else if checkVictory(NOUGHT) {
            noughtScore += 1
            Xwin.text = "X win \(crossScore)"
            drawXO.text = "Draw \(drawScore)"
            Owin.text = "O win \(noughtScore)"
            resultAlert(title: "Nought win!")
        } else if fullBoard() {
            drawScore += 1
            Xwin.text = "X win \(crossScore)"
            drawXO.text = "Draw \(drawScore)"
            Owin.text = "O win \(noughtScore)"
            resultAlert(title: "Draw")
        }
    }
    
    func checkVictory(_ s: String) -> Bool {
        //horizontal
        if thisSymBol(a1, s) && thisSymBol(a2, s) && thisSymBol(a3, s) {
            return true
        }
        if thisSymBol(b1, s) && thisSymBol(b2, s) && thisSymBol(b3, s) {
            return true
        }
        if thisSymBol(c1, s) && thisSymBol(c2, s) && thisSymBol(c3, s) {
            return true
        }
        //vertical
        if thisSymBol(a1, s) && thisSymBol(b1, s) && thisSymBol(c1, s) {
            return true
        }
        if thisSymBol(a2, s) && thisSymBol(b2, s) && thisSymBol(c2, s) {
            return true
        }
        if thisSymBol(a3, s) && thisSymBol(b3, s) && thisSymBol(c3, s) {
            return true
        }
        // diagonal
        if thisSymBol(a1, s) && thisSymBol(b2, s) && thisSymBol(c3, s) {
            return true
        }
        if thisSymBol(a3, s) && thisSymBol(b2, s) && thisSymBol(c1, s) {
            return true
        }
        return false
    }
    
    func thisSymBol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String) {
        let message = "\nCross " + String(crossScore) + "\nDraw " + String(drawScore) + "\nNought " + String(noughtScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: { (_) in
            self.resetBoard()
        }))
        present(ac, animated: true, completion: nil)
    }
    
    func resetBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Cross {
            firstTurn = Turn.Nought
            turnLabel.text = NOUGHT
            turnLabel.textColor = .blue
        } else if firstTurn == Turn.Nought {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
            turnLabel.textColor = .red
        }
        currentTurn = firstTurn
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton) {
        if sender.title(for: .normal) == nil {
            if currentTurn == Turn.Cross {
                sender.setTitle(CROSS, for: .normal)
                sender.setTitleColor(.red, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
                turnLabel.textColor = .blue
            } else if currentTurn == Turn.Nought {
                sender.setTitle(NOUGHT, for: .normal)
                sender.setTitleColor(.blue, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
                turnLabel.textColor = .red
            }
            sender.isEnabled = false
        }
    }
    
    @IBAction func didTapPlayAgainButton(_ sender: UIButton) {
        showPlayAgainAlert()
    }
    
    private func showPlayAgainAlert() {
        let ac = UIAlertController(
            title: "Thông báo",
            message: "Bạn có chắc chắn muốn chơi lại không?",
            preferredStyle: .alert
        )
        
        ac.addAction(UIAlertAction(title: "Không", style: .cancel))
        ac.addAction(UIAlertAction(title: "Có", style: .destructive) { [weak self] _ in
            self?.resetGameState()
        })
        
        present(ac, animated: true)
    }

    private func resetGameState() {
        // Reset turn state
        turnLabel.text = CROSS
        turnLabel.textColor = .red
        firstTurn = Turn.Cross
        currentTurn = Turn.Cross
        
        // Reset board
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        
        // Reset scores
        crossScore = 0
        drawScore = 0
        noughtScore = 0
        
        // Update score labels
        updateScoreLabels()
    }

    private func updateScoreLabels() {
        Xwin.text = "X Win \(crossScore)"
        drawXO.text = "Draw \(drawScore)"
        Owin.text = "O Win \(noughtScore)"
    }
    
}

