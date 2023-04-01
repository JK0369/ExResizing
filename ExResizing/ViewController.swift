//
//  ViewController.swift
//  ExResizing
//
//  Created by 김종권 on 2023/04/01.
//

import UIKit

class ViewController: UIViewController {
    private let someImageView: UIImageView = {
        let view = UIImageView()
        let resizedImage = UIImage(named: "img")?.resize(targetSize: .init(width: 200, height: 200))
        view.image = resizedImage
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(someImageView)
        NSLayoutConstraint.activate([
            someImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            someImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

extension UIImage {
    func resize(targetSize: CGSize) -> UIImage? {
        // 1. context를 획득 (사이즈, 투명도, scale 입력)
        // scale의 값이 0이면 현재 화면 기준으로 scale을 잡고, sclae의 값이 1이면 self(이미지) 크기 기준으로 설정
        UIGraphicsBeginImageContextWithOptions(targetSize, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.interpolationQuality = .high
        
        // 2. 그리기
        let newRect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        draw(in: newRect)
        
        // 3. 그려진 이미지 가져오기
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 4. context 종료
        UIGraphicsEndImageContext()
        return newImage
    }
}
