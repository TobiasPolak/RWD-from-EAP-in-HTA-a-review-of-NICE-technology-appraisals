# Expanded Access Programs in NICE Technology Appraisals
Code to accompany the paper 'Real-world data from expanded access programmes in health technology assessments: a review of NICE technology appraisals', see: https://bmjopen.bmj.com/content/12/1/e052186.full. 

Please consider citing our paper if you plan to use our code and/or data. We are happy to collaborate or answer any questions.

### Citation
Polak TB, Cucchi DG, van Rosmalen J, et al. Real-world data from expanded access programmes in health technology assessments: a review of NICE technology appraisals. BMJ Open 2022;12:e052186. doi:10.1136/bmjopen-2021-052186
* For questions, email: 
    * tobias.polak@erasmusmc.nl
    * polak.tobias@gmail.com

### Authors
* Tobias B. Polak
* David G.J. Cucchi
* Joost van Rosmalen
* Carin A. Uyl - de Groot

### Title: 	Real-world data from expanded access programmes in health technology assessments: a review of NICE technology appraisals.
* Author of this file and of the final version of the code: Tobias B. Polak
* File last modified: January 2022
    
## How to run the code
The code available in the [Scripts](/Scripts) folder can be run sequentially to reproduce the analysis.
1. The [LoardURL.R](/Scripts/01LoadURL.R) will retrieve all the URL's of TA documentation. Note that TA's may get updated and replaced over time, or may be removed due to a withdrawal of marketing authorisation. For a reproducable analysis, please save all documentation locally.
2. The [DownloadFiles.R](/Scripts/02DownloadFiles.R) will download and save all the documentation based on URLs in folders. As mentioned in the manuscript, some documentation is saved in so-called 'Portfolio PDFs'. These are PDFs of PDFs and cannot be directly scanned - make sure to manually extract all individual files and save them in the same folder before proceeding.
3. The [ScanFiles.R](/Scripts/03ScanFiles.R) is automated code to scan all individual documents on the occurence of selected key words. The output is a matrix with all the occuring terms, the document URL (links directly to the right page), the page number, the term, and the two proceeding and two following lines for  context.


For a detailed description of our methodology, we refer to the Methods section of our paper and the Workflow (A) that is depicted in the Supplementary Files. 


