//
//  NotesViewController.swift
//  ARStudy
//
//  Created by Abdullah on 23/04/2020.
//  Copyright © 2020 Abdullah. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import RealmSwift

class NotesViewController: UIViewController, ARSCNViewDelegate {
    
    //MARK: - Properties
    
    let realm = try! Realm()
    
    var pageArray: Results<Page>?
    
    private let sceneView = ARSCNView()
    
    private lazy var addNotesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setDimensions(width: 50, height: 50)
        button.layer.cornerRadius = 25
        button.backgroundColor = .systemBackground
        let image = UIImage(systemName: "pencil.tip.crop.circle.badge.plus")
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDatabase()
        
        pageArray = realm.objects(Page.self)
        
        configureUI()
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let bookImagesToTrack = ARReferenceImage.referenceImages(inGroupNamed: "BookPages", bundle: Bundle.main) {
            configuration.trackingImages = bookImagesToTrack
            
            configuration.maximumNumberOfTrackedImages = 1
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.addSubview(sceneView)
        sceneView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        view.addSubview(addNotesButton)
        addNotesButton.anchor(bottom: view.bottomAnchor, right: view.rightAnchor, paddingBottom: 70, paddingRight: 20)
        addNotesButton.disable()
        
    }
    
    func configureDatabase() {
        //If app has launched for the first time add pages to database.
        //else pages are already present in database.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if (!appDelegate.hasAlreadyLaunched) {
           //first time launch.
            print("DEBUG: first time launch.")
            
            let page10 = Page()
            page10.title = "page-10"
            
            self.save(page: page10)
            
            let page11 = Page()
            page11.title = "page-11"
            
            self.save(page: page11)
        }
    }
    
    func save(page: Page) {
        
        do {
            try realm.write {
                realm.add(page)
            }
        } catch {
            print("Error saving context:  \(error)")
        }
        
    }
    
    //MARK: - Handlers
    
    @objc func addButtonTapped() {
        
        let controller = TypeNotesViewController()
        let nav = UINavigationController(rootViewController: controller )
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    //MARK: - ARRendering
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let bookImageAnchor = anchor as? ARImageAnchor else { return }
        
        let bookImageName = bookImageAnchor.referenceImage.name!
        
        DispatchQueue.main.async {
            self.pageArray = self.pageArray?.filter("title LIKE[c] %@", bookImageName)
            print("DEBUG: page is: \(self.pageArray![0].title)")
        }
        
        DispatchQueue.main.async {
            self.addNotesButton.enable()
        }
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()

        let text = SCNText(string: "testtext", extrusionDepth: 1)
        let material = SCNMaterial()

        material.diffuse.contents = UIColor.black
        text.materials = [material]

        let textNode = SCNNode(geometry: text)
        
        //moove text relative to current position.
        textNode.scale = SCNVector3(x: 0.3, y: 0.3, z: 0.3)
        
        let x = textNode.position.x
        let y = textNode.position.y
        let z = textNode.position.z
        
        textNode.position = SCNVector3(x-10, y, z-15)

        node.addChildNode(textNode)

        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        if node.isHidden {
            print("DEBUG: page removed")
            
            DispatchQueue.main.async {
                self.addNotesButton.disable()
                
                //fetch pages again as currently  it has filtered pages.
                self.pageArray = self.realm.objects(Page.self)
            }
            
            if let configuration = sceneView.session.configuration {
                sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                    node.removeFromParentNode()
                }
                sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
            }
        }
    }
    
 
}



