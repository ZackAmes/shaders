import { useComponentValue } from "@dojoengine/react";
import { Entity } from "@dojoengine/recs";
import { useEffect, useState } from "react";
import { useDojo } from "./DojoContext";
import { Direction } from "./utils";
import { getEntityIdFromKeys } from "@dojoengine/utils";
import { Canvas } from "@react-three/fiber";
import { OrthographicCamera } from "@react-three/drei";
import Basic from "./shaders/basic";

function App() {
    const {
        setup: {
            systemCalls: { spawn, move },
            components: { Moves, Position },
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
    const position = useComponentValue(Position, entityId);
    const moves = useComponentValue(Moves, entityId);

    
    return (
        <>
            <Basic/>
        </>
    );
}

export default App;
