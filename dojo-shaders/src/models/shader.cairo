#[derive(Model, Drop, Serde)]
struct Shader {
    #[key]
    owner: felt252,
    vertex_length: u8,
    frag_length: u8
}

#[derive(Model, Drop, Serde)]
struct Manager {
    #[key]
    manager_type: u8,
    #[key]
    index: u8,
    value: felt252
}

#[generate_trait]
impl ManagerImpl of ManagerTrait {
    fn vertex(index: u8, value: felt252) -> Manager{
        Manager { manager_type: 0, index, value}
    }

    fn frag(index: u8, value: felt252) -> Manager {
        Manager {manager_type:1, index, value}
    }
}

#[derive(Copy, Drop, Serde, Introspect)]
struct Vec3 {
    a: u8,
    b: u8,
    c: u8
}

//condition = 0 for sin(t) for now

#[generate_trait]
impl ShaderImpl of ShaderTrait {
    fn basic(owner: felt252 ) -> Shader {
        Shader { owner, vertex_length:0, frag_length:0}
    }
}

#[generate_trait]
impl Vec3Impl of Vec3Trait {
    fn new(a: u8, b:u8, c:u8) -> Vec3{
        Vec3 {a,b,c}    
    }
}

