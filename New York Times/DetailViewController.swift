//
//  DetailViewController.swift
//  New York Times
//
//  Created by Alan Lin on 12/5/17.
//  Copyright © 2017 Alan Lin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController {
    
    var headline: UILabel = UILabel(frame: CGRect(x: 0.0, y: 100.0, width: UIScreen.main.bounds.width, height: 34.0))
    var snippet: UITextView! = UITextView(frame: CGRect(x: 0.0, y: 140.0 + UIScreen.main.bounds.width, width: UIScreen.main.bounds.width, height: 200.0))
    var image: UIImageView! = UIImageView(frame: CGRect(x: 0.0, y: 140.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        super.viewDidLoad()
        headline.textColor = .black
        headline.font = UIFont(name: "HelveticaNeue", size: 30.0)
        self.view.addSubview(headline)
        snippet.textColor = .black
        snippet.font = UIFont(name: "TimesNewRoman", size: 14.0)
        self.view.addSubview(snippet)
        self.view.addSubview(image)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup(article: Article)  {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
