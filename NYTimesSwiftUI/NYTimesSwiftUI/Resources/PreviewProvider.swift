//
//  PreviewProvider.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 14/10/1445 AH.
//

import SwiftUI

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }
    
    let article = ArticleModel(
        id: 1,
        assetId: 1,
        source: "New York Times",
        publishedDate: "2024-04-22",
        updated: "2024-04-22 13:25:58",
        section: "Health",
        byline: "By Apoorva Mandavilli and Emily Anthes",
        type: "Article",
        title: "Bird Flu Is Infecting More Mammals. What Does That Mean for Us?",
        abstract: "H5N1, an avian flu virus, has killed tens of thousands of marine mammals, and infiltrated American livestock for the first time. Scientists are working quickly to assess how it is evolving and how much of a risk it poses to humans.",
        media: [
            MediaModel(mediaMetadata: [
                MediaMetadatumModel(url: "https://static01.nyt.com/images/2024/04/16/multimedia/00birdflu-mammals-01-zktq/00birdflu-mammals-01-zktq-thumbStandard.jpg", format: "Standard Thumbnail", width: 0, height: 0),
                MediaMetadatumModel(url: "https://static01.nyt.com/images/2024/04/16/multimedia/00birdflu-mammals-01-zktq/00birdflu-mammals-01-zktq-mediumThreeByTwo210.jpg", format: "mediumThreeByTwo210", width: 0, height: 0),
                MediaMetadatumModel(url: "https://static01.nyt.com/images/2024/04/16/multimedia/00birdflu-mammals-01-zktq/00birdflu-mammals-01-zktq-mediumThreeByTwo440.jpg", format: "mediumThreeByTwo440", width: 0, height: 0)
            ])
        ]
    )

}
