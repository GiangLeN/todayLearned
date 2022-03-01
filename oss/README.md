# How to download from oss

## Setup ossutil

Download the program

`wget https://gosspublic.alicdn.com/ossutil/1.7.9/ossutil64`

Makes file executable

`chmod 755 ossutil64`

Config the program

`./ossutil64 config`

Fill out:  

*endpoint, accessKeyID* and *accessKeySecret*

Note: if *stsToken* is not present then leave it blank.

## Use ossutil

See available files from project (bucket)
`./ossutil64 ls oss://project-xxx`

### Download file
`./ossutil64 cp oss://file.txt download_directory`


Have fun

