use std::collections::HashMap;

/// Count occurrences of words.
pub fn word_count(phrase: &str) -> HashMap<String, u32> {
    let mut map = HashMap::new();
    let mut word = String::new();
    for c in phrase.to_lowercase().chars() {
        if c.is_alphanumeric() {
            word.push(c);
        } else if !word.is_empty() {
            *map.entry(word.clone()).or_insert(0) += 1;
            word.clear();
        }
    }
    if !word.is_empty() {
        *map.entry(word.clone()).or_insert(0) += 1;
    }
    map
}