//
//  ViewModel.swift
//  BB Quotes
//
//  Created by 川口美咲 on 2024/04/13.
//

import Foundation

// UIの更新はメインスレッドで行う必要がある
@MainActor
// ObservableObject：オブジェクトのプロパティが変更されるとビューが自動的に更新される
class ViewModel: ObservableObject {
    // データ取得のプロセスの現在の状態
    enum Status {
        case notStarted
        case fetching
        case success(data: (quote: Quote, character: Character))
        case failed(error: Error)
    }
    
    // statusプロパティの変更を監視可能にしてビューに変更を通知する
    // private(set)：プロパティは外部から読み取り可能だが、書き込みはそのプロパティを持つクラスまたは構造体の内部からのみ許可される
    @Published private(set) var status: Status = .notStarted
    
    private let controller: FetchController
    
    // FetchController（外部データソースからデータを取得する役割を担う）型のインスタンスを受け取りこれを用いてデータの取得を行う
    init(anything: FetchController) {
        self.controller = anything
    }
    
    func getData(for show: String) async {
        status = .fetching
        
        do {
            let quote = try await controller.fetchQuote(from: show)
            let character = try await controller.fetchChacter(quote.character);
            status = .success(data: (quote, character))
        } catch {
            status = .failed(error: error)
        }
    }
}
