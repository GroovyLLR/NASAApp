//
//  NASAItemDetailViewController.swift
//  NASAApp
//
//  Created by Ludovik on 13/04/2021.
//

import UIKit
import RxSwift
import RxCocoa


class NASAItemDetailViewController: UIViewController {

    @IBOutlet var imgView: CustomImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblPhotographer: UILabel!
    @IBOutlet var lblDesc: UILabel!

    @IBOutlet var imgViewHeight: NSLayoutConstraint!
    @IBOutlet var lblTitleHeight: NSLayoutConstraint!
    @IBOutlet var lblPhotograperHeight: NSLayoutConstraint!
    @IBOutlet var lblDescHeigh: NSLayoutConstraint!
    
    var viewModel: NASAItemDetailViewControllerViewModel!
    
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bindToViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func bindToViewModel(){
        bindLblTitle()
        bindLblPhotographer()
        bindLblDesc()
        bindImgView()
        viewModel.loadValues()
    }
    
    private func bindLblTitle(){
        viewModel.lblTitleText.subscribe { (text) in
            self.lblTitle.attributedTextFrom(text.element ?? "", LineHeight: 20, Font: UIFont(name: "HelveticaNeue-Bold", size: 16)!, TextColor: UIColor.hex("#151515", alpha: 1.0))
            self.lblTitleHeight.constant = self.lblTitle.updatedAttributedHeight()
        }.disposed(by: disposeBag)
    }
    
    private func bindLblPhotographer() {
        viewModel.lblPhotographerText.subscribe { (text) in
            self.lblPhotographer.attributedTextFrom(text.element ?? "", LineHeight: 24, Font: UIFont(name: "HelveticaNeue", size: 14)!, TextColor: UIColor.hex("#151515", alpha: 1.0))
            self.lblPhotograperHeight.constant = self.lblPhotographer.updatedAttributedHeight()
        }.disposed(by: disposeBag)
    }
    
    private func bindLblDesc() {
        viewModel.lblDescText.subscribe { (text) in
            self.lblDesc.attributedTextFrom(text.element ?? "", LineHeight: 30, Font: UIFont(name: "HelveticaNeue", size: 16)!, TextColor: UIColor.hex("#151515", alpha: 1.0))
            self.lblDescHeigh.constant = self.lblDesc.updatedAttributedHeight()
        }.disposed(by: disposeBag)
    }
    

    private func bindImgView(){
        viewModel.imageUrlValue.subscribe { (url) in
            self.imgView.downloadImageFromUrl(url)
        }.disposed(by: disposeBag)
        
        imgView.updatedImage.subscribe { (imageElement) in
            if let image = imageElement.element {
                self.imgViewHeight.constant = self.imgView.frame.size.width/(image.size.width/image.size.height)
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        }.disposed(by: disposeBag)

    }
    

}


extension NASAItemDetailViewController {
    
    private func setUpUI(){
        setUPImgView()
        setUpLblTitle()
        setUpLblPhotographer()
        setUpLblDesc()
    }
    
    private func setUPImgView(){
        imgView.backgroundColor = UIColor.hex("#E6E6E6", alpha: 1.0)
        imgView.contentMode = .scaleAspectFit
    }
    
    private func setUpLblTitle(){
        lblTitle.numberOfLines = 0
        lblTitle.text = nil
    }
    
    private func setUpLblPhotographer(){
        lblPhotographer.numberOfLines = 0
        lblPhotographer.text = nil
    }
    
    private func setUpLblDesc(){
        lblDesc.numberOfLines = 0
        lblDesc.text = nil
    }
    
    private func setUpNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    
}
