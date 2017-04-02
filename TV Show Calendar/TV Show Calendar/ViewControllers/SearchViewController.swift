import UIKit
import RxSwift

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let reuseIdentifier = "Search Cell"
    let disposeBag = DisposeBag()
    var tvShows = [TvShowModelDelegate]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var tvShowData: TvShowDataDelegate?
    internal var handle = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibCell = UINib(nibName: "SerialViewCell", bundle: nil)
        self.collectionView.register(nibCell, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchBar.delegate = self
        
        self.tvShowData = TvShowData()
        
        
        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query = searchBar.text
        handle.invalidate()
        if((query?.characters.count)! > 3) {
            handle = setTimeout(delay: 1, block: {
            self.tvShows = [TvShowModelDelegate]()
            
            self.tvShowData?.searchTvShow(query!.replacingOccurrences(of: " ", with: "%20"))
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: {
                    self.tvShows.append($0)
                })
                .disposed(by: self.disposeBag)
            })
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2.1
        let height = collectionView.frame.height / 2.1
        
        return CGSize(width: width, height: height)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SerialViewCell
        let tvShow = tvShows[indexPath.row]
        cell.tvShowRating.text = tvShow.rating
        cell.tvShowName.text = tvShow.name
        cell.tvShowImage.setImageFromUrl(imageUrl: URL(string: tvShow.imagePath!)!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TvShowVC") as! TvShowViewController
        
        nextVC.tvShow = self.tvShows[indexPath.row]
        
        self.show(nextVC, sender: self)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func setTimeout(delay:TimeInterval, block:@escaping ()->Void) -> Timer {
        return Timer.scheduledTimer(timeInterval: delay, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: false)
    }
    
}
