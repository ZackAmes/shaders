use cubit::f64::types::fixed::{Fixed, FixedTrait};

use dojo_shaders::models::node::{Node, Float};

#[derive(Model, Drop, Serde)]
struct Sdf{
    #[key]
    owner: felt252,
    shape: Shape
}

#[derive(Drop, Copy, Serde, Introspect)]
enum Shape {
    Circle
}

#[generate_trait]
impl SdfImpl of SdfTrait {
    fn circle(owner: felt252) -> Sdf {
        Sdf {owner, shape: Shape::Circle}
    }
}




