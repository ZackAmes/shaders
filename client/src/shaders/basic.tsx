import { OrbitControls, PerspectiveCamera, Box } from '@react-three/drei'
import { MeshBasicNodeMaterial, ShaderNodeObject, Node, vec3, uv, length} from 'three/examples/jsm/nodes/Nodes.js'
import { WebGPUCanvas } from '../WebGPUCanvas.tsx'
import { FC } from 'react'

interface BasicProps {
    color: ShaderNodeObject<Node>
}

const material = new MeshBasicNodeMaterial()



const Basic: FC<BasicProps> = ({color}) => {

    
    material.colorNode = color

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