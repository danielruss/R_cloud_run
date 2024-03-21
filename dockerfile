# Use the rocker/r-base image as the base image
FROM rocker/tidyverse

# Install the necessary R packages
RUN install2.r plumber

# Expose port 8000
EXPOSE ${PORT}

# Add the current directory contents into the container at /app
ADD . /app

# Set the working directory to /app
WORKDIR /app

# Run the API when the container launches
CMD R -e "plumber::plumb('plumber.R')$run(port=as.numeric(Sys.getenv('PORT')))"
