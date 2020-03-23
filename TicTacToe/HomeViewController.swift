//
//  HomeViewController.swift
//  TicTacToe
//
//  Created by Ashutosh Dave on 05/03/20.
//  Copyright © 2020 Ashutosh Dave. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    
    @IBOutlet weak var playerOneTextField: UITextField!
    
    @IBOutlet weak var playerTwoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        let gameViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "TTTViewController") as! TTTViewController
        if let playerOneName = playerOneTextField.text {
            gameViewController.playerOneName = playerOneName
        } else {
            gameViewController.playerOneName = "Player 1"
        }
        
        if let playerTwoName = playerTwoTextField.text {
            gameViewController.playerTwoName = playerTwoName
        } else {
            gameViewController.playerTwoName = "Player 2"
        }
        self.navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
