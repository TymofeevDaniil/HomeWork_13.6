import UIKit
import Alamofire

class ViewController2: UIViewController {
    
    var fiveDayData: [String] = []
    var fiveDayTemp: [Int] = []
    let c = "C\u{00B0}" // "C" and celsius symbol
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainTempLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherDataLoader().loadWeatherAlamofire{ weatherData in
            self.nameLabel.text = weatherData.name
            self.mainTempLabel.text = "\(weatherData.tempDay1) \(self.c)"
            self.minTempLabel.text = "мин.  \(weatherData.tempMin) \(self.c)"
            self.maxTempLabel.text = "макс. \(weatherData.tempMax) \(self.c)"
            self.iconImageView.image = UIImage(named: "\(weatherData.icon)")
            self.descriptionLabel.text = weatherData.description
            self.fiveDayData = weatherData.dayList
            self.fiveDayTemp = weatherData.tempList
            self.listTableView.reloadData()
        }
    }
}
extension ViewController2: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fiveDayData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fiveDayCell") as! fiveDayCell
        cell.dateLabel.text = fiveDayData[indexPath.row]
        cell.tempLabel.text = String(fiveDayTemp[indexPath.row]) + " \(self.c)"
        return cell
    }
}
