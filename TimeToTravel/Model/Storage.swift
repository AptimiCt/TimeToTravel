//
//  Storage.swift
//  TimeToTravel
//
//  Created by Александр Востриков on 31.05.2022.
//

import Foundation

struct Storage {
    
    let data =  [
        [
          "startCity": "Москва",
          "startCityCode": "mow",
          "endCity": "Санкт-Петербург",
          "endCityCode": "led",
          "startDate": "2022-07-20T00:00:00Z",
          "endDate": "2022-07-25T00:00:00Z",
          "price": "2690",
          "searchToken": "MOW2007LED2507Y100"
        ],
        [
          "startCity": "Москва",
          "startCityCode": "mow",
          "endCity": "Нижний Новгород",
          "endCityCode": "goj",
          "startDate": "2022-06-10T00:00:00Z",
          "endDate": "2022-06-13T00:00:00Z",
          "price": "3140",
          "searchToken": "MOW1006GOJ1306Y100"
        ],
        [
          "startCity": "Москва",
          "startCityCode": "mow",
          "endCity": "Калининград",
          "endCityCode": "kgd",
          "startDate": "2022-09-26T00:00:00Z",
          "endDate": "2022-09-29T00:00:00Z",
          "price": "4570",
          "searchToken": "MOW2609KGD2909Y100"
        ]
    ]
    
    func fetchData() -> [[String : String]] {
        return data
    }
}
