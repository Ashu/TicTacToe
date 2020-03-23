//
//  TTTViewController.swift
//  TicTacToe
//
//  Created by Ashutosh Dave on 05/03/20.
//  Copyright © 2020 Ashutosh Dave. All rights reserved.
//

import UIKit

struct Player {
    var name = ""
    var playerId = 1
    var isTurn = false
    var didWon = false
    var positions: [Int] = []
}

class TTTViewController: UIViewController {

    private let spacing: CGFloat = 10
    
    let winningCombo = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    let gridItems = [0,1,2,3,4,5,6,7,8]
    
    var playerOneName: String = "Player 1"
    var playerTwoName: String = "Player 2"
    var cpuPlayer = Player()
    var playerOne = Player()
    
    @IBOutlet weak var tttCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 5
        flowLayout.sectionInset = .zero
        
        tttCollectionView.contentInset = .zero
        tttCollectionView.collectionViewLayout = flowLayout
        
        
        // Intial Setup for Players
        if self.playerTwoName.count != 0 {
            cpuPlayer.name = self.playerTwoName
        } else {
            cpuPlayer.name = "Player 2"
        }
        
        cpuPlayer.isTurn = false
        cpuPlayer.playerId = 2
        
        if self.playerTwoName.count != 0 {
           playerOne.name = self.playerOneName
       } else {
           playerOne.name = "Player 1"
       }
//        playerOne.name = self.playerOneName
        playerOne.isTurn = true
        playerOne.playerId = 1
    }
    

    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            print("reload collection View")
            self.dismiss(animated: true, completion: nil)
//            self.tttCollectionView.reloadData()
            self.navigationController?.popViewController(animated: true)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func convertToMatrix() {
        print(self.tttCollectionView.indexPathsForVisibleItems.map{ $0.row })
        
        print(self.tttCollectionView.visibleCells.map{ ($0 as! TTTCell).playerId })
    }
    
    func isWinning(array: [Int]) -> Bool {
        
        var count = Int()
        var didWin = false
        
        for i in 0 ..< winningCombo.count {
            count = 0
            for j in 0 ..< winningCombo[i].count {
                if array.contains(winningCombo[i][j]) {
                    count += 1
                }
                
                if count == 3 {
                    didWin = true
                    break
                }
            }
            if count == 3 {
                break
            }
        }
        return didWin
    }
}

extension TTTViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  gridItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TTTCell", for: indexPath) as! TTTCell
        cell.cellLabel.text = ""
        return cell
    }
}

extension TTTViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! TTTCell
        print("Selected IndexPath row: \(indexPath.row)")
        if cell.cellLabel.text == "" {
            if playerOne.isTurn {
                cell.cellLabel.text = "X"
                cell.playerId = playerOne.playerId
                playerOne.positions.append(indexPath.row)
                playerOne.isTurn = false
                cpuPlayer.isTurn = true
                
                if playerOne.positions.count > 2 {
                    if self.isWinning(array: playerOne.positions) {
                        self.showAlert(title: "\(playerOne.name) won the game!")
                    }
                }
            } else {
                cell.cellLabel.text = "O"
                cell.playerId = cpuPlayer.playerId
                cpuPlayer.positions.append(indexPath.row)
                playerOne.isTurn = true
                cpuPlayer.isTurn = false
                
                if cpuPlayer.positions.count > 2 {
                    if self.isWinning(array: cpuPlayer.positions) {
                        self.showAlert(title: "\(cpuPlayer.name) w2on the game!")
                    }
                }
            }
        }
        // Check Results
//        self.convertToMatrix()
        if  cpuPlayer.positions.count + playerOne.positions.count == 9{
                   self.showAlert(title: "Its a draw. Game Over!!")
               }
        
    }
}

extension TTTViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfItemsPerRow: CGFloat = 3
        
        let width = (collectionView.bounds.width - 10)/numberOfItemsPerRow
        
        let height = (collectionView.bounds.height - 10)/numberOfItemsPerRow
        
        return CGSize(width: width, height: height)
    }
}


