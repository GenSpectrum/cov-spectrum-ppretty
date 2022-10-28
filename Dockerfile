FROM rocker/tidyverse:4
WORKDIR /app/

RUN apt-get update
RUN apt-get install -y libxt6
COPY . .
RUN  R -e "devtools::install('.')"

EXPOSE 7090
ENTRYPOINT ["Rscript", "inst/run_app_production.R"]
