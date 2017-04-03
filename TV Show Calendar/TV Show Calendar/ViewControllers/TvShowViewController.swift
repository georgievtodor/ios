import UIKit
import RxSwift

class TvShowViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    internal var tvShow: TvShowModelDelegate?
  
    internal var tvShowData: TvShowDataDelegate?
    internal let disposeBag = DisposeBag()
    internal let reuseIdentifier = "SeasonCell"
    internal var localData: LocalData?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var backDropImage: UIImageView!
    @IBOutlet weak var tvShowDescription: UILabel!
    @IBOutlet weak var seasonsTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var followButton: UIButton!
    
    internal var seasons = [SeasonModelDelegate]() {
        didSet {
            self.seasonsTableView?.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.frame = view.frame
        self.tvShowDescription.text = tvShow?.description?.trunc(length: 150)
        self.name.text = tvShow?.name
        self.backDropImage.setImageFromUrl(imageUrl: URL(string: (self.tvShow?.backDropPath)!)!)
        self.backDropImage.contentMode = .scaleAspectFit
        // Do any additional setup after loading the view.
        
        self.seasonsTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        seasonsTableView.delegate = self
        seasonsTableView.dataSource = self
        
        self.tvShowData = TvShowData()
        self.localData = LocalData()
        
        self.startLoading()
        
        tvShowData?.getTvShow((tvShow?.id)!).subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                self.seasons.append($0)
            }, onCompleted: {
                self.stopLoading()
            })
            .disposed(by: disposeBag)
        
        setButtonText()
    }
    
    @IBAction func follow(_ sender: Any) {
        if(localData?.checkIfExists(tvShowId: (tvShow?.id)!))! {
            followButton.setTitle("Follow", for: .normal)
            localData?.deleteTvShow(tvShowId: (tvShow?.id)!)
        } else {
            followButton.setTitle("Unfollow", for: .normal)
            localData?.save(tvShow: tvShow!)
        }
    }
    
    func setButtonText() {
        if(localData?.checkIfExists(tvShowId: (tvShow?.id)!))! {
            followButton.setTitle("Unfollow", for: .normal)
        } else {
            followButton.setTitle("Follow", for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EpisodesTVC") as! EpisodesTableViewController
        
        nextVC.id = tvShow?.id
        nextVC.seasonNumber = seasons[indexPath.row].seasonNumber
        
        self.show(nextVC, sender: self)
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
        cell.backgroundColor = view.backgroundColor
        return cell
    }
    
}
