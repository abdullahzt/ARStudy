//
//  MainScreenController.swift
//  ARStudy
//
//  Created by Abdullah on 04/05/2020.
//  Copyright © 2020 Abdullah. All rights reserved.
//

import UIKit
import RealmSwift
import Motion

private let reuseIdentifier = "BookCell"

protocol HomeControllerDelegate {
    func menuButtonTapped()
}

class MainScreenController: UICollectionViewController {
    
    //MARK: - Properties
    
    let realm = try! Realm()
    
    var bookArray: Results<Book>?
    
    var isExpanded = false
    
    var delegate: HomeControllerDelegate?
    
    private lazy var addBooksButton: UIButton = {
        let button = UIButton(type: .system)
        button.setDimensions(width: 55, height: 55)
        button.layer.cornerRadius = 27.5
        button.backgroundColor = APP_RED
        let image = UIImage(systemName: "plus")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addBooksTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleMenuDismissal))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isMotionEnabled = true
        
        bookArray = realm.objects(Book.self).sorted(byKeyPath: "title", ascending: true)
        
        configureUI()
        configureDatabase()
        
        configureNavigationButton()
        
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: APP_RED]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        view.backgroundColor = .white
        self.title = "Books"
        
        collectionView.register(BookCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        
        view.addSubview(addBooksButton)
        addBooksButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 20, paddingRight: 20)
        
    }
    
    func configureDatabase() {
        //If app has launched for the first time add pages to database.
        //else pages are already present in database.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if (!appDelegate.hasAlreadyLaunched) {
            //first time launch.
            print("DEBUG: first time launch.")
            
            let book = Book()
            book.title = "IGCSE Biology"
            book.IBAN = "978-0-521-14779-8"
            self.save(book: book)
            
            let page10 = Page()
            page10.title = "page-10"
            
            let page11 = Page()
            page11.title = "page-11"
            
            do {
                try realm.write {
                    book.pages.append(page10)
                    book.pages.append(page11)
                }
            } catch {
                print("Error saving context:  \(error)")
            }
            
        }
    }
    
    func save(book: Book) {
        
        do {
            try realm.write {
                realm.add(book)
            }
        } catch {
            print("Error saving context:  \(error)")
        }
        
    }
    
    func configureNavigationButton() {
        
        let menuButton = UIButton(type: .custom)
        menuButton.setImage(#imageLiteral(resourceName: "multimedia-2").withTintColor(APP_RED), for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        
        let title = UILabel()
        title.text = "Books"
        title.textAlignment = .center
        let font = UIFont(name: "BetmRounded-SemiBold", size: 24)
        title.font = font
        title.textColor = APP_RED
        
        view.addSubview(title)
        title.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 23)

        view.addSubview(menuButton)
        menuButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 20, width: 25, height: 25)

    }
    
    //MARK: - Handlers
    
    @objc func addBooksTapped() {
        
    }
    
    @objc func menuButtonTapped() {
        
        view.addSubview(blackView)
        blackView.frame = view.frame

        UIView.animate(withDuration: 0.3) {
            let value = self.isExpanded ? 0 : 1
            self.blackView.alpha = CGFloat(value)
        }

        isExpanded = !isExpanded
        
        delegate?.menuButtonTapped()
    }
    
    @objc func handleMenuDismissal() {
        
        UIView.animate(withDuration: 0.3) {
            let value = self.isExpanded ? 0 : 1
            self.blackView.alpha = CGFloat(value)
        }
        
        isExpanded = !isExpanded
        
        delegate?.menuButtonTapped()
        
    }
    
}

//MARK: - UICollectionViewDataSource

extension MainScreenController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookArray?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BookCell
        
        cell.book = bookArray?[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let book = bookArray?[indexPath.row] else { return }
        
        let controller = MainTabBarController(book: book)
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MainScreenController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let leftInset = CGFloat(10)
        let rightInset = leftInset

        return UIEdgeInsets(top: 65, left: leftInset, bottom: 0, right: rightInset)

    }
}
