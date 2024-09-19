# Python testing for research

A short course on the basics of software testing in Python using the `pytest` library.

This lesson uses [The Carpentries Workbench][workbench] template.

## Course Description

Whether you are a seasoned developer or just write the occasional script, it's important to know that your code does what you intend, and will continue to do so as you make changes.

Software testing is a methodology of automatically ensuring that your code works correctly, without having to go back and manually verify after each change.

This course seeks to provide you with conceptual understanding and the tools you need to start ensuring the robustness of your code.

### Contents

- Basic tests
- Running a test suite & understanding outputs
- Best practices
- Testing for errors
- Testing data structures
- Fixtures
- Parametrisation
- Testing file outputs
- Continuous integration & automatic test-running with GitHub

## Contributions

Contributions are welcome, please refer to the [contribution guidelines](CONTRIBUTING.md) of how to do so and ensure that you adhere to the [Code of Conduct](CODE_OF_CONDUCT.md).

### Build the lesson locally

To render the lesson locally, you will need to have [R][r] installed. Instructions for using R with the Carpentries template is [available](https://carpentries.github.io/workbench/#installation) but some additional setps have been taken to make sure the enivronment is reproducible using the [`{renv}`](https://rstudio.github.io/renv/articles/renv.html) package and an `renv.lockfile` is included which allows the environment to be re-created along with dependencies.

After cloning the repository, you can set up the `renv` and install all packages with:
``` r
renv::restore()
# Optionally update packages
renv::update()
```
Once you have installed the dependencies, you can render the pages locally by starting R in the project root and running:
``` r
sandpaper::serve()
```
This will build the pages and start a local web-server in R and open it in your browser. These pages are "live" and will respond to local file changes if you save them.

[git]: https://git-scm.com
[r]: https://www.r-project.org/
[workbench]: https://carpentries.github.io/workbench/




