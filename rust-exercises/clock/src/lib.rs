use std::fmt;

#[derive(PartialEq, PartialOrd, Debug)]
pub struct Clock {
    hours: i32,
    minutes: i32,
}

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        let mut hours = hours;
        let mut minutes = minutes;
        while (minutes > 59 || minutes < 0) || (hours > 23 || hours < 0) {
            if minutes > 59 {
                hours += minutes / 60;
                minutes = minutes % 60;
            }
            if minutes < 0 {
                hours -= 1;
                minutes = 60 + minutes;
            }
            if hours > 23 {
                hours = hours % 24;
            }
            if hours < 0 {
                hours = 24 + hours;
            }
        }
        Clock{hours, minutes}
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        let mut new_hours = self.hours;
        let mut new_minutes = self.minutes + minutes;
        while (new_minutes > 59 || new_minutes < 0) || (new_hours > 23 || new_hours < 0) {
            if new_minutes > 59 {
                new_hours += new_minutes / 60;
                new_minutes = new_minutes % 60;
            }
            if new_minutes < 0 {
                new_hours -= 1;
                new_minutes = 60 + new_minutes;
            }
            if new_hours > 23 {
                new_hours = new_hours % 24;
            }
            if new_hours < 0 {
                new_hours = 24 + new_hours;
            }
        }
        Clock{hours: new_hours, minutes: new_minutes}
    } 
}

impl fmt::Display for Clock {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let hours = if self.hours < 10 {
            format!("0{}", self.hours)
        } else {
            format!("{}", self.hours)
        };
        let minutes = if self.minutes < 10 {
            format!("0{}", self.minutes)
        } else {
            format!("{}", self.minutes)
        };
        write!(f, "{}:{}", hours, minutes)
    }
}
