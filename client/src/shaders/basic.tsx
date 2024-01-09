import { OrbitControls, PerspectiveCamera } from '@react-three/drei'
import { MeshBasicNodeMaterial, mix, sin, timerLocal, Node as GPUNode, ShaderNodeObject} from 'three/examples/jsm/nodes/Nodes.js'
import { WebGPUCanvas } from '../WebGPUCanvas.tsx'
import { FC } from 'react'

interface BasicProps {
    color: GPUNode
}

const material = new MeshBasicNodeMaterial()



const Basic: FC<BasicProps> = ({color}) => {

    material.colorNode = color;

    return (
        <WebGPUCanvas>
            <mesh>
                <boxGeometry />
                <primitive attach="material" object={material} />
            </mesh>

            <OrbitControls />
            <PerspectiveCamera position={[2, 1, 2]} makeDefault />
        </WebGPUCanvas>
    )
}

export default Basic;