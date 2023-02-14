//
//  OnboardingVC.swift
//  Project Management
//
//  Created by Apple on 08/02/23.
//

import UIKit
import AVKit
import PDFKit
import QuickLook

class ContentVC: UIViewController,QLPreviewControllerDataSource {
    
    // MARK: - Variables
    static var stringForTitle: String?
    var player: AVPlayer?
    var pdfViewObject: PDFView = PDFView()
    var pdfDocumentationObject: PDFDocument = PDFDocument()
    var totalPages = 0
 
    // MARK: IBOutlets
    @IBOutlet weak var ShowPdfBtn: UIButton!
    @IBOutlet weak var textViewForContent: UITextView!
    @IBOutlet weak var labelForTittle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        labelForTittle.text = ContentVC.stringForTitle
        addContent()
    }
    
    // MARK: - Required Methods
    func addContent() {
        if let dictionary = ViewAfterDetailsVC.myOptionalDictionary {
            for (_, value) in dictionary {
                for key in value.keys {
                    if ContentVC.stringForTitle == key {
                        textViewForContent.text = value[key]
                    }
                }
            }
        }
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let url = Bundle.main.url(forResource: "ayush", withExtension: "pdf")!
        return url as QLPreviewItem
    }
    
    func addPlayerToView(_ view: UIView) {
        player = AVPlayer()
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspect
        view.layer.addSublayer(playerLayer)
        player?.appliesMediaSelectionCriteriaAutomatically = true
        let videoURL = URL(fileURLWithPath: "/Users/apple/Downloads/Onboarding.mp4")
        let playerItem = AVPlayerItem(url: videoURL)
        player?.replaceCurrentItem(with: playerItem)
        player?.play()
    }
    
    // MARK: - IBActions
    @IBAction func showPdfBtn(_ sender: Any) {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        present(previewController, animated: true, completion: nil)
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
