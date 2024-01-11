
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

            let a: Float = FloatTrait::new(4,true);
            let node_type = NodeType::Float;
            let args = ArgsTrait::float(a);
            let b: Float = FloatTrait::new(2,true);

            let mut f1_node = Node{id: world.uuid(), node_type, args};
            let mut f2_node = Node{id: world.uuid(), node_type, args: ArgsTrait::float(b)};
            let one_id = f1_node.id;
            let one_mag = a.mag;
            println!("one id: {one_id}");
            println!("one val: {one_mag}");
            
            let add_type = NodeType::Add;
            let add_args = ArgsTrait::add(f1_node.id, f2_node.id);

            let mut add_node = Node {id: world.uuid(), node_type: add_type, args: add_args};

            let sdf = SdfTrait::new(caller, add_node.id);

            set!(world, (shader, sdf, f1_node, f2_node, add_node));

            
        }

    
    }

    #[generate_trait]
    impl Private of PrivateTrait {

        fn eval_node_fixed(self: @ContractState, ref node: Node) -> Fixed {
            let world = self.world_dispatcher.read();

            match node.node_type {
                NodeType::Float => {
                    node.args.a.toFixed()
                },

                NodeType::Add => {
                    let node_one_id = node.args.a.mag;
                    let node_two_id = node.args.b.mag;
                    let mut node_one = get!(world, node_one_id, Node);
                    let mut node_two = get!(world, node_two_id, Node);
                    let x: Fixed = self.eval_node_fixed(ref node_one);
                    let x_mag = x.mag;
                    println!("{x_mag}");
                    let y: Fixed = self.eval_node_fixed(ref node_two);

                    x+y

                }
            }
        }


    }
}