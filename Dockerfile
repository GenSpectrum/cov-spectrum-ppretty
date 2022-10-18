FROM rocker/tidyverse:4
WORKDIR /app/

COPY R/install_packages.R R/
RUN Rscript R/install_packages.R
COPY . .

EXPOSE 7090
ENTRYPOINT ["Rscript", "R/app.R"]
