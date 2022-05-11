////
//  ViewController.swift
//  AutoLayoutStarter
//
//  Created by Derrick Park on 2019-04-17.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let mainView: UIView = {
    let main = UIView()
    // important when setting contraints programmatically
    main.translatesAutoresizingMaskIntoConstraints = false
    main.backgroundColor = .green
    return main
  }()
  
  let squareButton: UIButton = {
    let butt = UIButton(type: .system)
    butt.setTitle("Square", for: .normal)
    butt.translatesAutoresizingMaskIntoConstraints = false
    butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    butt.addTarget(self, action: #selector(squareTapped), for: .touchUpInside)
    return butt
  }()
  
  let portraitButton: UIButton = {
    let butt = UIButton(type: .system)
    butt.setTitle("Portrait", for: .normal)
    butt.translatesAutoresizingMaskIntoConstraints = false
    butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    butt.addTarget(self, action: #selector(portraitTapped), for: .touchUpInside)
    return butt
  }()
  
  let landScapeButton: UIButton = {
    let butt = UIButton(type: .system)
    butt.setTitle("Landscape", for: .normal)
    butt.translatesAutoresizingMaskIntoConstraints = false
    butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    butt.addTarget(self, action: #selector(landscapeTapped), for: .touchUpInside)
    return butt
  }()
    
  lazy var boxOrangeRight :UIView = createBoxElement(filledBy: .orange)
  lazy var boxOrangeLeft :UIView = createBoxElement(filledBy: .orange)
  lazy var boxRed :UIView = createBoxElement(filledBy: .red)
  lazy var boxPurple: UIView = createBoxElement(filledBy: .purple)
  lazy var boxesBlue: [UIView] = {
        var boxes: [UIView] = []
        for _ in 0...3{
            boxes.append(createBoxElement(filledBy: .blue))
        }
        return boxes
    }()
    
  var blueBoxesStackView = UIStackView()
    
    
  var widthAnchor: NSLayoutConstraint?
  var heightAnchor: NSLayoutConstraint?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(mainView)
    setupLayout()
  }

  fileprivate func setupLayout() {
    mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    widthAnchor = mainView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7, constant: 0)
    widthAnchor?.isActive = true
    
    heightAnchor = mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7, constant: 0)
    heightAnchor?.isActive = true
    
    let buttStackView = UIStackView(arrangedSubviews: [
      squareButton, portraitButton, landScapeButton])
    buttStackView.translatesAutoresizingMaskIntoConstraints = false
    buttStackView.axis = .horizontal
    buttStackView.alignment = .center
    buttStackView.distribution = .fillEqually
    
    view.addSubview(buttStackView)
    NSLayoutConstraint.activate([
      buttStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      buttStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttStackView.heightAnchor.constraint(equalToConstant: 50),
      buttStackView.widthAnchor.constraint(equalTo: view.widthAnchor)
      ])
      
      blueBoxesStackView = UIStackView(arrangedSubviews: [boxesBlue[0], boxesBlue[1], boxesBlue[2]])
      blueBoxesStackView.translatesAutoresizingMaskIntoConstraints = false
      blueBoxesStackView.axis = .vertical
      buttStackView.alignment = .center
      blueBoxesStackView.distribution = .equalSpacing
      
      view.addSubview(blueBoxesStackView)
      NSLayoutConstraint.activate([
        blueBoxesStackView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        blueBoxesStackView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
        blueBoxesStackView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.7)
      ])
      for box in boxesBlue{
          box.heightAnchor.constraint(equalToConstant: 65).isActive = true
          box.widthAnchor.constraint(equalToConstant: 65).isActive = true
      }
      
      
     view.addSubview(boxRed)
     NSLayoutConstraint.activate([
         boxRed.widthAnchor.constraint(equalToConstant: 150),
         boxRed.heightAnchor.constraint(equalToConstant: 55),
         boxRed.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 15),
         boxRed.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -15)
     ])
    
      view.addSubview(boxOrangeLeft)
      NSLayoutConstraint.activate([
        boxOrangeLeft.widthAnchor.constraint(equalTo: boxRed.widthAnchor, multiplier: 0.5),
        boxOrangeLeft.heightAnchor.constraint(equalToConstant: 35),
        boxOrangeLeft.topAnchor.constraint(equalTo: boxRed.topAnchor, constant: 10),
        boxOrangeLeft.leadingAnchor.constraint(equalTo: boxRed.leadingAnchor, constant: 10)
      ])
      view.addSubview(boxOrangeRight)
      NSLayoutConstraint.activate([
        boxOrangeRight.widthAnchor.constraint(equalTo: boxRed.widthAnchor, multiplier: 0.3),
        boxOrangeRight.heightAnchor.constraint(equalToConstant: 35),
        boxOrangeRight.topAnchor.constraint(equalTo: boxRed.topAnchor, constant: 10),
        boxOrangeRight.trailingAnchor.constraint(equalTo: boxRed.trailingAnchor, constant: -10)
      ])
     
      view.addSubview(boxPurple)
      NSLayoutConstraint.activate([
        boxPurple.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -15),
        boxPurple.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -15),
        boxPurple.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.7, constant: 0),
        boxPurple.heightAnchor.constraint(equalToConstant: 50)
      ])

  }
    
    func createBoxElement(filledBy backgroundColor: UIColor)->UIView{
        let box = UIView()
        box.translatesAutoresizingMaskIntoConstraints = false
        box.backgroundColor = backgroundColor
        return box
    }

  @objc private func squareTapped() {
    view.layoutIfNeeded()
    UIView.animate(withDuration: 2.0) {
      self.widthAnchor?.isActive = false
      self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
      self.widthAnchor?.isActive = true

      self.heightAnchor?.isActive = false
      self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
      self.heightAnchor?.isActive = true
      
      
      self.view.layoutIfNeeded()
        
        self.boxPurple.widthAnchor.constraint(equalTo: self.mainView.widthAnchor,multiplier: 0.7).isActive = true
        self.blueBoxesStackView.heightAnchor.constraint(equalTo: self.mainView.heightAnchor, multiplier: 0.7).isActive = true
    }
  }
  
  @objc private func portraitTapped() {
    view.layoutIfNeeded()
    UIView.animate(withDuration: 2.0) {
      self.widthAnchor?.isActive = false
      self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7)
      self.widthAnchor?.isActive = true
        
      self.heightAnchor?.isActive = false
      self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7)
      self.heightAnchor?.isActive = true
      self.view.layoutIfNeeded()
        
      self.boxPurple.widthAnchor.constraint(equalTo: self.mainView.widthAnchor,multiplier: 0.7).isActive = true
      self.blueBoxesStackView.heightAnchor.constraint(equalTo: self.mainView.heightAnchor, multiplier: 0.7).isActive = true
    }
    
  }
  
  @objc private func landscapeTapped() {
    view.layoutIfNeeded()
    UIView.animate(withDuration: 2.0) {
      self.widthAnchor?.isActive = false
      self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95)
      self.widthAnchor?.isActive = true
      self.heightAnchor?.isActive = false
      self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
      self.heightAnchor?.isActive = true
      self.view.layoutIfNeeded()
        
      self.boxPurple.widthAnchor.constraint(equalTo: self.mainView.widthAnchor,multiplier: 0.7).isActive = true
      self.blueBoxesStackView.heightAnchor.constraint(equalTo: self.mainView.heightAnchor, multiplier: 0.7).isActive = true
    }
  }
}

