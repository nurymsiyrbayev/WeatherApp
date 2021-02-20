//
//  CityListViewController.swift
//  lecture8
//
//  Created by ADMIN ODoYal on 19.02.2021.
//

import UIKit
import Alamofire

class CityListViewController: UIViewController {
    static let identifier = "CityListViewController"
    static let nib = UINib(nibName: identifier, bundle: nil)

    @IBOutlet weak var tableView: UITableView!
    private var decoder: JSONDecoder = JSONDecoder()
    let cityApis = [CityApi](arrayLiteral:
    CityApi(cityName: "Almaty", lat: 43.2500, lon: 76.9000),
    CityApi(cityName: "Nur-Sultan",lat: 51.1333, lon: 71.4333),
    CityApi(cityName: "Shymkent",lat: 42.3000, lon: 69.6000))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityListTableViewCell.nib, forCellReuseIdentifier: CityListTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func configuration() {
        navigationController?.navigationBar.barTintColor = .systemTeal
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .systemTeal
        navigationController?.setNavigationBarHidden(false, animated: false)
        tableView.backgroundColor = .systemTeal
    }
}
extension CityListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityApis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityListTableViewCell.identifier, for: indexPath) as! CityListTableViewCell
        cell.configure(cityApis[indexPath.row].cityName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: ViewController.identifier) as! ViewController
        vc.cityApi = cityApis[indexPath.row]
        navigationController?.pushViewController(vc, animated: false)
    }
}
