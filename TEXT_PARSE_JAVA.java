
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import java.io.*;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class TEXT_PARSE_JAVA {       
    
    public static void main(String[] args) {
        	    
	    String currentDir = new File("").getAbsolutePath();
	    String line;
	    Pattern p = Pattern.compile("[^A-Za-z]");
	    StringBuffer sb = new StringBuffer();
	    String contents = "";
	    
            try {
		// READ IN FILE
		String txtFile = currentDir + "\\TEXT\\Input.txt";
		BufferedReader br = null;
		                            
		br = new BufferedReader(new FileReader(txtFile));
		
		// REMOVE SPECIAL CHARACTERS AND NUMBERS	
		while ((line = br.readLine()) != null) {
		    
		    String dataline = line;
		    Matcher m = p.matcher(dataline);		    
		    
		    while(m.find()){			
			m.appendReplacement(sb, " ");			
		    }		    
		    m.appendTail(sb.append("\n"));
		}
		
		// CONCATENATE CHARACTERS
		for(int i=0; i < sb.length(); i++){
		    contents = contents + sb.charAt(i);
		}
		// SPLIT BY LINE BREAK
		String textStr[] = contents.split("\\n");
		contents = "";
		
		// RE-CONCATENATE LINES
		for(String t: textStr)
		    if (!t.trim().equals(""))
			contents = contents + t.trim() + "\r\n";
		
		// REPLACE SPACES
    		contents = contents.replace("      ", " ");
		contents = contents.replace("  ", " ");
		
		// UPDATE SINGLE APOSTROPHES
		contents = contents.replace(" s ", "'s ");
		contents = contents.replace("o er", "o'er");
		
		// SAVE TO FILE
		FileWriter file = new FileWriter(currentDir + "\\TEXT\\Output_JAVA.txt");
		file.write(contents);
		file.flush();
		file.close();
		
                System.out.println("Successfully parsed and outputted text file!");
	            
	    } catch (FileNotFoundException ffe) {
                System.out.println(ffe.getMessage());
	    } catch (IOException ioe) {
                System.out.println(ioe.getMessage());
            }  
    }
}
