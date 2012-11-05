#!/usr/bin/env Rscript

library(Rook)
source("config.R")

myPort <- 8000
myInterface <- "0.0.0.0"

s <- Rhttpd$new()
s$start(listen=myInterface, port=myPort, quiet=FALSE)

## You can add more than one
## application if you like
s$add(name="predictoR", app=app)

## Now make the console go to sleep. Of course the web server will still be
## running.
while (TRUE) Sys.sleep(60)

