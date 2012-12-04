library(ltp)

dir.create(file.path(tempdir(),'plots'),showWarnings=FALSE)
app <- Builder$new(
    Static$new(
	urls = c('/css','/js', '/img'),
	root = 'bootstrap'
    ),
    Static$new(urls='/plots',root=tempdir()),
    Brewery$new(
	url='/brew',
	root='.',
	imagepath=file.path(tempdir(),'plots'),
	imageurl='../plots/'
    ),
    Redirect$new('/brew/index.rhtml')
)
