#[cfg(test)]
mod tests {
    use starknet::class_hash::Felt252TryIntoClassHash;
    use array::ArrayTrait;
    use core::debug::PrintTrait;

    // import world dispatcher
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

    // import test utils
    use dojo::test_utils::{spawn_test_world, deploy_contract};

    // import test utils
    use dojo_shaders::{
        systems::{actions::{actions, IActionsDispatcher, IActionsDispatcherTrait}},
        models::{shader::{shader, Shader}, sdf::{sdf, Sdf, SdfTrait}, node::{Node, Float, FloatTrait}}
    };


    use cubit::f64::types::{fixed::{Fixed, FixedTrait, ONE}, vec2::{Vec2, Vec2Trait} };


    #[test]
    #[available_gas(30000000000)]
    fn test_move() {
        // caller
        let caller = starknet::contract_address_const::<0x0>();

        // models
        let mut models = array![shader::TEST_CLASS_HASH];

        // deploy world with models
        let world = spawn_test_world(models);

        // deploy systems contract
        let contract_address = world
            .deploy_contract('salt', actions::TEST_CLASS_HASH.try_into().unwrap());
        let actions_system = IActionsDispatcher { contract_address };

        // call spawn()
        actions_system.spawn();

        let shader = get!(world, caller, Shader);
        let sdf = get!(world, caller, Sdf);

        let root = get!(world, sdf.root_id, Node);

        let root_type = root.node_type;
        let root_args_type = root.args.args_type;

        println!("type: {root_type}, args_type: {root_args_type}");

        actions_system.eval(root.id);

        let root = get!(world, sdf.root_id, Node);

        let root_type = root.node_type;
        let root_args_type = root.args.args_type;
        let res = root.args.a.mag;

        println!("type: {root_type}, args_type: {root_args_type}");
        println!("res: {res}");


        
    
    }

}
