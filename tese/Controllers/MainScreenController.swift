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

class MainScreenController: UICollectionViewController {
    
    //MARK: - Properties
    
    let realm = try! Realm()
    
    var bookArray: Results<Book>?
    
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
        let image = UIImage(systemName: "line.horizontal.3")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(menuButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = APP_RED
    }
    
    //MARK: - Handlers
    
    @objc func addBooksTapped() {
        
    }
    
    @objc func menuButtonTapped() {
        
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

        return UIEdgeInsets(top: 10, left: leftInset, bottom: 0, right: rightInset)

    }
}
