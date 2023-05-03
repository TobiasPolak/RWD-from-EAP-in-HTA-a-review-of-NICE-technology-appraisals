# Real-world data from expanded access programmes in health technology assessments: a review of NICE technology appraisals
This repository contains the source code and data for the paper 'Real-world data from expanded access programmes in health technology assessments: a review of NICE technology appraisals', that appeared in the British Medical Journal Open. The link to the paper can be found [here.](https://bmjopen.bmj.com/content/12/1/e052186.full.) 


## Citation
Please consider citing our paper if you plan to use our code and/or data. We are happy to collaborate or answer any questions.

Please cite this work as: Polak TB, Cucchi DG, van Rosmalen J, et al. Real-world data from expanded access programmes in health technology assessments: a review of NICE technology appraisals. BMJ Open 2022;12:e052186. doi:10.1136/bmjopen-2021-052186
* For questions, email: 
    * tobias.polak@erasmusmc.nl
    * polak.tobias@gmail.com

## How to run the code
The code available in the [Scripts](/Scripts) folder can be run sequentially to reproduce the analysis.
1. The [LoardURL.R](/Scripts/01LoadURL.R) will retrieve all the URL's of TA documentation. Note that TA's may get updated and replaced over time, or may be removed due to a withdrawal of marketing authorisation. For a reproducable analysis, please save all documentation locally.
2. The [DownloadFiles.R](/Scripts/02DownloadFiles.R) will download and save all the documentation based on URLs in folders. As mentioned in the manuscript, some documentation is saved in so-called 'Portfolio PDFs'. These are PDFs of PDFs and cannot be directly scanned - make sure to manually extract all individual files and save them in the same folder before proceeding.
3. The [ScanFiles.R](/Scripts/03ScanFiles.R) is automated code to scan all individual documents on the occurence of selected key words. The output is a matrix with all the occuring terms, the document URL (links directly to the right page), the page number, the term, and the two proceeding and two following lines for  context.

For a detailed description of our methodology, we refer to the Methods section of our paper and the Workflow (A) that is depicted in the Supplementary Files. 

## Note
- Make sure you have internet connection while running the script as it installs packages from CRAN.
- This script assumes that you have R and RStudio installed on your system.

### Authors
- Tobias B. Polak <sup>1,2,3,4,*</sup>
- David G.J. Cucchi <sup>5</sup>
- Joost van Rosmalen <sup>1,2</sup>
- Carin A. Uyl - De Groot <sup>3</sup>

<sup>1</sup> Department of Biostatistics, Erasmus Medical Center, Rotterdam, The Netherlands

<sup>2</sup> Department of Epidemiology, Erasmus Medical Center, Rotterdam, The Netherlands

<sup>3</sup> Erasmus School of Health Policy & Management, Erasmus University Rotterdam, Rotterdam, The Netherlands

<sup>4</sup> Real-World Data Department, myTomorrows, Amsterdam, The Netherlands

<sup>5</sup> Department of Haematology, Amsterdam UMC, Location VUmc, Amsterdam, Noord-Holland, The Netherlands

<sup>*</sup> {Corresponding author: t.polak@erasmusmc.nl}

## Video
We created a YouTube video to explain our research.  

[![IMAGE ALT TEXT](http://img.youtube.com/vi/23mHESNZnFQ/0.jpg)](http://www.youtube.com/watch?v=23mHESNZnFQ "BMJ Open 2021")

## Graphical information
1. First, we downloaded all publicly available information from the NICE websites. As you can see, the technology appraisals (or TAs) all have a similar structure: https://www.nice.org.uk/guidance/ta425. So https://www.nice.org.uk/guidance/ta + number. Not all numbers will lead to technology appraisals, some are withdrawn or cancelled, but this process works fairly well. Subsequently, we could download all the documents from these appraisals. We then searched for any terms related to expanded access, such as compassionate use, expanded access, early access, pre-approval access, named patient, managed access. single-patient access, single-patient IND, etc. An excellent paper on all the confusing terminology can be found [here](https://journals.sagepub.com/doi/10.1177/2168479017696267?icid=int.sj-abstract.similar-articles.5). This methodology is similar to our previous paper that can be found [here](https://github.com/TobiasPolak/BJCP2020)
2. We then searched through all these documents whether any of these terms appeared, only manually going through the documents with an expanded access terms. This graphic depicts our process:
![](https://github.com/TobiasPolak/RWD-from-EAP-in-HTA-a-review-of-NICE-technology-appraisals/blob/main/Animations/GIF1_Compressed%20(1).gif)
3. Now, we only had to look through the documents that contain an expanded access term:
![](https://github.com/TobiasPolak/RWD-from-EAP-in-HTA-a-review-of-NICE-technology-appraisals/blob/main/Animations/GIF2_Loop_Compressed%20(1).gif)
4. We could now finally divide our work into expanded access use for (i) safety (ii) efficacy (iii) resource use (e.g. any cost-related factors) or (iv) trivial: no relevant use of expanded access or a random term popping up.  
![](https://github.com/TobiasPolak/RWD-from-EAP-in-HTA-a-review-of-NICE-technology-appraisals/blob/main/Animations/GIF3_Compressed%20(1).gif)

## Results
Now that we have shown you our methodology, please read the paper to find out the results!

## Competing Interests
Tobias Polak is a member of the NYU Grossmann School of Medicine Ethics and Real-World Evidence (ERWE) Working Group. Tobias Polak works part-time for expanded access service provider myTomorrows, in which he holds stock and stock options (< 0.01%). He is contractually free to publish and the service provider is not involved in any of his past or ongoing research, nor in this work. Tobias Polak receives research support from the Dutch Ministry of Economic Affairs and Climate Policy (HealthHolland). Tobias Polak has received a Prins Bernhard Cultuurfonds Prijs for travel expenses to New York City. Joost van Rosmalen and David Cucchi declare no conflict of interest. Carin Uyl-de Groot has received unrestricted grants from Boehringer Ingelheim, Astellas, Celgene, Sanofi, Janssen-Cilag, Bayer, Amgen, Genzyme, Merck, Glycostem Therapeutics, Astra Zeneca, Roche and Merck.

## Funding
This research was supported via an unrestricted grant from HealthHolland: EMCLSH20012. HealthHolland is a funding vehicle for the Dutch Ministry of Economic Affairs and Climate Policy that addresses the Dutch Life Sciences & Health sector.

