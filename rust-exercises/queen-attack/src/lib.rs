#[derive(Debug)]
pub struct ChessPosition(i32, i32);

#[derive(Debug)]
pub struct Queen {
    position: ChessPosition
}

impl ChessPosition {
    pub fn new(rank: i32, file: i32) -> Option<Self> {
        if rank < 0 || rank > 7 || file < 0 || file > 7 {
            return None;
        }
        Option::Some(ChessPosition(rank, file))
    }
}

impl Queen {
    pub fn new(position: ChessPosition) -> Self {
        Queen{position}
    }

    pub fn can_attack(&self, other: &Queen) -> bool {
        let (x1, y1) = (self.position.0, self.position.1);
        let (x2, y2) = (other.position.0, other.position.1);
        if x1 == x2 || y1 == y2 || (x1 - x2).abs() == (y1 - y2).abs() {
            true
        } else {
            false
        }
    }
}
