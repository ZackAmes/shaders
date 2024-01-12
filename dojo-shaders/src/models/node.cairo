use cubit::f64::types::fixed::{Fixed, FixedTrait, ONE};

#[derive(Model, Drop, Serde)]
struct Node {
    #[key]
    id: u32,
    node_type: NodeType,
    args: Args
}

#[derive(Drop, Copy, Serde, Introspect)]
enum NodeType {
    Float,
    Add,
    Sub
}

#[derive(Drop, Copy, Serde, Introspect)]
struct Float{
    mag: u64,
    sign: bool
}

#[derive(Copy, Drop, Serde, Introspect)]
struct Args {
    a: Float,
    b: Float,
    c: Float
}

#[generate_trait]
impl ArgsImpl of ArgsTrait {
    fn float(f: Float) -> Args {
        return Args {a:f, b:FloatTrait::zero(), c:FloatTrait::zero()};
    }
    fn add(x: u32, y: u32) -> Args {
        let a = FloatTrait::new(x.into(), true);
        let b = FloatTrait::new(y.into(), true);
        return Args {a, b, c:FloatTrait::zero()};
    }
}

#[generate_trait]
impl FloatImpl of FloatTrait {

    fn new(mag: u64, sign: bool) -> Float {
        Float{mag, sign}
    }

    fn zero() -> Float {
        Float{mag:0, sign:true}
    }

    fn toFixed(self: Float) -> Fixed {
        FixedTrait::new(self.mag, self.sign)
    }



}