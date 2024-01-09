import { OrbitControls, PerspectiveCamera, Box } from '@react-three/drei'
import { MeshBasicNodeMaterial, mix, sin, timerLocal, Node as GPUNode, ShaderNodeObject} from 'three/examples/jsm/nodes/Nodes.js'
import { WebGPUCanvas } from '../WebGPUCanvas.tsx'
import { FC } from 'react'
import { CuboidCollider, RigidBody } from '@react-three/rapier'

interface BasicProps {
    color: GPUNode
}

const material = new MeshBasicNodeMaterial()



const Basic: FC<BasicProps> = ({color}) => {

    material.colorNode = color;

    return (
        <WebGPUCanvas>
            <Box rotation={[0, 0,0]} args={[30, 1, 30]}>
                        <CuboidCollider rotation={[0, 0,0]} args={[15,.5,15]}/>
                        <meshBasicMaterial color="grey"/>
            </Box>

            <RigidBody>
                <mesh>
                    <boxGeometry />
                    <primitive attach="material" object={material} />
                </mesh>
            </RigidBody>

            <OrbitControls />
            <PerspectiveCamera position={[2, 1, 2]} makeDefault />
        </WebGPUCanvas>
    )
}

export default Basic;