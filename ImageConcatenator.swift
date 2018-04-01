extension UIImage
{
    // larger image will cater to smaller image by getting scaled down
    func concatenate(withImage image: UIImage, direction: Direction, offset: CGFloat = 0) -> UIImage? {
        
        let firstImage: UIImage
        let secondImage: UIImage
        
        if direction == .vertical {
            
            firstImage = self.size.width > image.size.width ? self.resize(newSize: CGSize(width: image.size.width, height: self.size.height * (image.size.width / self.size.width))) : self
            secondImage = self.size.width > image.size.width ? image : image.resize(newSize: CGSize(width: self.size.width, height: image.size.height * (self.size.width / image.size.width)))
        }
        else {
            
            firstImage = self.size.height > image.size.height ? self.resize(newSize: CGSize(width: self.size.width * (image.size.height / self.size.height), height: image.size.height)) : self
            secondImage = self.size.height > image.size.height ? image : image.resize(newSize: CGSize(width: image.size.width * (self.size.height / image.size.height), height: self.size.height))
        }
        
        let resultSize = direction == .vertical ? CGSize(width: firstImage.size.width, height: firstImage.size.height + secondImage.size.height) : CGSize(width: firstImage.size.width + secondImage.size.width, height: firstImage.size.height)
        
        UIGraphicsBeginImageContext(resultSize)
        
        defer{
            UIGraphicsEndImageContext()
        }
        
        if direction == .vertical {
            
            firstImage.draw(in: CGRect(x: 0, y: 0, width: firstImage.size.width, height: firstImage.size.height))
            secondImage.draw(in: CGRect(x: 0, y: firstImage.size.height + offset, width: secondImage.size.width, height: secondImage.size.height))
        }
        else{
            
            firstImage.draw(in: CGRect(x: 0, y: 0, width: firstImage.size.width, height: firstImage.size.height))
            secondImage.draw(in: CGRect(x: firstImage.size.width + offset, y: 0, width: secondImage.size.width, height: secondImage.size.height))
        }
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
