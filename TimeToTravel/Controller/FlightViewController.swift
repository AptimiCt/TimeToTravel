//
//  FlightViewController.swift
//  TimeToTravel
//
//  Created by Александр Востриков on 31.05.2022.
//

import UIKit

final class FlightViewController: UIViewController {
    
    private var jsonData = [Flight]()
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonData = Storage().fetchData()
        configureView()
        collectionView.register(FlightCollectionViewCell.self, forCellWithReuseIdentifier: "FlightCollectionViewCell")
        setupDelegate()
    }
    
    private func configureView(){
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension FlightViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlightCollectionViewCell", for: indexPath) as? FlightCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(flight: jsonData[0])
        cell.layer.cornerRadius = 15
        return cell
    }
}

extension FlightViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Constants.screenWeight - 16
        return CGSize(width: width, height: width / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}


extension FlightViewController {
    func setupDelegate(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}
