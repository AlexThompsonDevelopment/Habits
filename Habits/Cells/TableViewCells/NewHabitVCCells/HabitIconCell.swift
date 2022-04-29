//
//  IconCell.swift
//  Habits
//
//  Created by Alexander Thompson on 13/8/21.
//

import UIKit

protocol passIconData: AnyObject {
    func passIconData(iconString: String)
}

class HabitIconCell: UITableViewCell {
    
    //MARK: - Properties
    let generator      = UIImpactFeedbackGenerator(style: .medium)
    weak var delegate: passIconData?
    
    static let reuseID = "IconCell"
    let stackViewOne   = UIStackView()
    let stackViewTwo   = UIStackView()
    let stackViewThree = UIStackView()
    let stackViewFour  = UIStackView()
    
    var colors         = [CGColor]()
    
    var buttonArray: [GradientButton] = []
    
    //MARK: - Class Funcs
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func configure() {
        backgroundColor = BackgroundColors.secondaryBackground
        self.layer.cornerRadius = 10
        generator.prepare()
        let stackArray = [stackViewOne, stackViewTwo, stackViewThree, stackViewFour]
        
        for stack in stackArray {
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis         = .horizontal
            stack.distribution = .fillEqually
            stack.spacing      = 6
            
            for _ in 0...6 {
                let iconButton                = GradientButton()
                iconButton.imageEdgeInsets    = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
                iconButton.layer.cornerRadius = 10
                iconButton.tintColor          = .secondaryLabel
                iconButton.addTarget(self, action: #selector(iconButtonPressed), for: .touchUpInside)
                
                stack.addArrangedSubview(iconButton)
                buttonArray.append(iconButton)
            }
        }
        
        for count in 0...buttonArray.count - 1 {
            buttonArray[count].setImage(UIImage(named: icons.iconArray[count]), for: .normal)
        }
    }
    
    
    private func layoutUI() {
        contentView.addSubviews(stackViewOne, stackViewTwo, stackViewThree, stackViewFour)
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            stackViewOne.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            stackViewOne.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackViewOne.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackViewOne.bottomAnchor.constraint(equalTo: stackViewTwo.topAnchor, constant: -padding),
            stackViewOne.heightAnchor.constraint(equalToConstant: 40),
            
            stackViewTwo.topAnchor.constraint(equalTo: stackViewOne.bottomAnchor, constant: padding),
            stackViewTwo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackViewTwo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackViewTwo.bottomAnchor.constraint(equalTo: stackViewThree.topAnchor, constant: -padding),
            stackViewTwo.heightAnchor.constraint(equalToConstant: 40),
            
            stackViewThree.topAnchor.constraint(equalTo: stackViewTwo.bottomAnchor, constant: padding),
            stackViewThree.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackViewThree.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackViewThree.bottomAnchor.constraint(equalTo: stackViewFour.topAnchor, constant: -padding),
            stackViewThree.heightAnchor.constraint(equalToConstant: 40),
            
            stackViewFour.topAnchor.constraint(equalTo: stackViewThree.bottomAnchor, constant: padding),
            stackViewFour.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackViewFour.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackViewFour.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            stackViewFour.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // TODO: move funcs out of cell
    @objc func iconButtonPressed(_ sender: GradientButton) {
        sender.bounceAnimation()
        generator.impactOccurred()
        for item in buttonArray {
            item.tintColor  = .secondaryLabel
            item.isSelected = false
            item.colors     = GradientColors.clearGradient
        }
        
        sender.tintColor  = .white
        sender.colors     = Gradients().darkBlueGradient
        sender.isSelected = true
        
        for (index,item) in buttonArray.enumerated() {
            if item.isSelected == true {
                delegate?.passIconData(iconString: icons.iconArray[index])
            }
        }
    }
}
