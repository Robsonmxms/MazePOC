//
//  Circle3D.swift
//  MazePoc
//
//  Created by Marcelo De Araújo on 30/03/23.
//

import SceneKit

class SphereSCNNode: SCNNode {

    init(color: UIColor) {
        super.init()

        let sphereGeometry = SCNSphere(radius: 1)
        sphereGeometry.materials.first?.diffuse.contents = color

        self.geometry = sphereGeometry
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
