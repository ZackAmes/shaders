use dojo_shaders::tsl::types::float::{Float, FloatTrait};

use cubit::f64::types::{
    fixed::{Fixed, FixedTrait, ONE},
    vec2::{Vec2, Vec2Trait},
    vec3::{Vec3, Vec3Trait}
};

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
            ArgsType::Position => 4
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

    fn vec2(v: Vec2) -> Args {
        let args_type: u8 = ArgsType::Vec2.into();
        let a = FloatTrait::fromFixed(v.x);
        let b = FloatTrait::fromFixed(v.y);
        let c = FloatTrait::zero();

        Args {args_type, a, b ,c}
    }

    //for operations that have the ids for 2 subnodes
    fn two_ids(args_type: ArgsType, x: u32, y: u32) -> Args {
        let type_int: u8 = args_type.into();
        let a = FloatTrait::new(x.into(), true);
        let b = FloatTrait::new(y.into(), true);
        let c = FloatTrait::zero();
        return Args {args_type: type_int, a, b, c};
    }


    fn get_type(ref self: Args) -> ArgsType {
        let mut t = self.args_type;
        if(t == 1) {
            return ArgsType::Fixed;
        };
        if(t == 2) {
            return ArgsType::Vec2;
        };
        if(t == 3) {
            return ArgsType::Vec3;
        };
        if(t == 4) {
            return ArgsType::Position;
        };
        return ArgsType::None;
    }
    
}