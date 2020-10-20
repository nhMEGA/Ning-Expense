//
//  CurrencyConverter.swift
//  Ning-Expense
//
//  Created by Ning Huang on 16/10/20.
//

import Foundation

struct Rate: Codable {
    let quotes: Quote
}

struct Quote: Codable {
    let USDNZD: Float
}


protocol CurrencyConverterDelegate {
    func didSaveTransaction(_ currencyRate: Float)
    func didFailWithError(error: Error)
}

struct CurrencyConverter {
    let baseURL = "http://api.currencylayer.com/live?&currencies=NZD&access_key="
    let apiKey = "ca4dc9fa0e9bb3e321819bf90709b023"
    var delegate: CurrencyConverterDelegate?
    
    func getRate() {
        let urlString = "\(baseURL)?apikey=\(apiKey)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let rate = self.parseJSON(safeData) {
                        self.delegate?.didSaveTransaction(rate)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ currencyRate: Data) -> Float? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Rate.self, from: currencyRate)
            let rate = decodedData.quotes.USDNZD
            return rate
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
