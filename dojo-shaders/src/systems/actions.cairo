
#[starknet::interface]
trait IActions<TContractState> {
    fn spawn(self: @TContractState);
}

// dojo decorator
#[dojo::contract]
mod actions {
    use super::IActions;

    use starknet::{ContractAddress, get_caller_address};
    use dojo_shaders::models::shader::{Shader, ShaderTrait};
    use dojo_shaders::models::sdf::{Sdf, SdfTrait,  Shape};
    use dojo_shaders::models::node::{Node, NodeType, Float, FloatTrait, FloatImpl, Args, ArgsTrait};
    use cubit::f64::types::{fixed::{Fixed, FixedTrait}, vec2::{Vec2, Vec2Trait} };

    

    // impl: implement functions specified in trait
    #[external(v0)]
    impl ActionsImpl of IActions<ContractState> {
        // ContractState is defined by system decorator expansion
        fn spawn(self: @ContractState) {
            // Access the world dispatcher for reading.
            let world = self.world_dispatcher.read();

            // Get the address of the current caller, possibly the player's address.
            let caller:felt252 = get_caller_address().into();

            let shader = ShaderTrait::red(caller);
            let sdf = SdfTrait::circle(caller);

            let a: Float = FloatTrait::new(4,true);
            let node_type = NodeType::Float;
            let args = ArgsTrait::float(a);
            let mut node = Node{id: world.uuid(), node_type, args};
            
            let res = a.mag;
            println!("{res}");


            set!(world, (shader, sdf, node));

            
        }

        

    }

    #[generate_trait]
    impl Private of PrivateTrait {
    }
}