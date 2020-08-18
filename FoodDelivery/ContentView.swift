//
//  ContentView.swift
//  FoodDelivery
//
//  Created by Ahmad Maulana on 11/08/20.
//  Copyright © 2020 Ahmad Maulana. All rights reserved.
//

import SwiftUI

class FoodViewController: UICollectionViewController {

    private let cellID = "cellID"
    private let headerID = "headerID"
    static let categoryHeaderID = "categoryHeaderID"

    private let topHeaderID = "topHeaderID"
    static let topCategoryHeaderID = "topCategoryHeaderID"
    private let moviesCategoryID = "moviesCategory"
    static let moviesCategoryHeaderID = "moviesCategoryHeaderID"

    var topCategoryImage = ["1","2","3","4","5","6"]
    var topCategoryName = ["Pizza","Steak","Burger","Pasta","Sushi","Salad"]

    init() {
        super.init(collectionViewLayout: FoodViewController.createLayout())
    }

    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 2

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(400)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)

                section.orthogonalScrollingBehavior = .paging

                return section
            } else if sectionNumber == 1 {
                let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(136), heightDimension: .absolute(95)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.leading = 16
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: topCategoryHeaderID, alignment: .topLeading)
                ]
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(300)))
                item.contentInsets.bottom = 16
                item.contentInsets.trailing = 8
                item.contentInsets.leading = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: moviesCategoryHeaderID, alignment: .topLeading)
                ]
                return section
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        navigationItem.title = "Food Delivery"

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(UINib(nibName: "TopCategoryCell", bundle: nil), forCellWithReuseIdentifier: "TopCategoryCell")
        collectionView.register(HeaderCategory.self, forSupplementaryViewOfKind: FoodViewController.categoryHeaderID, withReuseIdentifier: headerID)
        collectionView.register(TopHeaderCategory.self, forSupplementaryViewOfKind: FoodViewController.topCategoryHeaderID, withReuseIdentifier: topHeaderID)
        collectionView.register(UINib(nibName: "MoviesHeaderCategory", bundle: nil), forSupplementaryViewOfKind: FoodViewController.moviesCategoryHeaderID, withReuseIdentifier: moviesCategoryID)

    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: topHeaderID, for: indexPath)

            return header
        } else if indexPath.section == 2 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: moviesCategoryID, for: indexPath)

            return header
        } else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath)

            return header
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return topCategoryImage.count
        }
        return 8
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCategoryCell", for: indexPath) as! TopCategoryCell
            cell.itemImageView.image = UIImage(named: topCategoryImage[indexPath.row])
            cell.nameLbl.text = topCategoryName[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            cell.backgroundColor = .blue
            return cell
        }

    }
}

class HeaderCategory: UICollectionReusableView {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.text = "Categories"
        label.font = UIFont(name: "Poppins-SemiBold", size: 16.0)
        
        addSubview(label)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TopHeaderCategory: UICollectionReusableView {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.font = UIFont(name: "Poppins-SemiBold", size: 16.0)
        label.text = "Top Categories"

        addSubview(label)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MoviesHeaderCategory: UICollectionReusableView {

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }

    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            UINavigationController(rootViewController: FoodViewController())

        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

        }

        typealias UIViewControllerType = UIViewController
    }
}

extension UIView {
    func roundUpCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
