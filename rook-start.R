#!/usr/bin/env Rscript

library(Rook)
source("config.R")

myPort <- 8000
myInterface <- "0.0.0.0"
status <- -1

# R 2.15.1 uses .Internal, but the next release of R will use a .Call.
# Either way it starts the web server.
if (as.integer(R.version[["svn rev"]]) > 59600) {
    status <- .Call(tools:::startHTTPD, myInterface, myPort)
} else {
    status <- .Internal(startHTTPD(myInterface, myPort))
}

if (status == 0) {
    unlockBinding("httpdPort", environment(tools:::startDynamicHelp))
    assign("httpdPort", myPort, environment(tools:::startDynamicHelp))

    s <- Rhttpd$new()
    s$listenAddr <- myInterface
    s$listenPort <- myPort

    # Change this line to your own application. You can add more than one
    # application if you like
    s$add(name="predictoR",
          app=app
          )
    # Now make the console go to sleep. Of course the web server will still be
    # running.
    while (TRUE) Sys.sleep(24 * 60 * 60)
}

# If we get here then the web server didn't start up properly
warning("Oops! Couldn't start Rook app")
