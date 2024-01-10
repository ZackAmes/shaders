
#[starknet::interface]
trait IActions<TContractState> {
    fn spawn(self: @TContractState);
}

// dojo decorator
#[dojo::contract]
mod actions {
    use super::IActions;

    use starknet::{ContractAddress, get_caller_address};
    use core::byte_array::{ByteArrayStringLiteral};
    use core::bytes_31::{Bytes31IntoFelt252};
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

            let shader = ShaderTrait::red(caller);

            set!(world, (shader));

            
        }

    }

    #[generate_trait]
    impl Private of PrivateTrait {
        
    }
}