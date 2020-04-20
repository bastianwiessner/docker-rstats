FROM bastianwiessner/centos-analytics:v1

MAINTAINER bastianwiessner

ENV R_Version=3.6.3

RUN wget https://cran.r-project.org/src/base/R-3/R-$R_Version.tar.gz && \
tar -xzf R-$R_Version.tar.gz && \
cd R-$R_Version && \
./configure --prefix=/opt/R/$R_Version --enable-R-shlib --with-blas --with-lapack && \
make -j2 && \
make check && \
make install && \
make clean

RUN /opt/R/$R_Version/bin/R CMD javareconf
RUN /opt/R/$R_Version/bin/R -e "install.packages('shiny',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN /opt/R/$R_Version/bin/R -e "install.packages('tidyverse',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN /opt/R/$R_Version/bin/R -e "install.packages('caret',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN /opt/R/$R_Version/bin/R -e "install.packages('ggplot2',dependencies=TRUE, repos='http://cran.rstudio.com/')"
