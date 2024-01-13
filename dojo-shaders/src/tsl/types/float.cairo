use cubit::f64::types::fixed::{Fixed,FixedTrait};

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

    fn fromFixed(f: Fixed) -> Float {
        Float {mag: f.mag, sign: f.sign}
    }

    fn zero() -> Float {
        Float{mag:0, sign:true}
    }

    fn toFixed(self: Float) -> Fixed {
        FixedTrait::new(self.mag, self.sign)
    }



}