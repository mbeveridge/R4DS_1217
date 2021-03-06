# library(tidyverse)

----------
# 27. "R Markdown" [Chapter 21 hardcopy]
# 27.2.1 Exercises

# Q1.
# Create a new notebook using 'File > New File > R Notebook'. Read the instructions. Practice running the chunks.
# Verify that you can modify the code, re-run it, and see modified output

# A1. <See separate file>
# Running code in RStudio updates the output (eg. plot) there. Saving it (Cmd-S) creates *.nb.html version in active directory


# Q2.
# Create a new R Markdown document with 'File > New File > R Markdown'… Knit it by clicking the appropriate button.
# Knit it by using the appropriate keyboard short cut. Verify that you can modify the input and see the output update

# A2. <See separate file>
# Prompted to give the *.Rmd file a title (and choose default output format) when creating it. Saving it doesn't create an
# html (etc) file. Knitting it to html did create *.html version in active directory, and open the file


# Q3.
# Compare and contrast the R notebook and R markdown files you created above.
# How are the outputs similar? How are they different?
# How are the inputs similar? How are they different?
# What happens if you copy the YAML header from one to the other?

# A3.
# Not sure what the difference is. <Do I have corruption?> [http://rmarkdown.rstudio.com/r_notebooks.html]
# Outputs appear similar/'expected' (though the default boilerplate code is different)
# Header for notebook was a generic [title: "R Notebook"] and [output: html_notebook]
# Header for R Markdown file was as selected when creating [title: "R4DS_Wk13"] and [output: html_document]
# Couldn't be sure of any/what effect when copy&paste YAML header from one to the other (and vice versa)


# Q4.
# Create one new R Markdown document for each of the three built-in formats: HTML, PDF and Word.
# Knit each of the three documents. How does the output differ? How does the input differ?
# (You may need to install LaTeX in order to build the PDF output — RStudio will prompt you if this is necessary.)

# A4. <See separate files>
# I used same (existing) R Markdown document, but knit to pdf and to Word. The YAML header 'output:' changed
# Was prompted to download TeX ["Mac OS X: TexLive 2013 (Full) - http://tug.org/mactex/
# (NOTE: Download with Safari rather than Chrome _strongly_ recommended)"] ...which I did (3.0GB --> 5.48GB when unpacked)
# After restarting RStudio, could complete the knit to pdf. Knit to Word was ok


----------
# 27. "R Markdown" [Chapter 21 hardcopy]
# 27.3.1 Exercises

# Q1.
# Practice what you’ve learned by creating a brief CV. The title should be your name, and you should include headings for
# (at least) education or employment. Each of the sections should include a bulleted list of jobs/degrees. Highlight the year in bold

# A1. <See separate file>
# [@eringrand : If you're using a RNotebook, once you "preview it" (i.e knit it for the first time) it'll update on its own
# every time you Save the document]


# Q2.
# Using the R Markdown quick reference, figure out how to:
# Q2.1 Add a footnote
# Q2.2 Add a horizontal rule
# Q2.3 Add a block quote

# A2. <ALSO see separate file>
# A2.1 :
# Reference : A footnote [^1]
# At the bottom of the document: [^1]: Here is the footnote

# A2.2 : "Horizontal Rule / Page Break : Three or more asterisks or dashes"
# A2.3 : Blockquote : each line preceded by a > character and an optional space


# Q3.
# Copy and paste the contents of 'diamond-sizes.Rmd' from https://github.com/hadley/r4ds/tree/master/rmarkdown
# in to a local R markdown document. Check that you can run it, then add text after the frequency polygon that
# describes its most striking features.

# A3. <See separate file. NOTE: I changed display of 'diamond-sizes.Rmd' to Raw view, to be able to copy the formatting>


----------
# 27. "R Markdown" [Chapter 21 hardcopy]
# 27.4.7 Exercises
  
# Q1.
# Add a section that explores how diamond sizes vary by cut, colour, and clarity. Assume you’re writing a report
# for someone who doesn’t know R, and instead of setting 'echo = FALSE' on each chunk, set a global option

# A1.


# Q2.
# Download 'diamond-sizes.Rmd' from https://github.com/hadley/r4ds/tree/master/rmarkdown.
# Add a section that describes the largest 20 diamonds, including a table that displays their most important attributes

# A2.


# Q3.
# Modify 'diamonds-sizes.Rmd' to use 'comma()' to produce nicely formatted output.
# Also include the percentage of diamonds that are larger than 2.5 carats.

# A3.


# Q4.
# Set up a network of chunks where 'd' depends on 'c' and 'b', and both 'b' and 'c' depend on 'a'.
# Have each chunk print 'lubridate::now()', set 'cache = TRUE', then verify your understanding of caching

# A4.


