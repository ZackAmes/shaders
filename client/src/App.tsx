import { useComponentValue } from "@dojoengine/react";
import { Entity, getComponentValue } from "@dojoengine/recs";
import { useEffect, useState } from "react";
import { useDojo } from "./DojoContext";
import { Direction } from "./utils";
import { getEntityIdFromKeys } from "@dojoengine/utils";
import { Canvas } from "@react-three/fiber";
import { OrthographicCamera } from "@react-three/drei";
import Basic from "./shaders/basic";
import { shortString } from "starknet";

function App() {
    const {
        setup: {
            systemCalls: { spawn },
            components: { Shader, Manager },
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

    let color_data = [];
    let position_data = [];
    let color_manager_id = getEntityIdFromKeys([BigInt(0), BigInt(0)])
    let position_manager_id = getEntityIdFromKeys([BigInt(1), BigInt(0)])
    color_data.push(getComponentValue(Manager, color_manager_id)?.value);
    position_data.push(getComponentValue(Manager, position_manager_id)?.value);

    let test = shortString.decodeShortString(color_data[0]? color_data[0].toString() : "");
    console.log(test)
    console.log(position_data)
    
    return (
        <>
            <Basic/>
        </>
    );
}

export default App;
