use cubit::f64::types::fixed::{Fixed, FixedTrait, ONE};
use cubit::f64::types::vec2::{Vec2, Vec2Trait};
use cubit::f64::types::vec3::{Vec3, Vec3Trait};

#[derive(Model, Drop, Serde)]
struct Node {
    #[key]
    id: u32,
    node_type: u8,
    args: Args
}

#[generate_trait]
impl NodeImpl of NodeTrait {
    fn fixed(id: u32, value: Fixed) -> Node {
        let node_type: u8 = NodeType::Fixed.into();
        let args = ArgsTrait::fixed(value);
        Node { id, node_type, args}
    }

    fn add(id: u32, args_type: ArgsType, a:u32, b:u32) -> Node{
        let node_type: u8 = NodeType::Add.into();
        let args = ArgsTrait::add(args_type, a, b);
        Node {id, node_type, args}
    }

    fn get_type(self: Node) -> NodeType {
        let t = self.node_type;
        if(t == 1) {return NodeType::Fixed;};
        if(t == 2) {return NodeType::Vec2;};
        if(t == 3) {return NodeType::Vec3;};
        if(t == 4) {return NodeType::Position;};
        if(t == 5) {return NodeType::Add;};
        if(t == 6) {return NodeType::Sub;};
        if(t == 7) {return NodeType::Length;};
        NodeType::None    
    }
}

#[derive(Drop, Copy, Serde, Introspect)]
enum NodeType {
    None,
    Fixed,
    Vec2,
    Vec3,
    Position,
    Add,
    Sub,
    Length
}

impl NodeTypeIntoU8 of Into<NodeType, u8> {
    fn into(self: NodeType) -> u8 {
        match self {
            NodeType::None => 0,
            NodeType::Fixed => 1,
            NodeType::Vec2 => 2,
            NodeType::Vec3 => 3,
            NodeType::Position => 4,
            NodeType::Add => 5,
            NodeType::Sub => 6,
            NodeType::Length => 7
        }
    }
}


#[derive(Drop, Copy, Serde, Introspect)]
enum ArgsType {
    None,
    Fixed,
    Vec2,
    Vec3,
    Position
}

impl ArgsTypeIntoU8 of Into<ArgsType, u8> {
    fn into(self: ArgsType) -> u8 {
        match self {
            ArgsType::None => 0,
            ArgsType::Fixed => 1,
            ArgsType::Vec2 => 2,
            ArgsType::Vec3 => 3,
            ArgsType::Position => 4,
        }
    }
}

#[derive(Copy, Drop, Serde, Introspect)]
struct Args {
    args_type: u8,
    a: Float,
    b: Float,
    c: Float
}

#[generate_trait]
impl ArgsImpl of ArgsTrait {
    fn fixed(f: Fixed) -> Args {
        let args_type: u8 = ArgsType::Fixed.into();
        
        let a = FloatTrait::new(f.mag, f.sign);
        return Args {args_type, a, b:FloatTrait::zero(), c:FloatTrait::zero()};
    }

    fn add(args_type: ArgsType, x: u32, y: u32) -> Args {
        let type_int: u8 = args_type.into();
        let a = FloatTrait::new(x.into(), true);
        let b = FloatTrait::new(y.into(), true);
        return Args {args_type: type_int, a, b, c:FloatTrait::zero()};
    }

    fn get_type(self: Args) -> ArgsType {
        let t = self.args_type;
        if(t == 1) {return ArgsType::Fixed;};
        if(t == 2) {return ArgsType::Vec2;};
        if(t == 3) {return ArgsType::Vec3;};
        if(t == 4) {return ArgsType::Position;};
        ArgsType::None
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