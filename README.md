# cov-spectrum-ppretty

An API to make pretty plots for cov-spectrum.org.

The canonical usage is as follows:  

* the CoV-Spectrum website sends a request to the `save` endpoint that contains configuration information and data to plot in JSON format  
* the API returns the full filepath to where it saved plot(s) of the data. Plot files are named with the sha-256 hash of the request.

The repository structure is modeled on https://github.com/sol-eng/plumbpkg.

## Run the API in a docker container
Start docker engine, then run:
```{bash}
docker build -t ppretty .
docker run --rm -p 80:7090 ppretty
```
You should be able to access the API docs at [http://127.0.0.1/__docs__/](http://127.0.0.1/__docs__/).

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

## Export functions and update NAMESPACE

The [NAMESPACE file](./NAMESPACE) contains the functions that are exported from the package. All functions that are called from [run_app_production.R](inst/run_app_production.R) (i.e., including [endpoints.R](inst/plumber/endpoints.R)) must be exported.

To export a function, it must be annotated with `@export`. Then, run `devtools::document()` to generate an updated NAMESPACE file.

## Orienting in the code

The API endpoints are defined in [`inst/plumber/endpoints.R`](inst/plumber/endpoints.R). There, you'll notice that the request data is first transformed, with known date column names standardized to "date". Then, the request config and data are piped into the high-level function [`make_plot`](R/make_plot.R).

The idea is that the request data gets passed to a plot type-specific function by `make_plot`. The plot type is specified in the request's config information. The specific plotting functions use common aesthetics, date scales, and colors that are defined in [`plot_helper_functions`](R/plot_helper_functions.R) and [`plot_shared_elements`](R/plot_shared_elements.R).

If using the endpoint `/save` the plot will be saved in several formats in a sub-directory within `./plots` (this is to avoid a single directory with too many files). The names of the sub-directories use the first four characters of the hash of request. The file name is the full hash. The endpoint will return the relative path to the generated plots without the file endings, e.g., `37/fc/37fc9c4fa9a218355b92a554227809b55b8568d3418ec927877641a0e9a1481f`.
