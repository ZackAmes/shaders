// define the interface
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

    

    // impl: implement functions specified in trait
    #[external(v0)]
    impl ActionsImpl of IActions<ContractState> {
        // ContractState is defined by system decorator expansion
        fn spawn(self: @ContractState) {
            // Access the world dispatcher for reading.
            let world = self.world_dispatcher.read();

            // Get the address of the current caller, possibly the player's address.
            let caller:felt252 = get_caller_address().into();

            let basic_shader = ShaderTrait::basic(caller);

            set!(world, (basic_shader));

            
        }

    }

    #[generate_trait]
    impl Private of PrivateTrait {

    }
}
