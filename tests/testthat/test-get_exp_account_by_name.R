test_that("Get budgetary expense accounts by name", {
  expect_gt(NROW(get_exp_account_by_name(name = "pessoal")),0)

})
