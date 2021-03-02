//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Tony on 2021/1/31.
//
import UIKit
import Foundation
class PhotoInfoController {
    
    
//    8ocADJIMFcyircgJ1fMqzivQtiVrwXCslTq1JUTu  api密钥
    

    var randomDateYear = String((arc4random()%2) + 2018)   ;
    var randomDateMonth = String((arc4random()%11) + 1) ;
    var randomDateDay = String((arc4random()%27) + 1) ;
    
    
    
    func fetchPhotoInfo(completion:@escaping (Result<PhotoInfo,Error>) -> Void ) {
      
        var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
        urlComponents.queryItems = ["api_key":"8ocADJIMFcyircgJ1fMqzivQtiVrwXCslTq1JUTu","date": "\(randomDateYear)-\(randomDateMonth)-\(randomDateDay)"].map { URLQueryItem(name: $0.key, value: $0.value)}

        let task = URLSession.shared.dataTask(with: urlComponents.url!) {(data,response,error) in
            let jsonDecoder = JSONDecoder()
            if let data = data {
               do {
                let photoInfo = try
                    jsonDecoder.decode(PhotoInfo.self, from: data)
                completion(.success(photoInfo))
               } catch {
                completion(.failure(error))
               }
            } else if let error = error {completion(.failure(error))}
            }
            task.resume()}
    
    
    enum PhotoInfoError: Error, LocalizedError {
        case imageDataMissing
    }

    
    
    func fetchImage(from url: URL,completion: @escaping (Result<UIImage, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url){(data ,response ,error ) in
            if let data = data ,let image = UIImage(data: data) {completion(.success(image))} else if let error = error {completion(.failure(error))} else {completion(.failure(PhotoInfoError.imageDataMissing))}
        }
        task.resume()
        
    }
    
    
 
    
}
