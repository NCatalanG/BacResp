# BacResp
## Coding to build up or select the best models for bacterial respiration of lake water DOM.
To be developed jointly with Marloes, Dolly, Ada and myself on Greenland samples, incubated during 2 weeks in uppsala University

## On the use of Project Template:

I used Project Template to organize the workflow. I hope it works well for us, but maybe you have better or clearer ideas. 

To load project, you'll first need to `setwd()` into the directory where this README file is located. Then you need to run the following 
lines of R code:
```
  library('ProjectTemplate')
  load.project()
```
After you enter the slast line of code, you'll see a series of automated
messages as ProjectTemplate goes about doing its work. This work involves:
* Reading in the global configuration file contained in `config`.
* Loading any R packages you listed in the configuration file.
* Reading in any datasets stored in `data` or `cache`.
* Preprocessing your data using the files in the `munge` directory.

You can override the values in global.dcf when loading the project by providing the option with the new setting:

#load.project(cache_loading = FALSE) # load the project without loading from the cache
#reload.project(cache_loading = FALSE, # Don't load from cache
                 data_ignore = '*.tsv') # Don't load tsv files
Specific project configuration, that can be added to any script:
#add.config(keep_data = FALSE, header = "Private & Confidential")

Once that's done, you can execute any code you'd like. For every analysis you create, we'd recommend putting a separate file in the `src` directory.
If the files start with the two lines mentioned above:
```
 library('ProjectTemplate')
 load.project()
```
You'll have access to all of your data, already fully preprocessed, and
all of the libraries you want to use.

To save a data set in the cache:
`cache("DOM.input")`

The folders have:
* CACHE: store datasets generated during pre-processing and that dont need to be regenerated every time. 
* CONFIG: Project Template configurations
* DATA: raw data files. If in supportef ile format, will be automatically uploaded when load.project is run
* DOCS: documentation about analysis.Root for Github pages. 
* MUNGE: preprocessing or data munging code. The scripts in munge will be executed in alphabetical order when you call load.project. No headlines!
* SRC: final analysis scripts.

Once you have a data frame that we want to get loaded without munging, we can save it to `cache("dataframe")` and set munging to false in global.

For more details about ProjectTemplate, see http://projecttemplate.net
