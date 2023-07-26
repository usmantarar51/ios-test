///NewsDomainToUIMapper for mapping News object to CellViewModel
protocol NewsDomainToUIMapper {
    func map(article: Article) -> NewsCellViewModel
}

struct NewsDomainToUIMapperImpl: NewsDomainToUIMapper {
    func map(article: Article) -> NewsCellViewModel {
        let filteredMediaMetadata = article.media
            .compactMap { $0.mediaMetadata.first { $0.width == 75 && $0.height == 75 } }
        return NewsCellViewModel(title: article.title,
                                 byLine: article.byline,
                                 image: filteredMediaMetadata.first?.url ?? "",
                                 publishedDate: article.publishedDate)
    }
}
