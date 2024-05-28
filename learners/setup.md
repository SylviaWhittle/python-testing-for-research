---
title: Setup
---

## Code of Conduct

This course is covered by the [Carpentries Code of Conduct](https://docs.carpentries.org/topic_folders/policies/code-of-conduct.html). 

As mentioned in the Carpentries Code of Conduct, we encourage you to:

- Use welcoming and inclusive language
- Be respectful of different viewpoints and experiences
- Gracefully accept constructive criticism
- Focus on what is best for the community
- Show courtesy and respect towards other community members

Instances of abusive, harassing, or otherwise unacceptable behavior may be reported by following our [reporting guidelines](https://docs.carpentries.org/topic_folders/policies/incident-reporting.html).

## Software Setup

Please complete these setup instructions before the course starts. This is to ensure that the course can start on time and all of the content can be covered. If you have any issues with the setup instructions, please reach out to a course instructor / coordinator.

For this course, you will need:

### A Terminal
Such as Terminal on MacOS / Linux or command prompt on Windows. This is so that you can run Python scripts and commit code to GitHub.

### A Text Editor
Preferably a code editor like Visual Studio Code but any text editor will do, such as notepad. This is so that you can write and edit Python scripts. A code editor will provide a better experience for writing code in this course. We recommend Visual Studio Code as it is free and very popular with minimal setup required.

### Python
Preferably Python 3.10 or 3.11. You can download Python from [Python's official website](https://www.python.org/downloads/)

It is recommended that you use a virtual environment for this course. This can be a standard Python virtual environment or a conda environment. You can create a virtual environment using the following commands:

```bash
# For a standard Python virtual environment
python -m venv myenv
source myenv/bin/activate

# For a conda environment
conda create --name myenv
conda activate myenv
```

There are some python packages that will be needed in this course, you can install them using the following command:

```bash
pip install numpy pandas matplotlib pytest pytest-regtest pytest-mpl
```

### Git
This course touches on some features of GitHub and requires Git to be installed. You can download Git from the [official Git website](https://git-scm.com/downloads). If this is your first time using Git, you may want to check out the [Git Handbook](https://guides.github.com/introduction/git-handbook/).

### A GitHub account
A GitHub accound is required for the Continuous Integration section of this course.
You can sign up for a GitHub account on the [GitHub Website](github.com)





