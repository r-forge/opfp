\name{multiBinSeg}
\alias{multiBinSeg}
\title{multiBinSeg}
\description{Binary segmentation of p profiles, each with n data, using the L2 loss}
\usage{multiBinSeg(geno, Kmax)}
\arguments{
  \item{geno}{A matrix with p columns and n lines (or a n-vector which is treated as 1-column matrix), each column is one of the profiles to segment, and each column has its own set of mean parameters.}
  \item{Kmax}{Maximum number of change-points, should be less than number of rows of \code{geno}}
}

\value{return an object with the successive change-points found by binseg (t.est) and the corresponding decreases in L2 cost (J.est, always negative).}

\author{Guillem Rigaill <guillem.rigaill@inra.fr> [aut, cre], Toby Hocking [aut], Robert Maidstone [aut], Michel Koskas [ctb], Paul Fearnhead [aut]}





