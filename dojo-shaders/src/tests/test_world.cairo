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
        models::{shader::{shader, Shader}, sdf::{sdf, Sdf, Shape}, node::{Node, NodeTrait, NodeImpl, Float}}
    };


    use cubit::f64::types::{fixed::{Fixed, FixedTrait, ONE}, vec2::{Vec2, Vec2Trait} };


    #[test]
    #[available_gas(30000000)]
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
    
    }

    #[test]
    #[available_gas(30000000)]
    fn test_node() {
        let a = FixedTrait::new( ONE, true);
        let b = FixedTrait::new( 3 * ONE, true);

        let b_mag = b.mag;
        println!("{b_mag}");

        let mut node = Node::Add((Node::Float(a), Node::Float(b)));
    }
}
