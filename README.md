# Readme for TGA Data Plotting Script

## Overview
- This script reads text files containing Thermogravimetric Analysis (TGA) data and plots the data based on sample names.
- Each sample's data is divided into two plots: temperature vs %weight, and temperature vs derivative weight, which are plotted in the same figure.
- The files are expected to have the naming convention **'SampleName-Date.txt'.**

## How it works
1. The script first retrieves a list of all .txt files in the current directory.
2. It then loops through each file:
- Extracts the sample name and date from the filename.
- Skips the header lines in the file until it reaches a line starting with 'min'.
- Reads the data from the rest of the file.
- Stores the data into a structure, grouped by sample name.
3. The script then creates a figure for each sample:
- Sorts the data by the order of dates specified in the date_order variable.
- Plots temperature vs %weight and temperature vs derivative weight for each date.
- Adds a legend showing the dates in the order specified.
- Saves the figure as a PNG file with the sample name.

## Modifying the script
- The order of dates in the legend can be modified by changing the date_order variable.
- The range of the y-axis in the plots can be adjusted by changing the parameters in ylim in the plotting sections.

## Requirements
- This script requires MATLAB and the input files should be in **.txt format** with a **tab** as delimiter. 
- Each row of data should contain **five columns**: time, temperature, weight, %weight, and derivative weight, in that order.
- The script skips the header rows until it finds a row starting with **'min'**.
