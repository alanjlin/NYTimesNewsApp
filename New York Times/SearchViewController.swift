//
//  SearchViewController.swift
//  New York Times
//
//  Created by Alan Lin on 12/1/17.
//  Copyright © 2017 Alan Lin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var searchBar: UISearchBar!
    var articles: [Article] = []
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .white
        self.title = "Search"
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 36)
        view.addSubview(searchBar)
        // Do any additional setup after loading the view.
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 10, height: 100)
        collectionView = UICollectionView(frame: CGRect(x: 0.0, y: 36, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 36.0) , collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ArticleCollectionViewCell.self, forCellWithReuseIdentifier: "ArticleCollectionViewCell")
        collectionView.backgroundColor = UIColor.lightGray
        self.view.addSubview(collectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        articles = []
        let mpURL = URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json")!
        let parameters: Parameters = [
            "api-key": "28ee283d860d4ce4ad272f35b0c67a45",
            "q": searchText
        ]
        Alamofire.request(mpURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success( let json ):
                    let json = JSON(json)
                    if (json["response"]["docs"].array != nil) {
                        for element in (json["response"]["docs"].array)!{
                            if let head = element["headline"]["main"].string, let img = element["multimedia"].array?.first?["url"].string, let snip = element["snippet"].string, let url = element["web_url"].string {
                                self.articles.append(Article(headline: head, snippet: snip, link: url, image: "https://static01.nyt.com/" + img))
                            }
                            
                        }
                    }
                    self.collectionView.reloadData()
                    
                case .failure( let error ):
                    print(error)
                }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
}
