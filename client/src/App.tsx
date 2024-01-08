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
           {"(" + position?.vec.x + "," + position?.vec.y + ")"}
           <Canvas>
            <Basic />
            <OrthographicCamera
                makeDefault
                manual
                top={1}
                bottom={0}
                left={0}
                right={1}
                near={0.1}
                far={1000}
                position={[0, 0, 0.5]}
            />
        </Canvas>
        </>
    );
}

export default App;
