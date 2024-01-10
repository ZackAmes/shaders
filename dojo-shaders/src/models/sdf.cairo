use cubit::f64::types::fixed::{Fixed, FixedTrait};

use dojo_shaders::models::node::{Node, Float};

#[derive(Model, Drop, Serde)]
struct Sdf{
    #[key]
    owner: felt252,
    val: Float
}

#[generate_trait]
impl SdfImpl of SdfTrait {
    fn new(owner: felt252, val: Float) -> Sdf {
        Sdf {owner, val}
    }
}


