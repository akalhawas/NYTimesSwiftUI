//
//  ArticleModel.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 14/10/1445 AH.
//

import Foundation

/*
URL: https://api.nytimes.com/svc/mostpopular/v2/emailed/1.json?api-key=n2G4UgyliHFmfxxENCyOst0RGDLOZFGN
 JSON Response:
 {
 "status": "OK",
 "copyright": "Copyright (c) 2024 The New York Times Company.  All Rights Reserved.",
 "num_results": 20,
 "results": [
     {
         "uri": "nyt://article/799a22bf-04cd-52da-8621-923983c6b79b",
         "url": "https://www.nytimes.com/2024/04/22/health/birdflu-marine-mammals.html",
         "id": 100000009410097,
         "asset_id": 100000009410097,
         "source": "New York Times",
         "published_date": "2024-04-22",
         "updated": "2024-04-22 13:25:58",
         "section": "Health",
         "subsection": "",
         "nytdsection": "health",
         "adx_keywords": "Avian Influenza;Foxes;Deaths (Fatalities);Beaches;Fish and Other Marine Life;Disease Rates;Mammals;Agriculture and Farming;Birds;Animals;Poultry;Viruses;Wildlife Die-Offs;Pigs;Influenza;Cattle;Swine Influenza;your-feed-science;your-feed-health;Peru;California;Latin America;South America;United States",
         "column": null,
         "byline": "By Apoorva Mandavilli and Emily Anthes",
         "type": "Article",
         "title": "Bird Flu Is Infecting More Mammals. What Does That Mean for Us?",
         "abstract": "H5N1, an avian flu virus, has killed tens of thousands of marine mammals, and infiltrated American livestock for the first time. Scientists are working quickly to assess how it is evolving and how much of a risk it poses to humans.",
         "des_facet": [
             "Avian Influenza",
             "Foxes",
             "Deaths (Fatalities)",
             "Beaches",
             "Fish and Other Marine Life",
             "Disease Rates",
             "Mammals",
             "Agriculture and Farming",
             "Birds",
             "Animals",
             "Poultry",
             "Viruses",
             "Wildlife Die-Offs",
             "Pigs",
             "Influenza",
             "Cattle",
             "Swine Influenza",
             "your-feed-science",
             "your-feed-health"
         ],
         "org_facet": [],
         "per_facet": [],
         "geo_facet": [
             "Peru",
             "California",
             "Latin America",
             "South America",
             "United States"
         ],
         "media": [
             {
                 "type": "image",
                 "subtype": "photo",
                 "caption": "Checking a dead otter for bird flu infection last year on Chepeconde Beach in Peru.",
                 "copyright": "Sebastian Castaneda/Reuters",
                 "approved_for_syndication": 1,
                 "media-metadata": [
                     {
                         "url": "https://static01.nyt.com/images/2024/04/16/multimedia/00birdflu-mammals-01-zktq/00birdflu-mammals-01-zktq-thumbStandard.jpg",
                         "format": "Standard Thumbnail",
                         "height": 75,
                         "width": 75
                     },
                     {
                         "url": "https://static01.nyt.com/images/2024/04/16/multimedia/00birdflu-mammals-01-zktq/00birdflu-mammals-01-zktq-mediumThreeByTwo210.jpg",
                         "format": "mediumThreeByTwo210",
                         "height": 140,
                         "width": 210
                     },
                     {
                         "url": "https://static01.nyt.com/images/2024/04/16/multimedia/00birdflu-mammals-01-zktq/00birdflu-mammals-01-zktq-mediumThreeByTwo440.jpg",
                         "format": "mediumThreeByTwo440",
                         "height": 293,
                         "width": 440
                     }
                 ]
             }
         ],
         "eta_id": 0
     }
    ]
}
 */

struct ArticleResponse: Codable {
    let results: [ArticleModel]
}

struct ArticleModel: Codable {
    let uri: String
    let url: String
    let id, assetID: Int
    let source, publishedDate, updated, section: String
    let subsection, nytdsection, adxKeywords: String
    let byline, type, title, abstract: String


    enum CodingKeys: String, CodingKey {
        case uri, url, id
        case assetID = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated, section, subsection, nytdsection
        case adxKeywords = "adx_keywords"
        case byline, type, title, abstract
    }
}

struct ArticleParams: Encodable {
    let apiKey: String

    enum CodingKeys: String, CodingKey {
        case apiKey = "api-key"
    }
}
