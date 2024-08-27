library(testthat)
context("cost")

x <- c(-1, 1)
test_that("penalty above 2 gets 1 segment", {
  penalty <- 3
  penalty <- 2.001
  fit <- fpop::Fpop(x, penalty)
  m <- 0
  expect_equal(fit$J.est, sum(x^2 - 2*x*m + m^2))
  ## A$J.est <- A$cost[n] - (A$K + 1) * lambda + sum(x^2)
  cost.vec <- c(-1, 0)+penalty
  expect_equal(length(fit$t.est), 1)
  expect_equal(fit$cost, cost.vec)
})
test_that("penalty below 2 gets 2 segments", {
  penalty <- 1.999
  fit <- fpop::Fpop(x, penalty)
  cost.vec <- c(-1, -2)+penalty*(1:2)
  expect_equal(length(fit$t.est), 2)
  expect_equal(fit$cost, cost.vec)
})
test_that("multiBinseg ok with vector data", {
  fit <- fpop::multiBinSeg(1:8, 3)
  expect_equal(sort(fit$t.est), c(2,4,6))
  expect_equal(length(fit$iterations), 4)
  set.seed(1)
  fpop::multiBinSeg(rnorm(16), 7)
})
test_that("multiBinseg error for too many changes", {
  expect_error({
    fpop::multiBinSeg(1:8, 8)
  }, "too many changes, please decrease Kmax")
})
test_that("multiBinseg ok with matrix data", {
  data.mat <- cbind(
    c(1, 2, 11, 12),
    c(101, 102, 110, 112))
  mean.mat <- matrix(
    colMeans(data.mat), nrow(data.mat), ncol(data.mat), byrow=TRUE)
  cost.vec <- c(
    sum((data.mat-mean.mat)^2),
    6*0.5^2+2,
    4*0.5^2,
    0)
  fit <- fpop::multiBinSeg(data.mat, 3)
  expect_equal(fit$t.est, c(2,3,1))
  expect_equal(fit$J.est, diff(cost.vec))
})
