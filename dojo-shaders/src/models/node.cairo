use cubit::f64::types::fixed::{Fixed, FixedTrait, ONE_u128};

#[derive(Drop, Copy)]
enum Node {
    Add: (Node, Node),
    Float: Fixed
}

#[generate_trait]
impl NodeImpl of NodeTrait {
    fn eval(ref self: Node) -> Fixed {
        match self {
            Node::Add((x,y)) => {
                let mut a = x;
                let mut b = y;
                let res = a.eval() + b.eval();
                res
            },
            Node::Float(f) => {
                f
            } 
        }
    }
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