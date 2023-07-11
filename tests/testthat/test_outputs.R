test_that("correct output structure for phacking_meta", {
  cat("\n\n", as.character(Sys.time()), "--------------- test_outputs.R ---------------\n\n")

  params <- list(favor_positive = FALSE, alpha_select = 0.01, ci_level = 0.90)

  meta <- rlang::exec(phacking_meta, yi = -money_priming_meta$yi,
                      vi = money_priming_meta$vi, !!!params,
                      parallelize = FALSE)

  expect_s3_class(meta, "metabias")
  expect_named(meta, c("data", "values", "stats", "fits"))

  expect_s3_class(meta$data, "data.frame")
  expect_named(meta$data, meta_names("data"))
  expect_equal(nrow(meta$data), nrow(money_priming_meta))
  expect_equal(meta$data$yi, money_priming_meta$yi)
  expect_equal(meta$data$vi, money_priming_meta$vi)

  expect_type(meta$values, "list")
  expect_named(meta$values, meta_names("values"))
  purrr::walk(names(params), \(p) expect_equal(params[[p]], meta$values[[p]]))

  expect_s3_class(meta$stats, "data.frame")
  expect_equal(nrow(meta$stats), 2)
  expect_named(meta$stats, meta_names("stats"))
  expect_true(all(meta$stats$se < 1))
  expect_true(all(meta$stats$ci_lower < meta$stats$mode))
  expect_true(all(meta$stats$ci_upper > meta$stats$mode))

  expect_length(meta$fit, 1)
  expect_s4_class(meta$fit, "stanfit")

})
