Here you can store any documentation that you've written about your analysis.
When pushing the project to GitHub you can use this directory as the root for a
GitHub Pages website for the project. For more information see
https://github.com/blog/2289-publishing-with-github-pages-now-as-easy-as-1-2-3

#DATA TREATMENT DIARY:#
##20200429##
  - we check that the src *Homologous* produces a column that is a factor and each level is an homologous series. 
  - the input for further analysis is *DOMN*, stored in the cache. 
  - I decide to eliminate those HS with only one compound. That is 62 compounds, from the analysis.
  
  
##20200901##
- I create, in the DOMageing folder ms4 code based on Charlotte's to clean for the Blanks
- since this applies to all the treatments in the WRT project and I wont use it furthermore, I dont include it in this Project
- different parameters in cross. Check it does not affect the Homologous Series

##20201130##
- Homologous moved to munge
- copy ChemoDiv, transform DOM into the same format as BCI

##20201209##
- I already determined the lme funtion as the one to determine the model relating the ecological function with the diversity index
- then I need to assess the marginal R2 according to Nakagawa. It seems that best option might be MuMIn package. 