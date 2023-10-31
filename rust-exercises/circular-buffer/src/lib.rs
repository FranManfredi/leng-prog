#[derive(Debug, PartialEq)]
pub enum Error {
    EmptyBuffer,
    FullBuffer,
}

pub struct CircularBuffer<T: Clone> {
    buffer: Vec<Option<T>>,
    size: usize,
    next: usize,
    oldest: usize,
}

impl<T: Clone> CircularBuffer<T> {
    pub fn new(size: usize) -> CircularBuffer<T> {
        CircularBuffer {
            buffer: vec![None; size],
            size: 0,
            next: 0,
            oldest: 0,
        }
    }

    pub fn read(&mut self) -> Result<T, Error> {
        if self.is_empty() {
            return Err(Error::EmptyBuffer);
        }
        let value = self.buffer[self.oldest].take().unwrap();
        self.oldest = (self.oldest + 1) % self.buffer.len();
        self.size -= 1;
        Ok(value)
    }

    pub fn write(&mut self, value: T) -> Result<(), Error> {
        if self.is_full() {
            return Err(Error::FullBuffer);
        }
        self.buffer[self.next] = Some(value);
        self.next = (self.next + 1) % self.buffer.len();
        self.size += 1;
        Ok(())
    }

    pub fn clear(&mut self) {
        self.buffer = vec![None; self.buffer.len()];
        self.size = 0;
        self.next = 0;
        self.oldest = 0;
    }

    pub fn is_empty(&self) -> bool {
        self.size == 0
    }

    pub fn is_full(&self) -> bool {
        self.size == self.buffer.len()
    }
}
