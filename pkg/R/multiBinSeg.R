multiBinSeg <- function
### Binary segmentation of p profiles, each with n data, using the L2 loss
(geno, 
### A matrix with p columns and n lines (or a n-vector which is treated as 1-column matrix), each column is one of the profiles to segment, and each column has its own set of mean parameters.
 Kmax
### Maximum number of change-points, should be less than number of rows of geno
 ){
  if(is.matrix(geno)){
    nRow <- nrow(geno)
    nCol <- ncol(geno)
  } else {
    nRow <- length(geno)
    nCol <- 1
  }
  if(nRow <= Kmax){
    stop("too many changes, please decrease Kmax")
  }
  A <- .C("BinSeg_interface", 
          x_i= as.double((geno)),
          K= as.integer(Kmax),
          n= as.integer(nRow), 
          P= as.integer(nCol), 
          t.est= integer(Kmax),
          J.est = double(Kmax), 
          iterations = integer(Kmax+1),
          PACKAGE="fpop")
  ##A$Cost <- sum(geno^2) - sum(apply(geno, 2, sum)^2/nRow) + c(0, cumsum(A$RupturesCost))
  A
### return an object with the successive change-points found by binseg (t.est) and the corresponding decreases in L2 cost (J.est, always negative).
}



