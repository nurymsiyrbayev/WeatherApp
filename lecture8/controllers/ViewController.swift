//
//  ViewController.swift
//  lecture8
//
//  Created by admin on 08.02.2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    static let identifier = "ViewController"
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var cityListButton: UIButton!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var feelsLikeTemp: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    private var decoder: JSONDecoder = JSONDecoder()
    var cityApi = CityApi(cityName: "Nur-Sultan", lat: 51.1333, lon: 71.4333)
    var myData: Model?
    
    @IBAction func showCityList(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: CityListViewController.identifier) as! CityListViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.nib, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.identifier)
        fetchData()
        print(cityApi.gethost())
        print(myData ?? 0)
    }
    
    func configure() {
        navigationController?.navigationBar.barTintColor = .systemTeal
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .systemTeal
        collectionView.backgroundColor = .systemTeal
        tableView.backgroundColor = .systemTeal
        var frame = tableView.frame
         frame.size.height = tableView.contentSize.height
         tableView.frame = frame
    }
    
    
    func updateUI(){
        updateCurrentWether()
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    func updateCurrentWether() {
        cityName.text = cityApi.cityName
        temp.text = "\(Int(myData?.current?.temp ?? 0.0))°"
        feelsLikeTemp.text = "\(Int(myData?.current?.feels_like ?? 0.0))°"
        desc.text = myData?.current?.weather?.first?.description
    }
    
    func fetchData(){
        AF.request(cityApi.gethost()).responseJSON { (response) in
            switch response.result{
            case .success(_):
                guard let data = response.data else { return }
                guard let answer = try? self.decoder.decode(Model.self, from: data) else{ return }
                self.myData = answer
                self.updateUI()
            case .failure(let err):
                print(err.errorDescription ?? "")
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData?.daily?[..<7].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.configure(myData?.daily?[indexPath.row])
        return cell
    }
    
    
}


extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myData?.hourly?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.configure(myData?.hourly?[indexPath.item])
        return cell

    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}


