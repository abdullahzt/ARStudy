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

class NotesViewController: UIViewController, ARSCNViewDelegate {
    
    //MARK: - Properties
    
    private let sceneView = ARSCNView()
    
    private var textNode = SCNNode()
    
    private var bookImageNode = SCNNode()
    
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
            
            configuration.maximumNumberOfTrackedImages = 2
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
        
        print("DEBUG: page is \(bookImageAnchor.referenceImage.name!)")
        
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



