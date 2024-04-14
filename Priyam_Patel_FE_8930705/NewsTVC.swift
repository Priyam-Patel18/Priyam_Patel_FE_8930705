//
//  NewsTVC.swift
//  Priyam_Patel_FE_8930705
//
//  Created by PRIYAM PATEL on 11/04/24.
//

import UIKit

class NewsTVC: UITableViewController {

        var newsArray: [Article] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.tabBarController?.title = "Local News"
            fetchNews(cityName: "Waterloo")
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(rightBarButtonTapped))
            self.tabBarController?.navigationItem.rightBarButtonItem = rightBarButton
        }
        
        @objc func rightBarButtonTapped() {
            showCityInputAlert(on: self, title: "Enter City Name", message: "Enter City name for News") { cityName in
                self.fetchNews(cityName: cityName)
            }
        }

        func fetchNews(cityName: String) {
            let urlString = "https://newsapi.org/v2/everything?q=\(cityName)&apiKey=d8699a00d6e54c96b2dbb542b8c15353"
            guard let url = URL(string: urlString) else { return }

            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    print("Error fetching news: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let newsResponse = try decoder.decode(NewsModel.self, from: data)
                    self?.newsArray = newsResponse.articles
                    self?.saveNews(article: newsResponse.articles.first!, cityName: cityName)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                } catch {
                    print("Error decoding news data: \(error.localizedDescription)")
                }
            }.resume()
        }
        
        func saveNews(article: Article, cityName: String) {
            DataSavingManager.shared.saveNews(author: article.author ?? "",
                                 cityName: cityName,
                                 content: article.content ?? "",
                                 from: "News",
                                 source: article.source?.name ?? "",
                                 title: article.title ?? "")
        }
        
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return newsArray.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDataTableViewCell", for: indexPath) as? NewsDataTableViewCell else { return UITableViewCell() }
            cell.setupUI(article: self.newsArray[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
}
