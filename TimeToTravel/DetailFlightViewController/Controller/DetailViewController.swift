//
//  DetailViewController.swift
//  TimeToTravel
//
//  Created by Александр Востриков on 06.06.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - vars
    private var searchToken: String?
    private let imageStartCity: UIImageView = {
        let image = UIImage(systemName: Constants.airplaneDeparture)
        let imageView = UIImageView(image: image)
        return imageView
    }()
    private let startCity: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.proximaNovaSemibold, size: 22)
        label.textColor = UIColor(named: Constants.darkViolet)
        return label
    }()
    private let imageEndCity: UIImageView = {
        let image = UIImage(systemName: Constants.airplaneArrival)
        let imageView = UIImageView(image: image)
        return imageView
    }()
    private let endCity: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.proximaNovaSemibold, size: 22)
        label.textColor = UIColor(named: Constants.darkViolet)
        return label
    }()
    private let departureDateLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.departureDate
        label.font = UIFont(name: Constants.proximaNovaRegular, size: 17)
        label.textColor = UIColor(named: Constants.darkViolet)
        return label
    }()
    private let startDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.proximaNovaRegular, size: 15)
        label.textColor = UIColor(named: Constants.darkViolet)
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let returnDateLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.returnDate
        label.font = UIFont(name: Constants.proximaNovaRegular, size: 17)
        label.textColor = UIColor(named: Constants.darkViolet)
        return label
    }()
    private let endDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.proximaNovaRegular, size: 15)
        label.textColor = UIColor(named: Constants.darkViolet)
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var like: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: Constants.handThumbsupFill)
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
    private let price: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.proximaNovaSemibold, size: 22)
        label.textColor = UIColor(named: Constants.colorPrice)
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let repeatImage: UIImageView = {
        let image = UIImage(systemName: Constants.repeatImage)
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor(named: Constants.colorCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startPoint.addArrangedSubviews(to: imageStartCity, startCity, departureDateLabel, startDate)
        endPoint.addArrangedSubviews(to: imageEndCity, endCity, returnDateLabel, endDate)
        view.addSubviews(to: repeatImage, price, startPoint, endPoint, like)
        configureConstrainsViews()
        configureStartPoint()
        configureEndPoint()
        configureRepeatImage()
    }
    
    func configureView(flight: Flight){
        startCity.text = flight.startCity
        endCity.text = flight.endCity
        startDate.text = flight.startDate
        endDate.text = flight.endDate
        price.text = "\(flight.price) РУБ"
        searchToken = flight.searchToken
        guard let searchToken = searchToken else { return }
        let tapedLike = UserDefaults.standard.bool(forKey: searchToken)
        like.tintColor = tapedLike ? .yellow : .gray

    }
    //MARK: - @objc private func
    @objc
    private func tappedLike(){
            let userDefaults = UserDefaults.standard
            guard let searchToken = searchToken else { return }
            var tapedLike = UserDefaults.standard.bool(forKey: searchToken)
            tapedLike.toggle()
            userDefaults.set(tapedLike, forKey: searchToken)
            like.tintColor = tapedLike ? .yellow : .gray
    }

    //MARK: - private func
    private func configureConstrainsViews(){
        NSLayoutConstraint.activate([
            startPoint.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            startPoint.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            startPoint.heightAnchor.constraint(equalToConstant: Constants.screenWeight / 4),
            startPoint.bottomAnchor.constraint(equalTo: repeatImage.topAnchor),
            
            endPoint.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            endPoint.topAnchor.constraint(equalTo: repeatImage.bottomAnchor, constant: 10),
            endPoint.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            endPoint.heightAnchor.constraint(equalToConstant: Constants.screenWeight / 4),
            endPoint.bottomAnchor.constraint(equalTo: like.topAnchor, constant: -Constants.screenWeight / 8),
            
            like.centerXAnchor.constraint(equalTo: repeatImage.centerXAnchor),
            like.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            like.heightAnchor.constraint(equalToConstant: 30),
            like.widthAnchor.constraint(equalTo: like.heightAnchor),
            
            price.leadingAnchor.constraint(equalTo: repeatImage.leadingAnchor, constant: Constants.screenWeight / 4),
            price.centerYAnchor.constraint(equalTo: repeatImage.centerYAnchor, constant: -10),
            price.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
        ])
    }
    private func configureStartPoint(){
        NSLayoutConstraint.activate([
            imageStartCity.centerXAnchor.constraint(equalTo: startPoint.centerXAnchor),
            imageStartCity.bottomAnchor.constraint(equalTo: startCity.topAnchor),
            imageStartCity.heightAnchor.constraint(equalToConstant: Constants.screenWeight / 20),
            
            startCity.centerXAnchor.constraint(equalTo: startPoint.centerXAnchor),
            startCity.bottomAnchor.constraint(greaterThanOrEqualTo: departureDateLabel.topAnchor, constant: -5),
            
            departureDateLabel.centerXAnchor.constraint(equalTo: startPoint.centerXAnchor),
            departureDateLabel.bottomAnchor.constraint(equalTo: startDate.topAnchor),
            
            startDate.centerXAnchor.constraint(equalTo: startPoint.centerXAnchor),
            startDate.bottomAnchor.constraint(equalTo: startPoint.bottomAnchor)
        ])
    }
    private func configureEndPoint(){
        NSLayoutConstraint.activate([
            imageEndCity.centerXAnchor.constraint(equalTo: endPoint.centerXAnchor),
            imageEndCity.bottomAnchor.constraint(equalTo: endCity.topAnchor),
            imageEndCity.heightAnchor.constraint(equalToConstant: Constants.screenWeight / 20),
            
            endCity.centerXAnchor.constraint(equalTo: endPoint.centerXAnchor),
            endCity.bottomAnchor.constraint(equalTo: returnDateLabel.topAnchor, constant: -5),
            
            returnDateLabel.centerXAnchor.constraint(equalTo: endPoint.centerXAnchor),
            returnDateLabel.bottomAnchor.constraint(equalTo: endDate.topAnchor),
            
            endDate.centerXAnchor.constraint(equalTo: endPoint.centerXAnchor),
            endDate.bottomAnchor.constraint(equalTo: endPoint.bottomAnchor)
        ])
    }
    private func configureRepeatImage(){
        NSLayoutConstraint.activate([
            repeatImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            repeatImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            repeatImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            repeatImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            repeatImage.heightAnchor.constraint(equalToConstant: Constants.screenWeight / 2)
        ])
    }

}
