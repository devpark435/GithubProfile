//
//  MarkdownViewController.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

import UIKit
import MarkdownView

class MarkdownViewController: UIViewController {
    
    let markdownView = MarkdownView().then{
        $0.isScrollEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(markdownView)
        setMarkdownViewConstraints()
        
        // MarkdownView 설정
        loadData()
        setMarkdownView()
    }
    func setMarkdownView(){
        markdownView.frame = view.bounds
        markdownView.isScrollEnabled = true
        view.addSubview(markdownView)
        setMarkdownViewConstraints()
    }
    func setMarkdownViewConstraints() {
        markdownView.translatesAutoresizingMaskIntoConstraints = false
        markdownView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        markdownView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        markdownView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        markdownView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    func loadData() {
        GetUserData.shared.getUserMd { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let readmeResponse):
                let markdownText = self.decodeBase64(readmeResponse.content)
                DispatchQueue.main.async {
                    self.markdownView.load(markdown: markdownText)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    // Base64 디코딩 함수
    func decodeBase64(_ base64String: String) -> String {
        guard let data = Data(base64Encoded: base64String) else {
            return ""
        }
        return String(data: data, encoding: .utf8) ?? ""
    }
}
