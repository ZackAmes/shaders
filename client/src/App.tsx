import { useComponentValue } from "@dojoengine/react";
import { Entity, getComponentValue } from "@dojoengine/recs";
import { useEffect, useState } from "react";
import { useDojo } from "./DojoContext";
import { getEntityIdFromKeys } from "@dojoengine/utils";
import { Canvas } from "@react-three/fiber";
import { OrthographicCamera } from "@react-three/drei";
import Basic from "./shaders/basic";
import { shortString } from "starknet";
import { getColor } from "./utils";

function App() {
    const {
        setup: {
            systemCalls: { spawn },
            components: { Shader},
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
    console.log(shader);
    let color_vec: {a: number, b:number, c:number} = shader ? shader.color_one : {a:0, b:0, c:0}; 
    let color_one = getColor(color_vec);
    color_vec = shader ? shader.color_two : {a:0, b:0, c:0}; 

    let color_two = getColor(color_vec);
    console.log(color_one);


    
    return (
        <>
            <Basic color_one={color_one} color_two={color_two}/>
        </>
    );
}

export default App;
