use cubit::f64::types::fixed::{Fixed};

#[starknet::interface]
trait IActions<TContractState> {
    fn spawn(self: @TContractState);
    fn eval(self: @TContractState, node_id: u32);
}

// dojo decorator
#[dojo::contract]
mod actions {
    use super::IActions;

    use starknet::{ContractAddress, get_caller_address};
    use dojo_shaders::models::shader::{Shader, ShaderTrait};
    use dojo_shaders::models::sdf::{Sdf, SdfTrait};
    use dojo_shaders::models::node::{Node, NodeType, NodeTrait, Float, FloatTrait, FloatImpl, Args,ArgsType, ArgsTrait};
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

            let mut add_node = NodeTrait::add(world.uuid(), ArgsType::Fixed, a_node.id, b_node.id);

            let sdf = SdfTrait::new(caller, add_node.id);

            set!(world, (shader, a_node, b_node, add_node, sdf));

            
        }

        fn eval(self: @ContractState, node_id: u32) {
            let world = self.world_dispatcher.read();

            let res = self.eval_node(node_id);

            set!(world, (res));
        }

    }

    #[generate_trait]
    impl Private of PrivateTrait {

        fn eval_node(self: @ContractState, node_id: u32) -> Node {

            let world = self.world_dispatcher.read();
            let mut node = get!(world, node_id, Node);
            let node_type = node.get_type();

            match node_type {
                // base types
                NodeType::None => {
                    node
                },
                NodeType::Fixed => {
                    node
                },
                NodeType::Vec2 => {
                    node
                },
                NodeType::Vec3 => {
                    node
                },
                NodeType::Position => {
                    node
                },
                //operations
                NodeType::Add => {
                    let mut a = get!(world, node.args.a, Node);
                    let mut b = get!(world, node.args.a, Node);
                    let mut a_args = a.args;
                    let mut b_args = b.args;
                    
                    if(!a.is_base()) {
                        a = self.eval_node(a.id);
                    }
                    if(!b.is_base()) {
                        b = self.eval_node(b.id);
                    }

                    match node.args.get_type() {
                        ArgsType::None => {
                            node
                        },
                        ArgsType::Fixed => {
                            let a_fixed = a_args.a.toFixed();
                            let b_fixed = b_args.a.toFixed();
                            let res = a_fixed + b_fixed;
                            NodeTrait::fixed(node.id, res) 
                        },
                        ArgsType::Vec2 => {
                            node
                        },
                        ArgsType::Vec3 => {
                            node
                        },
                        ArgsType::Position => {
                            node
                        }

                    }

                },
                NodeType::Sub => {
                    node
                },
                NodeType::Length => {
                    node
                }
            }
           









        }

        


    }
}