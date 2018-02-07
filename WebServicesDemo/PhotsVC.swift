import UIKit

class PhotsVC: UIViewController {
    
    fileprivate let cellIdentifier = "PhotoCell"

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var addButt: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        return button
    }()
    
    
    lazy var refresher: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        return refresher
    }()

    
    
    var photos = [Photo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = addButt
      
        view.backgroundColor = .white
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.addSubview(refresher)
        
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        handleRefresh()
        

    }
    
    var picker_image: UIImage? {
        didSet{
            guard let image = picker_image else { return }
            
            API.createPhoto(photo: image) { (error: Error?, success: Bool) in
                if success {
                    
                }
            }
        }
    }
    
    @objc private func handleAdd(){
        print("Add Image")
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
    }
    
    var isLoading: Bool = false
    var current_page = 1
    var last_page = 1
    
    @objc fileprivate func handleRefresh(){
        self.refresher.endRefreshing()
        guard !isLoading else { return }
        
        isLoading = true
        API.photos { (error: Error?, photos: [Photo]?, last_page: Int) in
            self.isLoading = false
            if let photos = photos {
                self.photos = photos
                self.collectionView.reloadData()
                
                self.current_page = 1
                self.last_page=last_page
            }
        }
    }
    
    fileprivate func loadMore() {
        
        guard !isLoading else { return }
        guard current_page < last_page else { return }
        
        isLoading = true
        API.photos(page: current_page+1 ){ (error: Error?, photos: [Photo]?, last_page: Int) in
            self.isLoading = false
            if let photos = photos {
                self.photos.append(contentsOf: photos)
                self.collectionView.reloadData()
                
                self.current_page  += 1
                self.last_page = last_page
                
            }
        }
        
    }
}

extension PhotsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.picker_image = editedImage
            
        }else if let orginalImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.picker_image = orginalImage
        }
        
        picker.dismiss(animated: true, completion: 	nil)
    }
}

extension PhotsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PhotoCell else {return UICollectionViewCell()}
        
        cell.photo = photos [indexPath.item]
        
        
        return cell
    }
}

extension PhotsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let screenWidth = UIScreen.main.bounds.width
        var width = (screenWidth-30)/2
        
        width = width > 150 ? 150 : width
        
        return CGSize.init(width: width, height: width)
    }
}



