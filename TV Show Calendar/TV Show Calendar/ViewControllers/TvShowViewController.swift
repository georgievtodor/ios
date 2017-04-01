//
//  TvShowViewController.swift
//  TV Show Calendar
//
//  Created by Todor on 4/1/17.
//  Copyright © 2017 Todor. All rights reserved.
//

import UIKit

class TvShowViewController: UIViewController {
    internal var tvShow: TvShowModelDelegate?
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var backDropImage: UIImageView!
    @IBOutlet weak var tvShowDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tvShowDescription.text = tvShow?.description
        self.name.text = tvShow?.name
        self.backDropImage.setImageFromUrl(imageUrl: URL(string: (self.tvShow?.backDropPath)!)!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
