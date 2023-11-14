import java.util.List;
import java.util.stream.*;

class ProteinTranslator {

    List<String> translate(String rnaSequence) {
        List<String> result = new ArrayList<>();

        for (int i = 0; i < rnaSequence.length(); i += 3) {
            String codon = rnaSequence.substring(i, i + 3);
            String protein = proteinFor(codon);

            if (protein.equals("STOP")) {
                break;
            }

            result.add(protein);
        }

        return result;
    }

    static String proteinFor(String codon) {
        switch (codon) {
            case "AUG": return "Methionine";
            case "UUU": case "UUC": return "Phenylalanine";
            case "UUA": case "UUG": return "Leucine";
            case "UCU": case "UCC": case "UCA": case "UCG": return "Serine";
            case "UAU": case "UAC": return "Tyrosine";
            case "UGU": case "UGC": return "Cysteine";
            case "UGG": return "Tryptophan";
            case "UAA": case "UAG": case "UGA": return "STOP";
            default: throw new IllegalArgumentException("Invalid codon");
        }
    }

    public static void main(String[] args) {
        if (args.length != 1) {
            System.err.println("Usage: java ProteinTranslator <filename>");
            System.exit(1);
        }

        String fileName = args[0];

        String fileContent = readFile(fileName);

        Map<Character, Integer> frequencyMap = frequencyMap(fileContent);

        List<Map.Entry<Character, Integer>> frequencyList = frequencies(frequencyMap);

        Collections.sort(frequencyList, Collections.reverseOrder(Map.Entry.comparingByValue()));

        frequencyList.forEach(entry ->
                System.out.println("'" + entry.getKey() + "': " + entry.getValue()));
    }

    private static String readFile(String fileName) {
        throw new UnsupportedOperationException("Implement file reading here");
    }

    private static Map<Character, Integer> frequencyMap(String input) {
        throw new UnsupportedOperationException("Implement frequency map creation here");
    }

    private static List<Map.Entry<Character, Integer>> frequencies(Map<Character, Integer> frequencyMap) {
        return new ArrayList<>(frequencyMap.entrySet());
    }
}
