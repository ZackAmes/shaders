
#[derive(Model, Drop, Serde)]
struct Shader {
    #[key]
    owner: felt252,
    color: Vec3
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
    fn red(owner: felt252 ) -> Shader {
        Shader { owner, color: Vec3Trait::new(255,0,0)}
    }
    fn blue(owner: felt252) -> Shader {
        Shader {owner, color: Vec3Trait::new(0,0,255)}
    }
}

#[generate_trait]
impl Vec3Impl of Vec3Trait {
    fn new(a: u8, b:u8, c:u8) -> Vec3{
        Vec3 {a,b,c}    
    }
}

