//
//  FlightCollectionViewCell.swift
//  TimeToTravel
//
//  Created by Александр Востриков on 31.05.2022.
//

import UIKit

final class FlightCollectionViewCell: UICollectionViewCell {
    
    //MARK: - vars
    private let startCity: UILabel = {
        let label = UILabel()
        return label
    }()
    private let endCity: UILabel = {
        let label = UILabel()
        return label
    }()
    private let startDate: UILabel = {
        let label = UILabel()
        return label
    }()
    private let endDate: UILabel = {
        let label = UILabel()
        return label
    }()
    private let price: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var like: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "hand.thumbsup.fill")
        button.setBackgroundImage(image, for: .normal)
        return button
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "ColorCell")
        self.addSubviews(to: startCity, endCity, startDate, endDate, price, like)
        configureConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - func
    func configureCell(flight: Flight){
        startCity.text = flight.startCity
        endCity.text = flight.endCity
        startDate.text = flight.startDate
        endDate.text = flight.endDate
        like.tintColor = .gray
    }
    
    private func configureConstrains(){
        NSLayoutConstraint.activate([
            startCity.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            startCity.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            startCity.trailingAnchor.constraint(greaterThanOrEqualTo: endCity.leadingAnchor, constant: 10),
            startCity.bottomAnchor.constraint(equalTo: startDate.topAnchor, constant: 10),
            
            endCity.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            endCity.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            endCity.bottomAnchor.constraint(equalTo: endDate.topAnchor, constant: 10),
            
            startDate.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            startDate.trailingAnchor.constraint(greaterThanOrEqualTo: endDate.leadingAnchor, constant: 10),
            startDate.bottomAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 30),
            
            endDate.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            endDate.bottomAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 30),
            
            like.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            like.topAnchor.constraint(equalTo: startDate.bottomAnchor, constant: 10),
            like.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            like.heightAnchor.constraint(equalToConstant: 30),
            like.widthAnchor.constraint(equalTo: like.heightAnchor)
        ])
    }
}
