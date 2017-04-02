import UIKit
import RxSwift

class TvShowViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    internal var tvShow: TvShowModelDelegate?
  
    internal var tvShowData: TvShowDataDelegate?
    internal let disposeBag = DisposeBag()
    internal let reuseIdentifier = "SeasonCell"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var backDropImage: UIImageView!
    @IBOutlet weak var tvShowDescription: UILabel!
    @IBOutlet weak var seasonsTableView: UITableView!
    
    internal var seasons = [SeasonModelDelegate]() {
        didSet {
            self.seasonsTableView?.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tvShowDescription.text = tvShow?.description
        self.name.text = tvShow?.name
        self.backDropImage.setImageFromUrl(imageUrl: URL(string: (self.tvShow?.backDropPath)!)!)
        // Do any additional setup after loading the view.
        
        self.seasonsTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        seasonsTableView.delegate = self
        seasonsTableView.dataSource = self
        
        self.tvShowData = TvShowData()
        
        tvShowData?.getTvShow((tvShow?.id)!).subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                self.seasons.append($0)
            }, onCompleted: {
                
            })
            .disposed(by: disposeBag)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = seasonsTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "Season \(seasons[indexPath.row + 1].seasonNumber)"
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
