import UIKit
import RxSwift

private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    internal var tvShowData: TvShowDataDelegate?
    internal var tvShows = [TvShowModelDelegate]() {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    internal let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        let cellNib = UINib(nibName: "SerialViewCell", bundle: nil)
        // Register cell classes
        self.collectionView?.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
        // Do any additional setup after loading the view.

        self.tvShowData = TvShowData()
        self.tvShowData?.getTvShowsArray(stringQuery: nil).subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                self.tvShows.append($0)
                }, onCompleted: {
            })
            .disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2.1
        let height = collectionView.frame.height / 2.1
        
        return CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TvShowVC") as! TvShowViewController
        
        nextVC.tvShow = self.tvShows[indexPath.row]
        
        self.show(nextVC, sender: self)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tvShows.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SerialViewCell
        let tvShow = self.tvShows[indexPath.row]
        cell.tvShowRating.text = tvShow.rating
        cell.tvShowName.text = tvShow.name
        cell.tvShowImage.setImageFromUrl(imageUrl: URL(string: tvShow.imagePath!)!)
       
        return cell
    }
    
}
