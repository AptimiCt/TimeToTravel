//
//  UIView+Ext.swift
//  TimeToTravel
//
//  Created by Александр Востриков on 01.06.2022.
//

import UIKit

extension UIView {
    func addSubviews(to subviews: UIView...){
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0) }
    }
    
    func addArrangedSubviews(to subviews: UIView...){
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0) }
    }
}
