//
//  NASAItemListViewController.swift
//  NASAApp
//
//  Created by Ludovik on 13/04/2021.
//

import UIKit
import RxSwift
import RxCocoa

class NASAItemListViewController: UIViewController {

    @IBOutlet var nasaItemTableview: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    lazy var header: UIView = {
        let v = UIView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: view.frame.size.width, height: 24)))
        v.backgroundColor = UIColor.clear
        return v
    }()
    
    lazy var loadMoreView = LoadMoreView(scrollView: nasaItemTableview, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)
    
    lazy var viewModel = NASAItemListViewControllerViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bindViewModel()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .always
    }
    
    
    private func bindViewModel(){
        bindActivityIndicatorView()
        bindNasaTableView()
        viewModel.refreshItems()
        bindToError()
        bindLoadMoreView()
    }
    
    
    private func bindActivityIndicatorView(){
        viewModel.isLoading.observe(on: MainScheduler.instance).bind(to: activityIndicatorView.rx.isAnimating).disposed(by: disposeBag)
        viewModel.isLoading.observe(on: MainScheduler.instance).map{ $0 ? 1 : 0}.bind(to: activityIndicatorView.rx.alpha).disposed(by: disposeBag)
        viewModel.isLoading.observe(on: MainScheduler.instance).map{ $0 ? StyleGuide.getNavBarBackgroundColor() : UIColor.white}.bind(to: header.rx.backgroundColor).disposed(by: disposeBag)
    }
    
    private func bindNasaTableView(){
        
        viewModel.nasaItems.observe(on: MainScheduler.instance).bind(to: nasaItemTableview.rx.items(cellIdentifier: NASAItemListViewControllerTableViewCell.identifier)){ index, viewModel, cell in
            guard let cell = cell as? NASAItemListViewControllerTableViewCell else {
                return
            }
            cell.selectionStyle = .none
            cell.viewModel = viewModel
        }.disposed(by: disposeBag)
        
        
        nasaItemTableview.rx.modelSelected(NASAItemListViewControllerTableViewCellViewModel.self).observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] item in
                guard let `self` = self else {return}
                AppRouter.showNasaItemDetailViewController(NavigationController: self.navigationController!, NasaItemViewModelProtocol: item)
            }).disposed(by: disposeBag)
        
        
        nasaItemTableview.rx.contentOffset.observe(on: MainScheduler.asyncInstance).subscribe { (offset) in
            self.loadMoreView.start {
                self.viewModel.loadMoreItems()
            }
        }.disposed(by: disposeBag)
        
        
    }
    
    private func bindLoadMoreView(){
        viewModel.isLoadingNextPage.observe(on: MainScheduler.instance).subscribe {[weak self] (isLoading) in
            guard let `self` = self else {return}
            if !isLoading.element! {
                self.loadMoreView.stop()
            }
        }.disposed(by: disposeBag)
    }
    
    private func bindToError(){
        viewModel.error.observe(on: MainScheduler.instance).subscribe {[weak self] (error) in
            guard let `self` = self else {return}
            self.showAlertOnError(error.element!)
        }.disposed(by: disposeBag)

    }
    
    private func showAlertOnError(_ error: APiManager.ApiError){
        let alert = UIAlertController(title: "That didn’t work!",
                                      message:error.message,
                                      preferredStyle: UIAlertController.Style.alert)
        let retryAction = UIAlertAction.init(title: "Retry", style: .default) { (action) in
            self.viewModel.refreshItems()
        }
        alert.addAction(retryAction)
        self.present(alert, animated: true, completion: nil)
    }
}



//MARK:- SET UP UI
extension NASAItemListViewController {
    
    private func setUpUI(){
        setUpNavBar()
        setUpNasaItemTableView()
    }
    
    private func setUpNasaItemTableView(){
        nasaItemTableview.backgroundColor = StyleGuide.getNavBarBackgroundColor()
        nasaItemTableview.register(UINib.init(nibName: NASAItemListViewControllerTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NASAItemListViewControllerTableViewCell.identifier)
        nasaItemTableview.separatorStyle = .none
        nasaItemTableview.estimatedRowHeight = 64
        nasaItemTableview.contentInset.bottom = (UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets.bottom ?? 0
        nasaItemTableview.tableHeaderView = header
        
    }
    
    private func setUpNavBar(){
        navigationItem.title = "The Milky Way"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: StyleGuide.getGreyColor(),
                                                     .font: StyleGuide.getHelveticaNeueBoldWithSize(34)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.hex("#151515", alpha: 1.0),
                                                .font: StyleGuide.getHelveticaNeueBoldWithSize(34)]
        navBarAppearance.backgroundColor = StyleGuide.getNavBarBackgroundColor()
        navBarAppearance.shadowColor = nil
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.layer.shadowOpacity = 0.3
        navigationController?.navigationBar.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        navigationController?.navigationBar.layer.shadowRadius = 0.5
        navigationController?.navigationBar.layer.masksToBounds = false
        
    }
    
    
}
