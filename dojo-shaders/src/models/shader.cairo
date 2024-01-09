#[derive(Model, Drop, Serde)]
struct Shader {
    #[key]
    owner: felt252,
    color_one: Vec3,
    color_two: Vec3
}

#[derive(Copy, Drop, Serde, Introspect)]
struct Vec3 {
    a: u8,
    b: u8,
    c: u8
}

#[generate_trait]
impl ShaderImpl of ShaderTrait {
    fn basic(owner: felt252 ) -> Shader {
        Shader {
            owner, 
            color_one: Vec3Trait::new(255,0,0),
            color_two: Vec3Trait::new(0,0,255)
        }
    }
}

#[generate_trait]
impl Vec3Impl of Vec3Trait {
    fn new(a: u8, b:u8, c:u8) -> Vec3{
        Vec3 {a,b,c}    
    }
}

