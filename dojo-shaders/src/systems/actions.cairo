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
    use bytes_31::{Bytes31IntoFelt252};
    use dojo_shaders::models::shader::{Shader, Manager, ManagerTrait};

    

    // impl: implement functions specified in trait
    #[external(v0)]
    impl ActionsImpl of IActions<ContractState> {
        // ContractState is defined by system decorator expansion
        fn spawn(self: @ContractState) {
            // Access the world dispatcher for reading.
            let world = self.world_dispatcher.read();

            // Get the address of the current caller, possibly the player's address.
            let caller:felt252 = get_caller_address().into();
            let mut color: ByteArray = "mix(red, blue, sin(time))";
            let mut position: ByteArray = "positionLocal.add(vec3(0, sin(time).mul(0.2), 0))";

            self.create_shader(caller, @color, @position);

            
        }

    }

    #[generate_trait]
    impl Private of PrivateTrait {
        
        fn create_shader(self: @ContractState, owner: felt252, color: @ByteArray, position: @ByteArray) {
            let world = self.world_dispatcher.read();
            
            let color_data_len = color.data.len();
            let position_data_len = position.data.len();

            println!("color ByteArray has {color_data_len} felts");
            println!("position ByteArray has {position_data_len} felts");

            let mut shader = get!(world, owner, Shader);
            let mut i = 0;

            let data = *color.pending_word;
            let manager = ManagerTrait::color(i.try_into().unwrap(), data);
            shader.color_length+=1;
            set!(world, (manager));

            let data = *position.pending_word;
            let manager = ManagerTrait::position(i.try_into().unwrap(), data);
            shader.position_length+=1;
            set!(world, (manager));

            if(color_data_len > 0){
                loop {
                    if(i == color_data_len) {break;};
                        let data = *color.data.at(i).into();
                        let manager = ManagerTrait::color(i.try_into().unwrap(), data.into());
                        shader.color_length+=1;
                        set!(world, (manager));
                    i+=1;
                };
                }

            loop {
                if(i == position_data_len) {break;};
                    let data = *position.data.at(i).into();
                    let manager = ManagerTrait::position(i.try_into().unwrap(), data.into());
                    shader.position_length+=1;
                    set!(world, (manager));
                i+=1;
            };
            
            set!(world, (shader))
        }
    }
}
