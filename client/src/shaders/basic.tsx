import { OrbitControls, PerspectiveCamera } from '@react-three/drei'
import { MeshBasicNodeMaterial, mix, positionLocal, sin, timerLocal, vec3, Node as GPUNode, ShaderNodeObject} from 'three/examples/jsm/nodes/Nodes.js'
import { WebGPUCanvas } from '../Canvas.tsx'
import { FC } from 'react'

interface BasicProps {
    color_one: ShaderNodeObject<GPUNode>;
    color_two: ShaderNodeObject<GPUNode>;
}

const material = new MeshBasicNodeMaterial()

const time = timerLocal(0.5)


const Basic: FC<BasicProps> = ({color_one, color_two}) => {



    material.colorNode = mix(color_one, color_two, sin(time))

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