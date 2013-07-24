Similarity similarity = new Similarity();

void setup(){
   int d = LevenshteinDistance.computeDistance("mama", "papa");
   println("Levenshtein distance between two words is: " + d);
   
   String sent1 = "Mary had a little lamb";
   String sent2 = "The lamb was little dumb";
   
   int commonWords = similarity.commonWordCount(sent1, sent2);
   println("Amount of common words: " + commonWords);
   
   /// returns float value between 0.0 (including) and 1.0 (including)
   // which is the percentage of the words which were flagged as common
   // out of total amount of tokens
   float similarityRatio = similarity.similarityRatio(sent1, sent2);
   
   println("Similarity ratio: " + similarityRatio);
   
}


void draw(){
}
