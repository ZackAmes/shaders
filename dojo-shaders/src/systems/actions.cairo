
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
            let mut vertex: ByteArray = "void main() {	gl_Fragfrag = vec4( 1.0, 0.0, 0.0, 1.0 );}";
            let mut frag: ByteArray = "void main() {	gl_vertex = projectionMatrix * modelViewMatrix * vec4( vertex, 1.0 );}";

            self.create_shader(caller, @vertex, @frag);

            
        }

    }

    #[generate_trait]
    impl Private of PrivateTrait {
        
        fn create_shader(self: @ContractState, owner: felt252, vertex: @ByteArray, frag: @ByteArray) {
            let world = self.world_dispatcher.read();
            
            let vertex_data_len = vertex.data.len();
            let frag_data_len = frag.data.len(); 

            println!("vertex ByteArray has {vertex_data_len} felts");
            println!("frag ByteArray has {frag_data_len} felts");

            let mut shader = get!(world, owner, Shader);
            let mut i = 0;

            let data = vertex.pending_word;
            let manager = ManagerTrait::vertex(i.try_into().unwrap(), *data);
            shader.vertex_length+=1;
            set!(world, (manager));

            let data = frag.pending_word;
            let manager = ManagerTrait::frag(i.try_into().unwrap(), *data);
            shader.frag_length+=1;
            set!(world, (manager));

            if(vertex_data_len > 0){
                let mut vertex_data = vertex.data;
                loop {
                    if(i == vertex_data_len) {break;};
                        let temp = *vertex_data.at(i);
                        let manager = ManagerTrait::vertex(i.try_into().unwrap(), temp.into());

                        shader.vertex_length+=1;
                        set!(world, (manager));
                    i+=1;
                };
            }

            if(frag_data_len > 0){
                let mut frag_data = frag.data;
                loop {
                    if(i == frag_data_len) {break;};
                        let temp = *frag_data.at(i);
                        let manager = ManagerTrait::frag(i.try_into().unwrap(), temp.into());

                        shader.frag_length+=1;
                        set!(world, (manager));
                    i+=1;
                };
            }


            
            
            set!(world, (shader))
        }
    }
}