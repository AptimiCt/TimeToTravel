//
//  FlightCollectionViewCell.swift
//  TimeToTravel
//
//  Created by Александр Востриков on 31.05.2022.
//

import UIKit

protocol FlightCollectionViewCellDelegate: AnyObject{
    func reloadCell(index: IndexPath)
}

final class FlightCollectionViewCell: UICollectionViewCell {
    
    //MARK: - vars
    var indexPath: IndexPath?
    weak var delegate: FlightCollectionViewCellDelegate?
    private var searchToken: String?
    private let imageStartCity: UIImageView = {
        let image = UIImage(systemName: Constants.airplaneDeparture)
        let imageView = UIImageView(image: image)
        return imageView
    }()
    private let startCity: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.proximaNovaSemibold, size: 17)
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
        label.font = UIFont(name: Constants.proximaNovaSemibold, size: 17)
        label.textColor = UIColor(named: Constants.darkViolet)
        return label
    }()
    private let departureDateLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.departureDate
        label.font = UIFont(name: Constants.proximaNovaRegular, size: 15)
        label.textColor = UIColor(named: Constants.darkViolet)
        return label
    }()
    private let startDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.proximaNovaRegular, size: 14)
        label.textColor = UIColor(named: Constants.darkViolet)
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let returnDateLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.returnDate
        label.font = UIFont(name: Constants.proximaNovaRegular, size: 15)
        label.textColor = UIColor(named: Constants.darkViolet)
        return label
    }()
    private let endDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.proximaNovaRegular, size: 14)
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
        label.font = UIFont(name: Constants.proximaNovaSemibold, size: 20)
        label.textColor = UIColor(named: Constants.colorPrice)
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: Constants.colorCell)
        startPoint.addArrangedSubviews(to: imageStartCity, startCity, departureDateLabel, startDate)
        endPoint.addArrangedSubviews(to: imageEndCity, endCity, returnDateLabel, endDate)
        self.addSubviews(to: startPoint, endPoint, price, like)
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
        startDate.text = convertDate(flight.startDate)
        endDate.text = convertDate(flight.endDate)
        price.text = "\(flight.price) РУБ"
        searchToken = flight.searchToken
        guard let searchToken = searchToken else { return }
        let tapedLike = UserDefaults.standard.bool(forKey: searchToken)
        like.tintColor = tapedLike ? .yellow : .gray
    }
    func setIndexPath(indexPath: IndexPath){
        self.indexPath = indexPath
    }
    //MARK: - @objc private func
    @objc
    private func tappedLike(){
        let userDefaults = UserDefaults.standard
        guard let searchToken = searchToken else { return }
        var tapedLike = UserDefaults.standard.bool(forKey: searchToken)
        tapedLike.toggle()
        userDefaults.set(tapedLike, forKey: searchToken)
        guard let indexPath = indexPath else {
            return
        }
        delegate?.reloadCell(index: indexPath)
    }
    //MARK: - private func
    private func convertDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        guard let data = dateFormatter.date(from: dateString) else { return String(describing: Date.now) }
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: data)
    }
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
            
            like.centerXAnchor.constraint(equalTo: endPoint.centerXAnchor),
            like.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            like.heightAnchor.constraint(equalToConstant: 30),
            like.widthAnchor.constraint(equalTo: like.heightAnchor),
            
            price.centerXAnchor.constraint(equalTo: startPoint.centerXAnchor),
            price.centerYAnchor.constraint(equalTo: like.centerYAnchor),
            price.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5),
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
