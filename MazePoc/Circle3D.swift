//
//  Circle3D.swift
//  MazePoc
//
//  Created by Marcelo De Araújo on 30/03/23.
//

import SceneKit

class SphereNode3D: SCNNode {

    init(color: UIColor) {
        super.init()

        let sphereGeometry = SCNSphere()
        sphereGeometry.materials.first?.diffuse.contents = color

        self.geometry = sphereGeometry

        // Configuração da física do nó da esfera
        
        let physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: sphereGeometry, options: nil))
        
        physicsBody.mass = 4.5
        physicsBody.allowsResting = true
        physicsBody.isAffectedByGravity = true
        physicsBody.categoryBitMask = 1 // as categorias às quais um nó pertence e a quais categorias ele deve responder para colisões e outros eventos físicos.
        physicsBody.collisionBitMask = 1 // em quais nós devo esbarrar?
        physicsBody.contactTestBitMask = 1 // sobre quais colisões você deseja saber?

        self.physicsBody = physicsBody
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
