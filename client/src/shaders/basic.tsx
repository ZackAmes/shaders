import { OrbitControls, PerspectiveCamera, Box } from '@react-three/drei'
import { MeshBasicNodeMaterial, uv, sub,mul, length, Node as GPUNode, ShaderNodeObject, vec3} from 'three/examples/jsm/nodes/Nodes.js'
import { WebGPUCanvas } from '../WebGPUCanvas.tsx'
import { FC } from 'react'
import { CuboidCollider, RigidBody } from '@react-three/rapier'

interface BasicProps {
}

const material = new MeshBasicNodeMaterial()



const Basic: FC<BasicProps> = ({}) => {

    let red = vec3(1,0,0)
    let blue = vec3(0,0,1)
    let uv0 = uv()
    console.log(uv0.xy)
    let colorNode = parseInt(length(uv0).toString()) > 0 ? red : blue; 
    material.colorNode = colorNode
    console.log(material.fragmentShader )
    console.log(material.vertexShader)



    return (
        <WebGPUCanvas>

                <mesh>
                    <planeGeometry args={[3,3]}/>
                    <primitive attach="material" object={material} />
                </mesh>

            <OrbitControls />
            <PerspectiveCamera position={[2, 3, 4]} makeDefault />
        </WebGPUCanvas>
    )
}

export default Basic;