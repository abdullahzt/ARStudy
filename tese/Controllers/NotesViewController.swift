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
    
    private lazy var addNotesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setDimensions(width: 50, height: 50)
        button.layer.cornerRadius = 25
        button.backgroundColor = .systemBackground
        let image = UIImage(systemName: "pencil.tip.crop.circle.badge.plus")
        button.setImage(image, for: .normal)
        button.tintColor = .black
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
    
    //MARK: - ARRendering
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let bookImageAnchor = anchor as? ARImageAnchor else { return }
        
        print(bookImageAnchor.referenceImage.name!)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if node.isHidden {
            print("page removed")
            if let configuration = sceneView.session.configuration {
                sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                    node.removeFromParentNode()
                }
                sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
            }
        }
    }
}



