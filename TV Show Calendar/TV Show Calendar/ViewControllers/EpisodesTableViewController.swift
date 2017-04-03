import UIKit
import RxSwift

class EpisodesTableViewController: UITableViewController {
    
    internal let reuseIdentifier = "Episode Cell"
    var id: String?
    var seasonNumber: String?
    
    internal var tvShowData: TvShowData?
    internal var tvShowEpisodes = [EpisodeModelDelegate]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    internal let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "EpisodeViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: reuseIdentifier)
        
        self.startLoading()
        
        tvShowData = TvShowData()
        tvShowData?.getTvShowSeasonEpisodes(seasonNumber!, id!)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                self.tvShowEpisodes.append($0)
            }, onCompleted: {
                self.stopLoading()
            })
            .disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return tvShowEpisodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EpisodeViewCell
        cell.backgroundColor = tableView.backgroundColor
        
        let episode = tvShowEpisodes[indexPath.row]
        let airDate = episode.airDate
        
        let splitIndex = airDate.index(airDate.startIndex, offsetBy: 5)
        
        let year = airDate.substring(to: splitIndex).replacingOccurrences(of: "-", with: "")
        let date = airDate.substring(from: splitIndex).replacingOccurrences(of: "-", with: "/")
        
        cell.episodeNumber.text = episode.episodeNumber
        cell.episodeName.text = episode.name
        cell.episodeDate.text = date
        cell.episodeYear.text = year
        
        return cell
    }
    
  }
