use cubit::f64::types::fixed::{Fixed, FixedTrait, ONE_u128};

#[derive(Drop)]
enum Node {
    None,
    Length: Node,
    Add: (Node, Node),
    Sub: (Node, Node),
    Float: Float
}

#[derive(Drop, Copy, Serde, Introspect)]
struct Float{
    mag: u64,
    sign: bool
}

#[generate_trait]
impl FloatImpl of FloatTrait {

    fn new(mag: u64, sign: bool) -> Float {
        Float{mag, sign}
    }

    fn toFixed(self: Float) -> Fixed {
        FixedTrait::new(self.mag, self.sign)
    }

}