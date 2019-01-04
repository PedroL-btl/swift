///////////////////////////////////////////////////////////////////////////////////////////////////
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////
extension UIImageView{
    func loadFrom(url: URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
extension UIViewController {
    class func displaySpinner(onView : UIView, withView: UIView? = nil) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        if withView != nil{
            withView!.frame = onView.bounds
            spinnerView.addSubview(withView!)
        }
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        //ai.center = spinnerView.center
        ai.center = CGPoint(x:spinnerView.center.x, y:spinnerView.center.y + 50)
        
        DispatchQueue.main.async() {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        // if not connected to internet and cannot get data, wont go forever displaying the spinner
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) { // 6 seconds
            print("Timer fired!")
            self.removeSpinner(spinner: spinnerView)
        }
        return spinnerView
    }
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            print("Timer stopped!")
            spinner.removeFromSuperview()
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
