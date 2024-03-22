# Use the rocker/tidyverse image as the base image
# this save a LOT of time installing the tidyverse...
FROM rocker/tidyverse

# Install the necessary R packages
RUN install2.r plumber

# Expose port the cloud run port...
EXPOSE ${PORT}

# Add the current directory contents into the container at /app
ADD . /app

# Set the working directory to /app
WORKDIR /app


# Run the API when the container launches
# You must escape the $ or you will not call the run function it
# will see pr(...)
# You must supply the host and port parameters also.  Port will 
# be defined by cloud run as 8080.
CMD R -e "pr<-plumber::plumb('SimpleTestApi/plumber.R');pr\$run(host='0.0.0.0',port=as.numeric(Sys.getenv('PORT')))"
