//
//  HabitTextField.swift
//  Habits
//
//  Created by Alexander Thompson on 28/4/21.
//

import UIKit

class HabitTextField: UITextField {
    
    //MARK: - Class Funcs
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor                 = .label
        tintColor                 = .label
        textAlignment             = .left
        font                      = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize           = 12
        layer.cornerRadius        = 10
        backgroundColor           = .secondarySystemBackground
        autocorrectionType        = .no
        returnKeyType             = .done
        clearButtonMode           = .whileEditing
    }
    
    
}
