# How to upload metagenomics files to Webin ENA

Tutorial on how to upload files to ENA.


## 1. Register study


## 2. Register Samples

Pick the correct checklist. Eg: **(ENA default sample checklist)**

*tax_id* : Use appropriate taxonomic ID of organism as in NCBI Taxonomy database
eg: 2705415
*scientific_name* : Scientific name of the taxonomic ID (should match with the ID above)
eg: human feces metagenome
*sample_alias* : Unique name of the sample. 
*sample_title* : Title of the sample
*sample_description* : Description of the samples

Save the file as tab seperated file.

Upload to ENA

## 3. Submit reads

Need to upload the files and md5sum before upload the complete spreadsheet

### Zip files
Files need to be zipped in gz format.

`file.fastq > file.fastq.gz`

### Generate md5 files

ENA wants md5 file with only 32 cheracter string.
File name should be same as the zip file with .md5 at the end.

`md5sum file.fastq.gz | awk '{print $1}' > file.fastq.gz.md5 `

### Upload files

Use Filezilla to upload the raw and md5 files:

`
Host: webin2.ebi.ac.uk
Username: Webin-xxxx
Password: *password12345678*
`
Just drag files to the ENA server.  

Note: Sometimes connection lost and so careful of upload files.
Makes sure all files are there.

### Upload spreadsheet

Sample: ERS*** (Use generated sample from above)
Study: ERP*** (Use generated study from above)
library_name: Same as sample_title from above
forward_xxxxx_name: The name of the file
xxxx_file_md5: The 32 character strings from md5

Fill in the rest

After upload the files should appear under `Raw Reads`.


Have fun.

