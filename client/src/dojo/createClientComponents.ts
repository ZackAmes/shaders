import { overridableComponent } from "@dojoengine/recs";
import { SetupNetworkResult } from "./setupNetwork";

export type ClientComponents = ReturnType<typeof createClientComponents>;

export function createClientComponents({
    contractComponents,
}: SetupNetworkResult) {
    return {
        ...contractComponents,
        Shader: overridableComponent(contractComponents.Shader),
        Node: overridableComponent(contractComponents.Node),
        Sdf: overridableComponent(contractComponents.Sdf)
    };
}
