---
title: 'why-test-my-code'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- Why test my code?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Understand how testing can help to ensure that code is working as expected

::::::::::::::::::::::::::::::::::::::::::::::::

## Introduction

Whether you are writing the occasional script or developing a large software, mistakes are inevitable. Sometimes you don't even know when a mistake creeps into the code, and it gets published. 

Consider the following function:

```python
def add(a, b):
    return a - b
```

This function is supposed to add two numbers. However when typing it out, I made a typo and I didn't notice it before adding this function to my project.

I could manually test this function by running it with different inputs and checking the output, but:

- This takes time
- I will forget to try every combination of inputs
- I will forget to test it again when I make changes to the code

Also, later on, when my code starts producing unexpected results, I will have to manually test every function to find the bug.

This is where automated testing comes in.

## Automated testing

Automated testing is where we write code, that tests our code. Every time we make a change, we can run our tests to make sure that our code still works as expected.

If we were writing a test from scratch for the `add` function, we would write something like this:

```python
def test_add():
   if add(1, 2) != 3:
      print("Test failed")
   if add(0, 0) != 0:
      print("Test failed")
   if add(-1, -2) != -3:
      print("Test failed")
```

Where we check that the function works for a set of test cases. This checks that it works for positive numbers, negative numbers, and zero.

There is a special statement in Python that makes this easier: the `assert` statement. This statement checks that an expression is true, and if it is not, it raises an error. We can use this to write our tests like this:

```python
def test_add():
   assert add(1, 2) == 3
   assert add(0, 0) == 0
   assert add(-1, -2) == -3
```

This test checks that the `add` function works as expected. If it doesn't, then the test will fail and we will know that we need to fix the function.

The `assert` statement just checks that the expression is true. If it is not, then the test fails. We will see more about this later.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor

Inline instructor notes can help inform instructors of timing challenges
associated with the lessons. They appear in the "Instructor View"

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: challenge 

## Challenge 1: Can you do it?

What is the output of this command?

```r
paste("This", "new", "lesson", "looks", "good")
```

:::::::::::::::::::::::: solution 

## Output
 
```output
[1] "This new lesson looks good"
```

:::::::::::::::::::::::::::::::::


## Challenge 2: how do you nest solutions within challenge blocks?

:::::::::::::::::::::::: solution 

You can add a line with at least three colons and a `solution` tag.

:::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::

## Figures

You can include figures generated from R Markdown:


```r
pie(
  c(Sky = 78, "Sunny side of pyramid" = 17, "Shady side of pyramid" = 5), 
  init.angle = 315, 
  col = c("deepskyblue", "yellow", "yellow3"), 
  border = FALSE
)
```

<div class="figure" style="text-align: center">
<img src="fig/why-test-my-code-rendered-pyramid-1.png" alt="pie chart illusion of a pyramid"  />
<p class="caption">Sun arise each and every morning</p>
</div>
Or you can use pandoc markdown for static figures with the following syntax:

`![optional caption that appears below the figure](figure url){alt='alt text for
accessibility purposes'}`

![You belong in The Carpentries!](https://raw.githubusercontent.com/carpentries/logo/master/Badge_Carpentries.svg){alt='Blue Carpentries hex person logo with no text.'}

## Math

One of our episodes contains $\LaTeX$ equations when describing how to create
dynamic reports with {knitr}, so we now use mathjax to describe this:

`$\alpha = \dfrac{1}{(1 - \beta)^2}$` becomes: $\alpha = \dfrac{1}{(1 - \beta)^2}$

Cool, right?

::::::::::::::::::::::::::::::::::::: keypoints 

- Use `.md` files for episodes when you want static content
- Use `.Rmd` files for episodes when you need to generate output
- Run `sandpaper::check_lesson()` to identify any issues with your lesson
- Run `sandpaper::build_lesson()` to preview your lesson locally

::::::::::::::::::::::::::::::::::::::::::::::::
