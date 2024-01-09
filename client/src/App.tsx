import { useComponentValue } from "@dojoengine/react";
import { Entity } from "@dojoengine/recs";
import { useDojo } from "./DojoContext";
import { getEntityIdFromKeys } from "@dojoengine/utils";
import Basic from "./shaders/basic";
import { MixNode } from "./utils";

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

    let color_node = MixNode(shader);
     
    return (
        <>
            <Basic color={color_node}/>
        </>
    );
}

export default App;
