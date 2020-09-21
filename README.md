# mergAHRD
Merging tool for AHRD output tables



This is a small utility completely in bash for the easy combination of both outputs our groups funtional annotation software AHRD (https://github.com/groupschoof/AHRD) provides.  
In essence, if users of AHRD are interested in both Human Readable Functional Annotation as well as the parsing of appropiate GO terms for all proteins the programme should be run twice, once for each desired output.  

While Human readable descriptions  are also created during the GO term calculations, these are not the optimal ones based on our benchmarks.  

The idea behind mergAHRD is two offer an easy way of combining the outputs of both AHRD runs into one set.  

Currently only an aggegation on gene level is implemented.  

# ToDos:
- transcript/protein level output 
