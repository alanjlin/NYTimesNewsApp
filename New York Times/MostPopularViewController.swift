//
//  MostPopularViewController.swift
//  New York Times
//
//  Created by Alan Lin on 12/1/17.
//  Copyright © 2017 Alan Lin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MostPopularViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var articles: [Article] = []
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        self.title = "Most Popular"
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 10, height: 100)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ArticleCollectionViewCell.self, forCellWithReuseIdentifier: "ArticleCollectionViewCell")
        collectionView.backgroundColor = UIColor.lightGray
        self.view.addSubview(collectionView)
        // Do any additional setup after loading the view.
        let mpURL = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/1.json")!
        let parameters: Parameters = [
            "api-key": "28ee283d860d4ce4ad272f35b0c67a45",
            "section": "all-sections",
            "time-period": "1"
        ]
        Alamofire.request(mpURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success( let json ):
                    let json = JSON(json)
                    var i = 0
                    while i < 20 {
                        let head = json["results"].array?[i]["title"].string
                        let snip = json["results"].array?[i]["abstract"].string
                        let url = json["results"].array?[i]["url"].string
                        var img = json["results"].array?[i]["media"].array?[0]["media-metadata"].array?[0]["url"].string
                        if img == nil {
                            img = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png"
                        }
                        self.articles.append(Article(headline: head!, snippet: snip!, link: url!, image: img!))
                        i = i + 1
                    }
                    self.collectionView.reloadData()
                    
                case .failure( let error ):
                    print(error)
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var detailVC = DetailViewController()
        detailVC.setup(article: articles[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCollectionViewCell", for: indexPath) as? ArticleCollectionViewCell else {return UICollectionViewCell()}
        cell.backgroundColor = UIColor.white
        cell.setup(article: articles[indexPath.row])
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
