//
//  ArticleCollectionViewCell.swift
//  New York Times
//
//  Created by Alan Lin on 12/1/17.
//  Copyright © 2017 Alan Lin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ArticleCollectionViewCell: UICollectionViewCell {
    var headline: UILabel!
    var snippet: UILabel!
    var link: UIButton!
    var image: UIImageView!
    
    let padding: CGFloat = 5.0
    let interItemSpacing: CGFloat = 8.0
    let imageSize: CGFloat = 100.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        headline = UILabel(frame: CGRect(x: padding, y: padding, width: UIScreen.main.bounds.width - (2 * padding) - imageSize, height: 22))
        headline.textColor = .black
        headline.font = UIFont(name: "HelveticaNeue", size: 20.0)
        contentView.addSubview(headline)
        
        snippet = UILabel(frame: CGRect(x: padding, y: padding, width: UIScreen.main.bounds.width - (2 * padding) - imageSize, height: imageSize - 3 * padding - 22))
        snippet.textColor = .gray
        snippet.font = UIFont(name: "HelveticaNeue", size: 18.0)
        contentView.addSubview(snippet)
        
        image = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - padding - imageSize, y: 0.0, width: imageSize, height: imageSize))
        contentView.addSubview(image)
    }
    
    func setup(article: Article) {
        headline.text = article.headline
        snippet.text = article.snippet
        Alamofire.request(article.image).responseData { response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data){
                    self.image.image = image
                } else{
                    print("unable to convert data to image")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
