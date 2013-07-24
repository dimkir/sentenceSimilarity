/**
* This class allows to calculate similarity between two 
* strings, based on how many same words the strings share.
*/
class Similarity
{
   private boolean mPrintWarningIfNullParameters = false;
   private boolean mDebugOutput = false;
  
   /**
   * Returns amount of words shared between two strings.
   * Uses default separator " " space.
   * Two consequtive separators are treated as one. 
   *
   * @param s1
   */
   public int commonWordCount(String s1, String s2){
      return commonWordCount(s1, s2, null); // when null is parsed all whitespace
                                            // characters are used (\t\r\n
   } 
   
   
   public int commonWordCount(String s1, String s2, String separator){
      return commonWordCount(s1, s2, separator, null);
   }
   
   /**
   *
   * @param s1  
       can be NULL - then no match
       can be ""  - ?? should be no match
       can be "     " or string full of delimeters, which result in nothing.
   */
   private int commonWordCount(String s1, String s2, String separator, SentenceExtInfo sentenInfo){
      if ( s1 == null || s2 == null ){
         return 0;
      }
      
      s1 = s1.toLowerCase();
      s2 = s2.toLowerCase();
      String[] tokens1;
      String[] tokens2;
      if ( separator == null){
         tokens1 = splitTokens(s1, " ");
         tokens2 = splitTokens(s2, " ");
      }
      else{
          tokens1 = splitTokens(s1, separator);
          tokens2 = splitTokens(s2, separator);
      }
      
      
      // pre-condition: non empty arrays
      debugln("Array before sorting: ");
      debugln(tokens1);
      tokens1 = sort(tokens1);
      debugln("Array after sorting: " );
      debugln(tokens1);
      tokens2 =  sort(tokens2);
      
      if ( sentenInfo != null){
        sentenInfo.totalAvailableWords = tokens1.length + tokens2.length;
      }
      
     
//      // make sure that tokens1 always has the lesser first element 
//      if ( tokens1[0].greaterThan(tokens2[0]) ){
//         swapSA(tokens1, tokens2); // 
//      }
      
      int i = 0;
      int j = 0;
      int similarWordCount = 0;
      while ( i < tokens1.length && j < tokens2.length){
         // we go down the tokens1 
         // we compare element to other
         int COMPARE_REZ = compareWords(tokens1[i], tokens2[j]);
         if ( COMPARE_REZ == EQUAL ){
              // if they're equal we increase similarity index and move to next word.
              similarWordCount++;
              i++;
              j++;           
         }
         else if ( COMPARE_REZ == LEFT_IS_GREATER ){
             // if left is greater, we increase index on right
             j++;  
         }
         else if ( COMPARE_REZ == LEFT_IS_SMALLER ){
             // if they're not left is lesser, we increase index on left
             i++;  
         }
         else{
            
            throw new RuntimeException("We shouldn't be here never, value of rez: " + COMPARE_REZ);
         }
      }// while
      
       if ( sentenInfo != null){
        sentenInfo.allSimilarWords = similarWordCount * 2;
       }
      
       return similarWordCount;  
      
      
   }
   
   /**
   * This method to use instead of prinln(). The output will only be printed
   * if mDebugOutput flag is true.
   */
   private void debugln(String s){
      if ( mDebugOutput ){
         println(s);
      }
   }
   
   private void debugln(String[] stringar){
      if ( !mDebugOutput ) return;
      if ( stringar == null ){
         debugln("[string array is null]");
         return;
      }
      
      StringBuilder sb = new StringBuilder();
      sb.append("[");
      for(int i = 0 ; i < stringar.length ; i++){
         if ( i > 0 ){  
            sb.append(", ");
         }
         sb.append(stringar[i]);         
      }// for
      sb.append("]");
      
      debugln(sb.toString());
   }
   
   private final int LEFT_IS_GREATER = 1;
   private final int LEFT_IS_SMALLER = -1;
   private final int EQUAL = 0;
   /**
   * Compares two words and returns result.
   * @return 
   */
   int compareWords(String w1, String w2){
      
      int v = w1.compareTo(w2);
      debugln("Comparing ["  +  w1 + "] \t vs \t [" + w2 + "] = " + v);
      if ( v == 0 ) return EQUAL;
      if ( v < 0 ) return LEFT_IS_SMALLER;
      
      return LEFT_IS_GREATER; 
   }
   
   
   /**
   * Returns similarity ratio between two strings.
   * Similarity is a value between 0.0 and 1.0, where
   * 0.0 means that there's no similar words. And 1.0 means that all the words in the 
   * sentences are same. 
   * simRatio =  allSimilarWords / totalAvailableWords
   * 
   * totalAvailableWords: sum of number of words in each sentence. 
   * So for example with two sentences:
      1) Mary had a little lamb          (amount of words is 5)
      2) The lamb was little dumb        (amount of words is 5)
     The totalAvailable words for these two sentences would be 10, 
     which means that we DO count words "little" and "lamb" twice.
     
     Whereas {allSimilarWords} is calculated as sum of similar words for each sentence.
     
    So let's mark similar words in both sentenece with _underscore_ mark.
      1a) Mary had a _little_ _lamb_
      2a) The _lamb_ was _little_ dumb
     
    So sentence (1a) has 2 similar words, and sentence (2a) has 2 similar words.
    Thus the value of {allSimilarWords} would be  2 + 2 = 4. Note, that in this
    situation we again count TWICE each of the words.
   */
   public float similarityRatio(String s1, String s2){
       SentenceExtInfo sentInfo = new SentenceExtInfo();
       int wc = commonWordCount(s1, s2, null, sentInfo);
       return (float) sentInfo.allSimilarWords / (float) sentInfo.totalAvailableWords;
   }
 
  
   /**
   * This is little data structure, used to return extended token
   * info. Used internally. 
   */
   private class SentenceExtInfo
   {
       int allSimilarWords;
       int totalAvailableWords;
   }  
   
}
