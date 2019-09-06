
import UIKit

class FurnitureDetailViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var furniture: Furniture?
    
    @IBOutlet var choosePhotoButton: UIButton!
    @IBOutlet var furnitureTitleLabel: UILabel!
    @IBOutlet var furnitureDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    func updateView() {
        guard let furniture = furniture else {return}
        if let imageData = furniture.imageData,
            let image = UIImage(data: imageData) {
            choosePhotoButton.setTitle("", for: .normal)
            choosePhotoButton.setImage(image, for: .normal)
        } else {
            choosePhotoButton.setTitle("Choose Image", for: .normal)
            choosePhotoButton.setImage(nil, for: .normal)
        }
        
        furnitureTitleLabel.text = furniture.name
        furnitureDescriptionLabel.text = furniture.description
    }
    
    @IBAction func choosePhotoButtonTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
         let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
         let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
         alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                imagePicker.sourceType = .camera
                self.present(imagePicker,animated: true , completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
                
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker,animated: true , completion: nil)
            }
            alertController.addAction(photoLibAction)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage =  info[.originalImage] as? UIImage else {return}
        furniture?.imageData =  selectedImage.pngData()
        dismiss(animated: true, completion: nil)
        updateView()
    }

    @IBAction func actionButtonTapped(_ sender: Any) {
        
        let activityController = UIActivityViewController(activityItems: [furniture?.imageData, furniture?.description],
                                                          applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender as! UIButton
        present(activityController , animated: true , completion: nil)
        
        
        
    }
    
}
