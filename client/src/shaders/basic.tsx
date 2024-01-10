import { OrbitControls, PerspectiveCamera, Box } from '@react-three/drei'
import { MeshBasicNodeMaterial, ShaderNodeObject,mul,cond, Node, sub, vec2, vec3, positionLocal, uv, length, greaterThan} from 'three/examples/jsm/nodes/Nodes.js'
import { WebGPUCanvas } from '../WebGPUCanvas.tsx'
import { FC } from 'react'

interface BasicProps {
    color: ShaderNodeObject<Node>
}

const material = new MeshBasicNodeMaterial()



const Basic: FC<BasicProps> = ({color}) => {

    const sd = (p:any, r:any) => {
        return sub(length(p), r);
    }

    let uv0 = positionLocal;
    let d = sd(uv0.xy, .5);

    material.colorNode = cond(d.greaterThan(0), mul(d , color), vec3(0,0,1));

    return (
        <WebGPUCanvas>

                <mesh >
                    <planeGeometry args={[3,3]}/>
                    <primitive attach="material" object={material} />
                </mesh>

            <OrbitControls />
            <PerspectiveCamera position={[2, 3, 4]} makeDefault />
        </WebGPUCanvas>
    )
}

export default Basic;