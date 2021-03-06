context("Visualizations work")

test_that("Functions produce ggplot2 lists", {
  plot_pred = visualize_pps(iris, y = 'Species')
  plot_mat = visualize_pps(iris)
  plot_cor = visualize_correlations(iris)
  plot_both = visualize_both(iris)

  expect_true(is.list(plot_pred))
  expect_true(is.list(plot_mat))
  expect_true(is.list(plot_cor))
  expect_true(is.list(plot_both))
})
