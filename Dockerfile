FROM dddlab/base-rstudio:v20200720-d6cbe5a-94fdd01b492f

LABEL maintainer="Patrick Windmiller <windmiller@pstat.ucsb.edu>"

USER $NB_USER

RUN conda install -y r-base && \
    conda install -c conda-forge udunits2 && \
    conda install -c conda-forge imagemagick && \
    conda install -c conda-forge r-rstan && \
    conda install -c conda-forge r-units && \
    conda install -c conda-forge r-sf

RUN R -e "install.packages(c('tidyverse', 'janitor', 'readxl', 'lubridate', 'lucid', 'magrittr', 'learnr', 'haven', 'summarytools', 'ggplot2', 'kableExtra', 'flextable', 'sf', 'viridis', 'titanic', 'labelled', 'Lahman', 'babynames', 'nasaweather', 'fueleconomy', 'mapproj', 'ggthemes', 'mapview'), repos = 'http://cran.us.r-project.org')"

RUN R --quiet -e "devtools::install_github('UrbanInstitute/urbnmapr', dep=FALSE)"
RUN R --quiet -e "devtools::install_github('rapporter/pander')"

# remove cache
RUN rm -rf ~/.cache/pip ~/.cache/matplotlib ~/.cache/yarn && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
