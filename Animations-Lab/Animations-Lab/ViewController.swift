//
//  ViewController.swift
//  AnimationsPractice
//
//  Created by Benjamin Stone on 10/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //TODO: This App cannot Stop the blue Square
    //TODO: The buttons constraints are off and I would like to use Images instead of square.
    lazy var blueSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var buttonStackView: UIStackView = {
       let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 30 //WHy is this being overrided
        return buttonStack
    }()
    
    
    lazy var upButton: UIButton = {
       let button = UIButton()
        button.setTitle(" Up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareUp(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var downButton: UIButton = {
       let button = UIButton()
        button.setTitle("Down", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareDown(sender:)), for: .touchUpInside)
        return button
    }()
  
    lazy var rightButton: UIButton = {
        let button = UIButton()
              button.setTitle("->", for: .normal)
              button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
              button.addTarget(self, action: #selector(animateSquareRight(sender:)), for: .touchUpInside)
              return button
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("<-", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(animateSquareLeft(sender:)), for: .touchUpInside )
        return button
    }()
    
    lazy var blueSquareHeightConstaint: NSLayoutConstraint = {
        blueSquare.heightAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareWidthConstraint: NSLayoutConstraint = {
        blueSquare.widthAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareCenterXConstraint: NSLayoutConstraint = {
        blueSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    }()
    
    lazy var blueSquareCenterYConstraint: NSLayoutConstraint = {
        blueSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureNavBar()
    }
    
    @IBAction func animateSquareUp(sender: UIButton) {
        let oldOffset = blueSquareCenterYConstraint.constant
        //negative will make the square up
        //but the Y centerConstraint makes it go UP OR DOWN
        blueSquareCenterYConstraint.constant = oldOffset - 150
        //TODO: WHat is unowned self?
        UIView.animate(withDuration: 2) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func animateSquareDown(sender: UIButton) {
        let oldOffset = blueSquareCenterYConstraint.constant
        //This is going down because +150 goes only down
        blueSquareCenterYConstraint.constant = oldOffset + 150
        UIView.animate(withDuration: 2) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func animateSquareRight(sender: UIButton) {
        let oldOffset = blueSquareCenterXConstraint.constant
        //positive will make it go right
        //but center X Constrain will make it go RIGHT OR LEFT
        blueSquareCenterXConstraint.constant = oldOffset + 40
        UIView.animate(withDuration: 2) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func animateSquareLeft(sender: UIButton) {
        let oldOffSet = blueSquareCenterXConstraint.constant
        //This is going left because -40 will go ONLY LEFT
        blueSquareCenterXConstraint.constant = oldOffSet - 40
        UIView.animate(withDuration: 2) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    private func addSubviews() {
        view.addSubview(blueSquare)
        addStackViewSubviews()
        view.addSubview(buttonStackView)
    }
    
    private func addStackViewSubviews() {
     
         buttonStackView.addSubview(rightButton)
        buttonStackView.addSubview(upButton)
        buttonStackView.addSubview(leftButton)
        buttonStackView.addSubview(downButton)
        
    }
    
    private func configureConstraints() {
         constrainLeftButton()
        constrainBlueSquare()
        constrainUpButton()
        constrainDownButton()
      constrainRightButton()
        constrainButtonStackView()
    }
    
    
    private func configureNavBar() {
        // set title navigation bar NavigationItem is part of MainViewController and is the root for everything in the navigation bar
        navigationItem.title = "Animation UI"
        //adding UIBarButtonItem to the navigation bar you can add more than one or an array of barButtonItems. target is where the item is and the ACTION is what it is doing and the selector is the function to look for
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(showSettings(_:)))
 
    }
    
    
    @objc
      private func showSettings(_ sender: UIBarButtonItem) {
      //segue to the SettingsViewController  SO you need a navigation Controller embedded to the initial ViewController
          let settingsVC = SettingsViewController()
          //i create an instance of the 2nd ViewController and it is embedded into a navigation controller and its an optional cause it may not be embedded to the view controller but if you are you can pushViewController and allows us to have the navigation controls such as the back button etc
          //you can do different styles like below
          //present(settingsVC, animated: true)
          //settingsVC. modalPresentationStyle = .overCurrentContext
          //settingsVC.modalTransitionStyle = .flipHorizontal
          navigationController?.pushViewController(settingsVC, animated: true)
      }
    
       //TODO:Is there a push and pop in the stack view?? Is there a way to space it??
    private func constrainRightButton() {
           rightButton.translatesAutoresizingMaskIntoConstraints = false
           rightButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        rightButton.trailingAnchor.constraint(equalTo: upButton.leadingAnchor).isActive = true
        
       }
    
    private func constrainUpButton() {
        upButton.translatesAutoresizingMaskIntoConstraints = false
        //the height of the button
        upButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        upButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor).isActive = true
    }
    
    private func constrainDownButton() {
        downButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func constrainLeftButton() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        leftButton.leadingAnchor.constraint(equalTo: downButton.trailingAnchor).isActive = true
    }
    
    private func constrainBlueSquare() {
        blueSquare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blueSquareHeightConstaint,
            blueSquareWidthConstraint,
            blueSquareCenterXConstraint,
            blueSquareCenterYConstraint
        ])
    }
    
    private func constrainButtonStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
}


