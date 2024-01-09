import { useComponentValue } from "@dojoengine/react";
import { Entity } from "@dojoengine/recs";
import { useDojo } from "./DojoContext";
import { getEntityIdFromKeys } from "@dojoengine/utils";
import Basic from "./shaders/basic";
import { vec3 } from "three/examples/jsm/nodes/Nodes";

function App() {
    const {
        setup: {
            systemCalls: { spawn },
            components: { Shader },
        },
        account: {
            create,
            list,
            select,
            account,
            isDeploying,
            clear,
        },
    } = useDojo();

    
    // entity id we are syncing
    const entityId = getEntityIdFromKeys([BigInt(account.address)]) as Entity;

    // get current component values
    const shader = useComponentValue(Shader, entityId);
    let vec: {a: number, b:number, c:number} = shader ? shader.color_one : {a:0, b:0, c:0}; 
    let color_one = vec3(vec.a/255, vec.b/255, vec.c/255 );
    vec = shader ? shader.color_two : {a:0, b:0, c:0}; 

    let color_two = vec3(vec.a/255, vec.b/255, vec.c/255 );

    
    return (
        <>
            <Basic color_one={color_one} color_two={color_two}/>
        </>
    );
}

export default App;
