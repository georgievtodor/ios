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
        self.tvShowData?.getTopTvShows().subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
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
    
     // MARK: - Navigation
     /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
        let rowIndex = sender as! Int
        let nextView = segue.destination as! TvShowViewController
        nextView.tvShow = tvShows[rowIndex]
        
        
     }
    */
    // MARK: UICollectionViewDataSource
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TvShowVC") as! TvShowViewController
        
        nextVC.tvShow = self.tvShows[indexPath.row]
        
        self.show(nextVC, sender: self)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.tvShows.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SerialViewCell
        let tvShow = self.tvShows[indexPath.row]
        cell.tvShowRating.text = tvShow.rating
        cell.tvShowName.text = tvShow.name
        cell.tvShowImage.setImageFromUrl(imageUrl: URL(string: tvShow.imagePath!)!)
        
        // Configure the cell
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
