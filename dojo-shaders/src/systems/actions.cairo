use cubit::f64::types::fixed::{Fixed};

#[starknet::interface]
trait IActions<TContractState> {
    fn spawn(self: @TContractState);
    fn eval_node_fixed(self: @TContractState, node_id: u32) -> Fixed;
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


            let sub_type = NodeType::Sub;
            let sub_args = ArgsTrait::add(f1_node.id, f2_node.id);

            let mut sub_node = Node {id: world.uuid(), node_type: sub_type, args: sub_args};

            let sdf = SdfTrait::new(caller, sub_node.id);

            set!(world, (shader, sdf, f1_node, f2_node, sub_node, add_node));

            
        }

        fn eval_node_fixed(self: @ContractState, node_id: u32) -> Fixed {
            let world = self.world_dispatcher.read();
            let mut node = get!(world, node_id, Node);

            match node.node_type {
                NodeType::Float => {
                    node.args.a.toFixed()
                },

                NodeType::Add => {
                    let node_one_id: u32 = node.args.a.mag.try_into().unwrap();
                    let node_two_id: u32 = node.args.b.mag.try_into().unwrap();

                    let x: Fixed = self.eval_node_fixed(node_one_id);
                    let x_mag = x.mag;
                    println!("{x_mag}");
                    let y: Fixed = self.eval_node_fixed(node_two_id);

                    x+y

                },

                NodeType::Sub => {
                    let node_one_id: u32 = node.args.a.mag.try_into().unwrap();
                    let node_two_id: u32 = node.args.b.mag.try_into().unwrap();

                    let x: Fixed = self.eval_node_fixed(node_one_id);
                    let x_mag = x.mag;
                    println!("{x_mag}");
                    let y: Fixed = self.eval_node_fixed(node_two_id);

                    let y_mag = y.mag;
                    println!("{y_mag}");

                    x-y
                }

            }
        }

    
    }

    #[generate_trait]
    impl Private of PrivateTrait {

        


    }
}