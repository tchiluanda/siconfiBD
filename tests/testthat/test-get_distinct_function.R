test_that("Get distinct functions", {
  expect_gt(NROW(get_distinct_function()),0)
  expect_gt(NROW(get_distinct_function(scope = "f")),0)
  expect_gt(NROW(get_distinct_function("s")),0)
})
