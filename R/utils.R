#' @title Checks if an mldr object is locally available and downloads it if necessary
#' @description This function checks if the mldr object whose name is given as input is locally available, loading it in memory.
#' If necessary, the dataset will be downloaded from the GitHub repository and saved locally.
#' @param mldr.name Name of the dataset to load
#' @examples
#'
#' library(mldr.datasets)
#' check_n_load.mldr("bibtex")
#' bibtex$measures
#' @export
check_n_load.mldr <- function(mldr.name) {
  if(exists(mldr.name, .GlobalEnv, mode = "list"))
    stop('The ', mldr.name, ' dataset is already loaded.')

  fpath <- paste(find.package('mldr.datasets'), '/extdata/', mldr.name, '.rda', sep = '')
  if(!file.exists(fpath)) {
    url <- paste('https://github.com/fcharte/mldr.datasets/raw/master/additional-data/', mldr.name, '.rda', sep = '')
    download.file(url, fpath)
  }

  if(file.exists(fpath))
    load(fpath, .GlobalEnv)
  else
    stop('The ', mldr.name, ' dataset is not available.')
}