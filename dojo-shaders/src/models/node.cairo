use cubit::f64::types::fixed::{Fixed, FixedTrait, ONE};

#[derive(Model, Drop, Serde)]
struct Node {
    #[key]
    id: u32,
    node_type: NodeType
}

#[derive(Drop, Copy, Serde, Introspect)]
enum NodeType {
    Float: FloatVec3,
    Add: FloatVec3,

}

#[derive(Drop, Copy, Serde, Introspect)]
enum Args {
    None,
    One,
    Two,
    Three
}

#[derive(Drop, Copy, Serde, Introspect)]
struct Float{
    mag: u64,
    sign: bool
}


#[derive(Copy, Drop, Serde, Introspect)]
struct FloatVec3 {
    args: Args,
    a: Float,
    b: Float,
    c: Float
}

#[generate_trait]
impl floatvec3Impl of FloatVec3Trait {
    fn float(f: Float) -> FloatVec3 {
        let args = Args::One;
        return FloatVec3 {args, a:f, b:FloatTrait::zero(), c:FloatTrait::zero()};
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