<?php

$cd = dirname(__FILE__);

// READ IN TEXT
$contents = file($cd."/TEXT/Input.txt");

$out=[];
foreach($contents as $line){
    
    // REPLACE SPECIAL CHARACTERS AND NUMBERS
    $line = preg_replace("#[^A-Za-z]#", " ", $line);    
    $line = preg_replace("#\s+#", " ", $line);
            
    // CLEAN UP SPECIFIC QUOTES
    $line = str_replace(" s ", "'s ", $line);
    $line = str_replace("o er", "o'er", $line);
    if (trim($line) <> "") {
        $out[] = trim($line)."\r\n";
    }   
}

// OUTPUT FILE
file_put_contents($cd."/TEXT/Output_PHP.txt", $out);

echo "Successfully parsed and outputted text file!\n";

?>
