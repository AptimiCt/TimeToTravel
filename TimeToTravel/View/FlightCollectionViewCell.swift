//
//  FlightCollectionViewCell.swift
//  TimeToTravel
//
//  Created by Александр Востриков on 31.05.2022.
//

import UIKit

final class FlightCollectionViewCell: UICollectionViewCell {
    
    //MARK: - vars
    private let imageStartCity: UIImageView = {
        let image = UIImage(systemName: "airplane.departure")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    private let startCity: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let imageEndCity: UIImageView = {
        let image = UIImage(systemName: "airplane.arrival")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    private let endCity: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let departureDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата отправления:"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    private let startDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let returnDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата возвращения:"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    private let endDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var like: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "hand.thumbsup.fill")
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(tappedLike), for: .touchUpInside)
        return button
    }()
    private lazy var startPoint: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    private lazy var endPoint: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "ColorCell")
        startPoint.addArrangedSubviews(to: imageStartCity, startCity, departureDateLabel, startDate)
        endPoint.addArrangedSubviews(to: imageEndCity, endCity, returnDateLabel, endDate)
        self.addSubviews(to: startPoint, endPoint, like)
        configureConstrainsViews()
        configureStartPoint()
        configureEndPoint()
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
    //MARK: - @objc private func
    @objc
    private func tappedLike(){
        print("test")
    }
    //MARK: - private func
    private func configureConstrainsViews(){
        NSLayoutConstraint.activate([
            startPoint.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            startPoint.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            startPoint.trailingAnchor.constraint(equalTo: endPoint.leadingAnchor),
            startPoint.bottomAnchor.constraint(equalTo: like.topAnchor, constant: -10),
            startPoint.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5, constant: -10),
            
            endPoint.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            endPoint.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            endPoint.bottomAnchor.constraint(equalTo: like.topAnchor, constant: -10),
            endPoint.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5, constant: -10),
            
            like.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            like.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            like.heightAnchor.constraint(equalToConstant: 30),
            like.widthAnchor.constraint(equalTo: like.heightAnchor)
        ])
    }
    private func configureStartPoint(){
        NSLayoutConstraint.activate([

            imageStartCity.leadingAnchor.constraint(equalTo: startPoint.leadingAnchor),
            imageStartCity.topAnchor.constraint(equalTo: startPoint.topAnchor),
            imageStartCity.bottomAnchor.constraint(equalTo: startCity.topAnchor),
            imageStartCity.heightAnchor.constraint(equalToConstant: Constants.screenWeight / 20),
            
            startCity.leadingAnchor.constraint(equalTo: startPoint.leadingAnchor),
            startCity.bottomAnchor.constraint(greaterThanOrEqualTo: departureDateLabel.topAnchor, constant: -5),
            
            departureDateLabel.leadingAnchor.constraint(equalTo: startPoint.leadingAnchor),
            departureDateLabel.trailingAnchor.constraint(equalTo: startPoint.trailingAnchor),
            departureDateLabel.bottomAnchor.constraint(equalTo: startDate.topAnchor),
            
            startDate.leadingAnchor.constraint(equalTo: startPoint.leadingAnchor),
            startDate.trailingAnchor.constraint(equalTo: startPoint.trailingAnchor, constant: -5),
            startDate.bottomAnchor.constraint(equalTo: startPoint.bottomAnchor)
        ])
    }
    private func configureEndPoint(){
        NSLayoutConstraint.activate([
            imageEndCity.leadingAnchor.constraint(equalTo: endPoint.leadingAnchor),
            imageEndCity.topAnchor.constraint(equalTo: endPoint.topAnchor),
            imageEndCity.bottomAnchor.constraint(equalTo: endCity.topAnchor),
            imageEndCity.heightAnchor.constraint(equalToConstant: Constants.screenWeight / 20),
            
            endCity.leadingAnchor.constraint(equalTo: endPoint.leadingAnchor),
            endCity.bottomAnchor.constraint(equalTo: returnDateLabel.topAnchor, constant: -5),
            
            returnDateLabel.leadingAnchor.constraint(equalTo: endPoint.leadingAnchor),
            returnDateLabel.trailingAnchor.constraint(equalTo: endPoint.trailingAnchor),
            returnDateLabel.bottomAnchor.constraint(equalTo: endDate.topAnchor),
            
            endDate.leadingAnchor.constraint(equalTo: endPoint.leadingAnchor),
            endDate.trailingAnchor.constraint(equalTo: endPoint.trailingAnchor, constant: -5),
            endDate.bottomAnchor.constraint(equalTo: endPoint.bottomAnchor)
        ])
    }
}
