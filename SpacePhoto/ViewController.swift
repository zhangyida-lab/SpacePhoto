//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Tony on 2021/1/31.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var SpacePhoto: UIImageView!
    
    
    @IBOutlet var DescriptionLabel: UILabel!
    
    @IBOutlet var copyrightLabel: UILabel!
    
    
    let photoInfoController = PhotoInfoController()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        SpacePhoto.image = UIImage(systemName: "photo.on.rectangle")
        DescriptionLabel.text = ""
        copyrightLabel.text = ""
        photoInfoController.fetchPhotoInfo{(result) in DispatchQueue.main.async {
            switch result {
            case .success(let photoInfo):
                self.updateUI(with: photoInfo)
            case .failure(let error):
                self.updateUI(with: error)
            }
        }}
        // Do any additional setup after loading the view.
    }
    func updateUI (with photoInfo: PhotoInfo) {photoInfoController.fetchImage (from: photoInfo.url) { (result) in DispatchQueue.main.async {
        switch result {
        case .success(let image):
            self.title = photoInfo.title
            self.SpacePhoto.image = image
            self.DescriptionLabel.text = photoInfo.description
            self.copyrightLabel.text = photoInfo.copyright
        case .failure(let error):
            self.updateUI(with: error)
        }
    }}}
    
    func updateUI(with error: Error){
        title = "Error Fetching Photo"
        SpacePhoto.image = UIImage(systemName: "exclamationmark.octagon")
        DescriptionLabel.text = error.localizedDescription
        copyrightLabel.text = ""
    }

}

