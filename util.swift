struct appDefs{
    static var language : String = "EN"
    static var hasLocation:Bool = false
    static var lastLat : Double = 0
    static var lastLng : Double = 0
    static var itemCount: Int = 3
    static var categories : [String:Bool] = ["Item1":true, "Item2":true, "Item3":true, "Item4":true]
    static var urlData : String = "https://example.com"
}
//////////////////////////////////////////////////////////////////////
func saveDefs(){
    let defaults = UserDefaults.standard
    defaults.set(appDefs.language, forKey:"language")
    defaults.set(appDefs.raioKms, forKey:"raio")
    defaults.set(appDefs.categories, forKey:"categories")
    defaults.set(appDefs.itemCount, forKey:"itemCount")

}
func loadDefaults(){
    let defaults = UserDefaults.standard
    
    if defaults.integer(forKey: "itemCount") != nil{
    appDefs.itemCount = defaults.integer(forKey: "itemCount")
    }
    
    if defaults.object(forKey: "categories") != nil{
        appDefs.categories = defaults.object(forKey: "categories") as! [String:Bool]
    }
}


