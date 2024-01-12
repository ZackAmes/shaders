use cubit::f64::types::fixed::{Fixed};

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
    use dojo_shaders::models::sdf::{Sdf, SdfTrait};
    use dojo_shaders::models::node::{Node, NodeType, NodeTrait, Float, FloatTrait, FloatImpl, Args, ArgsTrait};
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

            let a = FixedTrait::new(2,true);
            let a_node = NodeTrait::fixed(world.uuid(), a);

            let b = FixedTrait::new(3, true);
            let b_node = NodeTrait::fixed(world.uuid(), b);
            

        //    let mut add_node = Node {id: world.uuid(), node_type: add_type, args: add_args};


    //        let sdf = SdfTrait::new(caller, sub_node.id);

            set!(world, (shader, a_node, b_node));

            
        }

        

    
    }

    #[generate_trait]
    impl Private of PrivateTrait {

        fn eval_node_fixed(self: @ContractState, node_id: u32) -> Node {
            let world = self.world_dispatcher.read();
            let mut node = get!(world, node_id, Node);

           
            node
            









        }


    }
}