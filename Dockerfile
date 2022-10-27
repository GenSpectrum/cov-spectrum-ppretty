FROM rocker/tidyverse:4
WORKDIR /app/

COPY . .
RUN  R -e "devtools::install_github('https://github.com/cevo-public/cov-spectrum-ppretty')"

EXPOSE 7090
ENTRYPOINT ["Rscript", "inst/run_app_production.R"]
