//
//  NewsDataTableViewCell.swift
//  Priyam_Patel_FE_8930705
//
//  Created by PRIYAM PATEL on 11/04/24.
//

import UIKit

class NewsDataTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAthr: UILabel!
    @IBOutlet weak var lblsrc: UILabel!
    @IBOutlet weak var lbltitl: UILabel!
    @IBOutlet weak var lblcntnt: UILabel!
    
    func setupUI(article: Article) {
        lblAthr.text = "Author: \(article.author ?? "Unknown")"
        lblsrc.text = "Source: \(article.source?.name ?? "")"
        lbltitl.text = "Title: \(article.title ?? "")"
        lblcntnt.text = "Content: \(article.description ?? "")"
    }

}
