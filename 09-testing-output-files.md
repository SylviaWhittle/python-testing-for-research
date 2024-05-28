---
title: 'Regression Testing and Plots'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How to test for changes in program outputs?
- How to test for changes in plots?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Learn how to test for changes in images & plots

::::::::::::::::::::::::::::::::::::::::::::::::

## Regression testing

When you have a large processing pipeline or you are just starting out adding tests to an existing project, you might not have the
time to carefully define exactly what each function should do, or your code may be so complex that it's hard to write unit tests for it all.

In these cases, you can use regression testing. This is where you just test that the output of a function matches the output of a previous version of the function.

The library `pytest-regtest` provides a simple way to do this. When writing a test, we pass the argument `regtest` to the test function and use `regtest.write()` to log the output of the function.
This tells pytest-regtest to compare the output of the test to the output of the previous test run.

To install `pytest-regtest`:

```bash
pip install pytest-regtest
```

::::::::::::::::::::::: callout

This `regtest` argument is actually a fixture that is provided by the `pytest-regtest` package. It captures
the output of the test function and compares it to the output of the previous test run. If the output is
different, the test will fail.

:::::::::::::::::::::::::::::::

Let's make a regression test:

- Create a new function in `statistics/stats.py` called `very_complex_processing()`:

```python

def very_complex_processing(data: list):

    # Do some very complex processing
    processed_data = [x * 2 for x in data]

    return processed_data
```

- Then in `test_stats.py`, we can add a regression test for this function using the `regtest` argument.

```python
import pytest

from stats import very_complex_processing

def test_very_complex_processing(regtest):

    data = [1, 2, 3]
    processed_data = very_complex_processing(data)

    regtest.write(str(processed_data))
```

- Now because we haven't run the test yet, there is no reference output to compare against, 
so we need to generate it using the `--regtest-generate` flag:

```bash
pytest --regtest-generate
```

This tells pytest to run the test but instead of comparing the result, it will save the result for use in future tests.

- Try running pytest and since we haven't changed how the function works, the test should pass.

- Then change the function to break the test and re-run pytest. The test will fail and show you the difference between the expected and actual output.

```bash

=== FAILURES ===
___ test_very_complex_processing ___

regression test output differences for statistics/test_stats.py::test_very_complex_processing:
(recorded output from statistics/_regtest_outputs/test_stats.test_very_complex_processing.out)

>   --- current
>   +++ expected
>   @@ -1 +1 @@
>   -[3, 6, 9]
>   +[2, 4, 6]
```

Here we can see that it has picked up on the difference between the expected and actual output, and displayed it for us to see.

Regression tests, while not as powerful as unit tests, are a great way to quickly add tests to a project and ensure that changes to the code don't break existing functionality.
It is also a good idea to add regression tests to your main processing pipelines just in case your unit tests don't cover all the edge cases, this will
ensure that the output of your program remains consistent between versions.

## Testing plots

When you are working with plots, you may want to test that the output is as expected. This can be done by comparing the output to a reference image or plot.
The `pytest-mpl` package provides a simple way to do this, automating the comparison of the output of a test function to a reference image.

To install `pytest-mpl`:

```bash
pip install pytest-mpl
```

- Create a new folder called `plotting` and add a file `plotting.py` with the following function:

```python
import matplotlib.pyplot as plt

def plot_data(data: list):
    fig, ax = plt.subplots()
    ax.plot(data)
    return fig
```

This function takes a list of points to plot, plots them and returns the figure produced.

In order to test that this funciton produces the correct plots, we will need to store the correct plots to compare against.
- Create a new folder called `test_plots` inside the `plotting` folder. This is where we will store the reference images.

`pytest-mpl` adds the `@pytest.mark.mpl_image_compare` decorator that is used to compare the output of a test function to a reference image.
It takes a `baseline_dir` argument that specifies the directory where the reference images are stored.

- Create a new file called `test_plotting.py` in the `plotting` folder with the following content:

```python
import pytest
from plotting import plot_data

@pytest.mark.mpl_image_compare(baseline_dir="test_plots/")
def test_plot_data():
    data = [1, 3, 2]
    fig = plot_data(data)
    return fig
```

Here we have told pytest that we want it to compare the output of the `test_plot_data` function to the images in the `test_plots` directory.

- Run the following command to generate the reference image:
(make sure you are in the base directory in your project and not in the plotting folder)

```bash
pytest --mpl-generate-path=plotitng/test_plots
```

This tells pytest to run the test but instead of comparing the result, it will save the result into the `test_plots` directory for use in future tests.

Now we have the reference image, we can run the test to ensure that the output of `plot_data` matches the reference image.
Pytest doesn't check the images by default, so we need to pass it the `--mpl` flag to tell it to check the images.

```bash
pytest --mpl
```

Since we just generated the reference image, the test should pass.

Now let's edit the `plot_data` function to plot a different set of points by adding a 4 to the data:

```python
import matplotlib.pyplot as plt

def plot_data(data: list):
    fig, ax = plt.subplots()
    # Add 4 to the data
    data.append(4)
    ax.plot(data)
    return fig
```

- Now re-run the test. You should see that it fails.

```bash
=== FAILURES ===
___ test_plot_data ___
Error: Image files did not match.
  RMS Value: 15.740441786649093
  Expected:  
    /var/folders/sr/wjtfqr9s6x3bw1s647t649x80000gn/T/tmp6d0p4yvm/test_plotting.test_plot_data/baseline.png
  Actual:    
    /var/folders/sr/wjtfqr9s6x3bw1s647t649x80000gn/T/tmp6d0p4yvm/test_plotting.test_plot_data/result.png
  Difference:
    /var/folders/sr/wjtfqr9s6x3bw1s647t649x80000gn/T/tmp6d0p4yvm/test_plotting.test_plot_data/result-failed-diff.png
  Tolerance: 
    2
```

Notice that the test shows you three image files.
(All of these files are stored in a temporary directory that pytest creates when running the test.
Depending on your system, you may be able to click on the paths to view the images. Try holding down CTRL or Command and clicking on the path.)


- The first, "Expected" is the reference image that the test is comparing against.
- The second, "Actual" is the image that was produced by the test.
- And the third is a difference image that shows the differences between the two images. This is very useful as it enables us to cleraly see
what went wrong with the plotting, allowing us to fix the issue more easily. In this example, we can clearly see that the axes ticks are different, and
the line plot is a completely different shape.

This doesn't just work with line plots, but with any type of plot that matplotlib can produce.

Testing your plots can be very useful especially if your project allows users to define their own plots.


::::::::::::::::::::::::::::::::::::: keypoints 

- Regression testing ensures that the output of a function remains consistent between changes and are a great first step in adding tests to an existing project.
- `pytest-regtest` provides a simple way to do regression testing.
- `pytest-mpl` provides a simple way to test plots by comparing the output of a test function to a reference image.

::::::::::::::::::::::::::::::::::::::::::::::::

