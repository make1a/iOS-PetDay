//
//  PhotoLibraryViewController.swift
//  iOS-PetDay
//
//  Created by Fidetro on 09/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import Photos
import SVProgressHUD
import Hero

fileprivate extension Selector {
    static let cancelClick = #selector(PhotoLibraryViewController.cancel)
}

class PhotoLibraryViewController: UIViewController,CustomControllerProtocol{

    // MARK: - 👉Properties
    fileprivate var selectMax: Int = 6
    let space:CGFloat = 2.0
    fileprivate var collectionView: UICollectionView!
    fileprivate let imageManager = PHCachingImageManager()
    fileprivate var previousPreheatRect = CGRect.zero
    // 选择图片数
    fileprivate var selectCount: Int = 0
    
    // 选中的Image
    fileprivate var selectedImages = [UIImage]()
    // 图片被选中的标识
    fileprivate var flags = [Bool]()
    
    fileprivate var thumnailSize = CGSize.init(width: UIScreen.main.bounds.width/3-1, height: UIScreen.main.bounds.width/3-1)

    var fetchAllPhotos: PHFetchResult<PHAsset>!

    
    lazy var containerView: PhotoLibraryContainerView = {
        var containerView = PhotoLibraryContainerView()
        containerView.collectionView.dataSource = self
        containerView.collectionView.delegate = self
        view.addSubview(containerView)
        return containerView
    }()
    
    lazy var currentPhotosArray:Array = [Any]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavgationStyle()
        snpLayoutSubview()
        fetchAlbumsFormSystemAlbum()
        // 更新
        updateCachedAssets()
        fillInFlags()
    }
    


    func setNavgationStyle() {
        setTitle("选择照片", color: .white)
        setNavigationBar(color: .themeBlackColor())
        let button = UIButton.init(type: .custom)
        button .setTitle("取消", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        button.imageView?.contentMode = .scaleAspectFill
        button.sizeToFit()

        navigationItem.setupNavigationItem(items: [button], orientation: .left, actions: [.cancelClick], target: self)
    }

    // MARK: - 👉action
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - 👉Private
    ///初始化flag
    private func fillInFlags(){
        (0 ..< fetchAllPhotos.count).forEach {_ in
            flags.append(false)
        }
    }
    
    /// 获取所有系统相册照片
    private func fetchAlbumsFormSystemAlbum(){
        // 监测数据源
        if fetchAllPhotos == nil {
            let allOptions = PHFetchOptions()
            allOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            fetchAllPhotos = PHAsset.fetchAssets(with: allOptions)
            containerView.collectionView.reloadData()
            
        }
    }
    /// 更新图片缓存设置
    fileprivate func updateCachedAssets() {
        // 视图可访问时才更新
        guard isViewLoaded && view.window != nil else {
            return
        }
        
        // 预加载视图的高度是可见视图的两倍，这样滑动时才不会有阻塞
        let visibleRect = CGRect(origin: containerView.collectionView.contentOffset, size: containerView.collectionView.bounds.size)
        let preheatRect = visibleRect.insetBy(dx: 0, dy: -0.5 * visibleRect.height)
        
        // 只有可见视图与预加载视图有明显不同时，才会更新
        let delta = abs(preheatRect.maxY - previousPreheatRect.maxY)
        guard delta > view.bounds.height / 3 else {
            return
        }
        
        
        // 计算 assets 用来开始和结束缓存
        let (addedRects, removeRects) = PhotoLibraryTool.differencesBetweenRects(previousPreheatRect, preheatRect)
        let addedAssets = addedRects
            .flatMap { rect in containerView.collectionView.indexPathsForElements(in: rect)}
            .map { indexPath in fetchAllPhotos.object(at: indexPath.item) }
        let removedAssets = removeRects
            .flatMap { rect in containerView.collectionView.indexPathsForElements(in: rect) }
            .map { indexPath in fetchAllPhotos.object(at: indexPath.item) }
        
        // 更新图片缓存
        imageManager.startCachingImages(for: addedAssets, targetSize: thumnailSize, contentMode: .aspectFill, options: nil)
        imageManager.stopCachingImages(for: removedAssets, targetSize: thumnailSize, contentMode: .aspectFill, options: nil)
        
        // 保存最新的预加载尺寸用来和后面的对比
        previousPreheatRect = preheatRect
    }
    
    
    /// 重置图片缓存
    private func resetCachedAssets() {
        imageManager.stopCachingImagesForAllAssets()
        previousPreheatRect = .zero
    }
    
    
    func snpLayoutSubview() {
        containerView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }

    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    

}

//MARK:UICollectionViewDataSource&UICollectionViewDelegateFlowLayout
extension PhotoLibraryViewController:UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchAllPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:PhotoLibraryCollectionViewCell = PhotoLibraryCollectionViewCell.dequeueReusable(withCollectionView: collectionView,for: indexPath)
        let asset = fetchAllPhotos.object(at: indexPath.item)
        cell.representAssetIdentifier = asset.localIdentifier
        imageManager.requestImage(for: asset, targetSize: thumnailSize, contentMode: .aspectFill, options: nil) { (img, _) in
            if cell.representAssetIdentifier == asset.localIdentifier {
                cell.imageView.image = img
            }
        }
        cell.imageView.hero.id = "image_\(indexPath.item)"
        cell.imageView.hero.modifiers = [.fade, .scale(0.8)]
        cell.cellIsSelected = flags[indexPath.item]
        cell.handleSelectionAction = {
            if self.selectedImages.count > self.selectMax - 1 && !cell.cellIsSelected {
                SVProgressHUD.showError(withStatus: "选择的图片不能超过\(self.selectMax)张")
                cell.selectedButton.isSelected = false
                return
            }
            
            self.flags[indexPath.item] = $0
            cell.cellIsSelected = $0
            
            if $0 == true {
                self.selectedImages.append(cell.imageView.image!)
            }else{
                let index = self.selectedImages.index(of: cell.imageView.image!)
                self.selectedImages.remove(at: index!)
            }
        }

        
        
        cell.backgroundColor = .white
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = (UIStoryboard(name: "PreviewPhotos", bundle: nil).instantiateViewController(withIdentifier: "PreviewPhotosViewController") as? PreviewPhotosViewController)!
        let cell =  collectionView.cellForItem(at: indexPath) as! PhotoLibraryCollectionViewCell
        vc.dataSource = [cell.imageView.image!]
        vc.selectedIndex = indexPath
        vc.fetchAllPhotos = fetchAllPhotos
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width/4 - space
        return CGSize.init(width: width, height: width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }

}

// MARK: - 👉UICollectionView Extension
private extension UICollectionView {
    
    /// 获取可见视图内的所有对象，用于更高效刷新
    ///
    /// - Parameter rect: rect description
    /// - Returns: return value description
    func indexPathsForElements(in rect: CGRect) -> [IndexPath] {
        let allLayoutAttributes = collectionViewLayout.layoutAttributesForElements(in: rect)!
        return allLayoutAttributes.map { $0.indexPath }
    }
}


// MARK: - 👉PHPhotoLibraryChangeObserver
extension PhotoLibraryViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
    }
}

extension PhotoLibraryViewController: HeroViewControllerDelegate{
    func heroWillStartAnimatingFrom(viewController: UIViewController) {
        view.hero.modifiers = nil
        
        if (viewController as? PhotoLibraryViewController) != nil {
            containerView.collectionView.hero.modifiers = [.cascade(delta:0.015), .delay(0.25)]
        }else{
            containerView.collectionView.hero.modifiers = [.cascade(delta:0.015)]
        }
        
    }
}
