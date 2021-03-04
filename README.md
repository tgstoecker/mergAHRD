# mergAHRD
Merging tool for AHRD output tables


This is a small script utility for the easy combination of both outputs our groups funtional annotation software AHRD (https://github.com/groupschoof/AHRD) provides.  
In essence, if users of AHRD are interested in both Human Readable Functional Annotation as well as the parsing of appropiate GO terms for all proteins, the programme should be run twice, once for each desired output, in order to get the best results for both.  
  
Taken from the AHRD documentation:  
***"3.3.2.0 Prefer reference proteins as candidates that have GO Term annotations**
The parameter `prefer_reference_with_go_annos: true` is highly recommended when aiming to annotate your query proteins with GO Terms.  
If this parameter is set to true only those candidate references are considered that also have GO Term annotations.  
However, if you put more emphasis on Human Readable Descriptions and are prepared to accept a couple of your queries to not get any GO Term predictions you can switch this off with `prefer_reference_with_go_annos: false` or just omit the parameter as by default it is set to `false`."*  
  
The idea behind mergAHRD is two offer an easy way of combining the outputs of both AHRD runs into one set and also offering aggregation of the results to gene level, while removing all redundancy that arises through multiple proteins/transcripts per gene.

Currently only the aggregation on gene level is implemented.  

# ToDos:
- transcript/protein level output 
