# cov-spectrum-ppretty

An API to make pretty plots for cov-spectrum.org.

The canonical usage is as follows:  

* the CoV-Spectrum website sends a request to the `plot` endpoint that contains configuration information and data to plot in JSON format  
* the API returns a plot of the data in XX format.

The repository structure is modeled on https://github.com/sol-eng/plumbpkg.

## Run the API locally

```{r}
# Load all the functions in the ppretty package
devtools::load_all()

# Run the API locally
run_app()
```

## Test the API

```{r}
# Load all the functions in the ppretty package
devtools::load_all()

# Run all tests
devtools::test()
```

## Qs for Chaoran
* barplots with many datapoints, ugly but okay?
* what should be shown differently about a collection plot vs. normal seqs over time plot?
* add any metadata information to plot titles?
* what should we return -- use one of the graphics devices like png() so we can have transparent background, specified resolution, etc?
* remove data transformation from endpoints.R so that file contains only API specs?
