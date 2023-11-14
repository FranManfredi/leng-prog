use std::collections::HashSet;
pub fn sum_of_multiples(limit: u32, factors: &[u32]) -> u32 {
    let mut res = 0;
    let mut count = 1;
    let mut multiples = HashSet::new();

    while count <= limit {
        for factor in factors {
            let multiple = factor * count;
            if multiple < limit && !multiples.contains(&multiple) {
                res += multiple ;
                multiples.insert(multiple);
            }
        }
        count += 1;
    }
    return res;
}

