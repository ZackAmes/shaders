use cubit::f64::types::fixed::{Fixed, FixedTrait, ONE};
use cubit::f64::types::vec2::{Vec2, Vec2Trait};
use cubit::f64::types::vec3::{Vec3, Vec3Trait};

#[derive(Model, Drop, Serde)]
struct Node {
    #[key]
    id: u32,
    node_type: NodeType,
    args: Args
}

#[generate_trait]
impl NodeImpl of NodeTrait {
    fn fixed(id: u32, value: Fixed) -> Node {
        let node_type = NodeType::Fixed;
        let args = ArgsTrait::fixed(value);
        Node { id, node_type, args}
    }
    fn add(id: u32, args_type: ArgsType, a:u32, b:u32) -> Node{
        let node_type = NodeType::Add;
        let args = ArgsTrait::add(args_type, a, b);
        Node {id, node_type, args}
    }
}

#[derive(Drop, Copy, Serde, Introspect)]
enum NodeType {
    Fixed,
    Vec2,
    Vec3,
    Add,
    Sub,
    Length
}

impl NodeTypeIntoFelt252 of Into<NodeType, felt252> {
    fn into(self: NodeType) -> felt252 {
        match self {
            NodeType::Fixed => 0,
            NodeType::Vec2 => 1,
            NodeType::Vec3 => 2,
            NodeType::Add => 3,
            NodeType::Sub => 4,
            NodeType::Length => 5
        }
    }
}


#[derive(Drop, Copy, Serde, Introspect)]
enum ArgsType {
    Fixed,
    Vec2,
    Vec3,
    Position
}

impl ArgsTypeIntoFelt252 of Into<ArgsType, felt252> {
    fn into(self: ArgsType) -> felt252 {
        match self {
            ArgsType::Fixed => 0,
            ArgsType::Vec2 => 1,
            ArgsType::Vec3 => 2,
            ArgsType::Position => 3,
        }
    }
}

#[derive(Copy, Drop, Serde, Introspect)]
struct Args {
    args_type: ArgsType,
    a: Float,
    b: Float,
    c: Float
}

#[generate_trait]
impl ArgsImpl of ArgsTrait {
    fn fixed(f: Fixed) -> Args {
        let args_type = ArgsType::Fixed;
        let a = FloatTrait::new(f.mag, f.sign);
        return Args {args_type, a, b:FloatTrait::zero(), c:FloatTrait::zero()};
    }

    fn add(args_type: ArgsType, x: u32, y: u32) -> Args {
        let a = FloatTrait::new(x.into(), true);
        let b = FloatTrait::new(y.into(), true);
        return Args {args_type, a, b, c:FloatTrait::zero()};
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

    fn zero() -> Float {
        Float{mag:0, sign:true}
    }

    fn toFixed(self: Float) -> Fixed {
        FixedTrait::new(self.mag, self.sign)
    }



}