import os
import re

cd = os.path.dirname(os.path.abspath(__file__))

# READ IN FILE
contents = []
with open(os.path.join(cd, "TEXT", "Input.txt"), "r") as txt:    
    for line in txt:
        if line != '\n':
            contents.append(line.strip('\n'))

# REPLACE SPECIAL CHARACTERS AND NUMBERS
for i in range(len(contents)):        
    contents[i] = re.sub("[^A-Za-z]", " ", contents[i])
    contents[i] = re.sub("\\s+", " ", contents[i])    
    contents[i] = contents[i].strip()
    contents[i] = contents[i].replace(" s ", "'s ").replace("o er", "o'er")

contents = [i+"\n" for i in contents if len(i) > 0]

# OUTPUT FILE
with open(os.path.join(cd, "TEXT", "Output_PY.txt"), "w") as f:
    for c in contents:
        f.write(c)

print("Successfully parsed and outputted text file!")
