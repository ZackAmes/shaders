
#[derive(Model, Drop, Serde)]
struct Shape {
    #[key]
    owner: felt252,
    sdf_root_id: u32,
    shader_root_id: u32
}

#[generate_trait]
impl ShapeImpl of ShapeTrait {
    fn new(owner: felt252, sdf_root_id: u32, shader_root_id: u32) -> Shape {
        Shape {owner, sdf_root_id, shader_root_id}
    }
}
