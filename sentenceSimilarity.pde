Similarity similarity = new Similarity();

void setup(){
   
   String sent1 = "Mary \t had a little.    lamb ";
   String sent2 = "The lamb was little    dumb";

   println("Comparing sentences: ");
   println(sent1);
   println(sent2);

   int d = LevenshteinDistance.computeDistance("mama", "papa");
   println("Levenshtein distance between two words is: " + d);

   
   int commonWords = similarity.commonWordCount(sent1, sent2); //, similarity.SEPARATORS_WHITESPACE_PUNCTUATION);
   println("Amount of common words (default separators)" + commonWords);
   
   commonWords = similarity.commonWordCount(sent1, sent2, similarity.SEPARATORS_WHITESPACE_PUNCTUATION);
   println("Amount of common words (separators: whitespace + punctuation) " + commonWords);
   
   
   /// returns float value between 0.0 (including) and 1.0 (including)
   // which is the percentage of the words which were flagged as common
   // out of total amount of tokens
   float similarityRatio = similarity.similarityRatio(sent1, sent2);
   println("Similarity ratio (default separators): " + similarityRatio);
   
   similarityRatio = similarity.similarityRatio(sent1, sent2, similarity.SEPARATORS_WHITESPACE_PUNCTUATION);
   println("Similarity ratio (separators: whitespace + punctuation): " + similarityRatio);
   
   
   
}


void draw(){
}
