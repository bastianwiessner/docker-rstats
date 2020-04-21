FROM bastianwiessner/centos-analytics:v1

MAINTAINER bastianwiessner

ENV R_Version=3.6.3
ENV HOME=/root

# Download R and remove tar archive
RUN cd $HOME && \
 wget https://cran.r-project.org/src/base/R-3/R-$R_Version.tar.gz && \
 tar -xzf R-$R_Version.tar.gz && \
 rm -rf R-$R_Version.tar.gz

# Navigate into dir and install interpreter and remove archive
RUN cd $HOME/R-$R_Version && \
 ./configure --prefix=/opt/R/$R_Version --enable-R-shlib --with-blas --with-lapack && \
 make -j2 && \
 make check && \
 make install && \
 make clean && \
 rm -rf $HOME/R-$R_Version

## speeding up package installation

RUN mkdir $HOME/.R/ && touch $HOME/.R/Makevars
RUN echo "MAKEFLAGS = -j4" >> $HOME/.R/Makevars

## Installing R Packages

RUN /opt/R/$R_Version/bin/R CMD javareconf
# RUN /opt/R/$R_Version/bin/R -e "install.packages('shiny',dependencies=TRUE, Ncpus = getOption('Ncpus',2), repos='http://cran.rstudio.com/')"
# RUN /opt/R/$R_Version/bin/R -e "install.packages('tidyverse',dependencies=TRUE, Ncpus =getOption('Ncpus',2), repos='http://cran.rstudio.com/')"
# RUN /opt/R/$R_Version/bin/R -e "install.packages('caret',dependencies=TRUE, Ncpus =getOption('Ncpus',2), repos='http://cran.rstudio.com/')"
# RUN /opt/R/$R_Version/bin/R -e "install.packages('ggplot2',dependencies=TRUE, Ncpus =getOption('Ncpus',2), repos='http://cran.rstudio.com/')"
