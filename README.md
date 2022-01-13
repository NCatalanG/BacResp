# BacResp
Models for bacterial respiration

To load project, you'll first need to `setwd()` into the directory where this README file is located. Then you need to run the following two
lines of R code:
```
  setwd("N:/Dropbox/My Documents/GitHub/BacResp")
  library('ProjectTemplate')
  load.project()
```
After you enter the second line of code, you'll see a series of automated
messages as ProjectTemplate goes about doing its work. This work involves:
* Reading in the global configuration file contained in `config`.
* Loading any R packages you listed in the configuration file.
* Reading in any datasets stored in `data` or `cache`.
* Preprocessing your data using the files in the `munge` directory.

You can override the values in global.dcf when loading the project by providing the option with the new setting:

#load.project(cache_loading = FALSE) # load the project without loading from the cache
#reload.project(cache_loading = FALSE, # Don't load from cache
                 data_ignore = '*.tsv') # Don't load tsv files
Specific project configuration, that can ve added to any script:
#add.config(keep_data = FALSE, header = "Private & Confidential")

Once that's done, you can execute any code you'd like. For every analysis
you create, we'd recommend putting a separate file in the `src` directory.
If the files start with the two lines mentioned above:
```
 library('ProjectTemplate')
 load.project()
```
You'll have access to all of your data, already fully preprocessed, and
all of the libraries you want to use.

To save a data set in the cache:
`cache("DOM.input")`

For more details about ProjectTemplate, see http://projecttemplate.net