class NewsCellViewModel {
    var title: String
    var byLine: String
    var image: String
    var publishedDate: String
    
    init(title: String,
         byLine: String,
         image: String,
         publishedDate: String) {
        self.title = title
        self.byLine = byLine
        self.image = image
        self.publishedDate = publishedDate
    }
}
