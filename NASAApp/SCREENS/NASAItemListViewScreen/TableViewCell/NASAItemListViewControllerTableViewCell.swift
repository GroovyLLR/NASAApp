//
//  NASAItemListViewControllerTableViewCell.swift
//  NASAApp
//
//  Created by Ludovik on 13/04/2021.
//

import UIKit

class NASAItemListViewControllerTableViewCell: UITableViewCell {

    static let identifier = "NASAItemListViewControllerTableViewCell"
    
    
    @IBOutlet var imgViewThumbNail: CustomImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDesc: UILabel!
    
    
    var viewModel: NASAItemListViewControllerTableViewCellViewModel? {
        didSet{
            didUpdateModel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgViewThumbNail.clear()
        lblTitle.text = nil
        lblDesc.text = nil
    }
    
    private func didUpdateModel(){
        lblTitle.attributedTextFrom(viewModel?.title ?? "", LineHeight: 20, Font: UIFont.init(name: "HelveticaNeue-Bold", size: 16)!, TextColor: UIColor.hex("#151515", alpha: 1.0))
        lblDesc.attributedTextFrom(viewModel?.photographerWithDateText ?? "", LineHeight: 24, Font: UIFont.init(name: "HelveticaNeue", size: 14)!, TextColor: UIColor.hex("#626262", alpha: 1.0))
        imgViewThumbNail.downloadImageFromUrl(viewModel?.imageUrl)
    }
    
}

extension NASAItemListViewControllerTableViewCell {
    
    private func setUpUI(){
        setUpLblTitle()
        setUpLblDesc()
        setUpImgViewThumbNail()
    }
    
    private func setUpLblTitle(){
        lblTitle.numberOfLines = 0
    }
    
    private func setUpLblDesc(){
        lblDesc.numberOfLines = 0
    }
    
    private func setUpImgViewThumbNail(){
        imgViewThumbNail.backgroundColor = UIColor.hex("#E6E6E6", alpha: 1.0)
        imgViewThumbNail.contentMode = .scaleAspectFill
    }
}
