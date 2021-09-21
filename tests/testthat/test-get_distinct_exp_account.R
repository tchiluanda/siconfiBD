test_that("Get distinct budgetary expense accounts", {
  expect_gt(NROW(get_distinct_exp_account()),0)

})
