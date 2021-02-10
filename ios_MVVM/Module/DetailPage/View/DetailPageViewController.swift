//
//  DetailPageViewController.swift
//  ios_MVVM
//
//  Created by Iglo-macpro on 10/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import UIKit
import RxSwift

class DetailPageViewController: UIViewController {

    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productDescLabel: UILabel!
    @IBOutlet weak var likesImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var data: ProductPromoDataModel?
    var viewModel = DetailPageViewModel()
    private let disposable = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setTapGesture()
        if let data = data {
            productImageView.kf.setImage(with: data.imageUrl?.toUrl)
            productDescLabel.text = data.description
            productTitleLabel.text = data.title
            priceLabel.text = data.price
            likesImageView.image = data.loved == 0 ? UIImage(systemName: "heart") : UIImage(systemName: "heart.fill")
        }
        initViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    private func setTapGesture(){
        let shareTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapShare(tapGesture:)))
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapBack(tapGesture:)))
        backImageView.addGestureRecognizer(backTapGesture)
        shareImageView.addGestureRecognizer(shareTapGesture)
    }
    
    private func initViewModel(){
        viewModel.saveSuccess.observe(disposable) { (isSuccess) in
            let message = isSuccess == true ? "Buy Item Success" : "Something wrong happened, try again later!"
            
            let alert = UIAlertController(title: "Info", message: message, preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func onClickBuy(_ sender: Any) {
        if let data = self.data {
            viewModel.saveData(context: context, promoDataList: data)
        }
    }
    
    @objc func onTapShare(tapGesture: UITapGestureRecognizer) {
        let text = "Share Test"
        let textShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func onTapBack(tapGesture: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
