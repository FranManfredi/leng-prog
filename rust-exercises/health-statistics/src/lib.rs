pub struct User {
    name: String,
    age: u32,
    weight: f32,
}

impl User {
    // Constructor para crear una nueva instancia de User
    pub fn new(name: &str, age: u32, weight: f32) -> Self {
        User {
            name: String::from(name),
            age,
            weight,
        }
    }

    // Método para obtener el nombre del usuario
    pub fn name(&self) -> &str {
        &self.name
    }

    // Método para obtener la edad del usuario
    pub fn age(&self) -> u32 {
        self.age
    }

    // Método para obtener el peso del usuario
    pub fn weight(&self) -> f32 {
        self.weight
    }

    // Método para establecer la edad del usuario
    pub fn set_age(&mut self, new_age: u32) {
        self.age = new_age;
    }

    // Método para establecer el peso del usuario
    pub fn set_weight(&mut self, new_weight: f32) {
        self.weight = new_weight;
    }
}

fn main() {
    let mut bob = User::new("Bob", 32, 155.2);

    println!("Name: {}", bob.name());
    println!("Age: {}", bob.age());
    println!("Weight: {}", bob.weight());

    bob.set_age(33);
    println!("Updated Age: {}", bob.age());

    bob.set_weight(160.0);
    println!("Updated Weight: {}", bob.weight());
}