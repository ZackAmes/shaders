import { vec3 } from "three/examples/jsm/nodes/Nodes"
interface props {
        a: number,
        b: number,
        c: number
}
export const getColor = ( {a, b, c}: props ) => {

    return vec3(a/255, b/255, c/255)
}