# Predicting a Lemur's Lifespan in Wild and Captivity

This repository contains the neccessary code, data and files for producing the paper "Predicting a Lemur's Lifespan in Wild and Captivity".

The [final paper](/paper/paper.pdf) is available in the paper folder.

The study explores the lifespan of lemurs in wild and captive environments using data from the Duke Lemur Center. It employs statistical modeling techniques to analyze the impact of variables such as sex, species, genus, and birth month on lemur longevity.

## LLM Usage
Certain code and text was written using the help of ChatGPT 4o. Its usage can be tracked under [llm_usage.txt](other/llm_usage.txt).

# File Structure

The repository is structured as follows:

- `data/`: Contains the data used in the project.
    - `analysis_data/`: Contains the data used for the analysis, that is after cleaning and preprocessing.
    - `raw_data/`: Contains the raw data used
    - `predictions/`: Contains the predictions made by the models we created.
- `paper/`: Contains the final paper and the references file.
- `other/`: Contains the LLM usage file.
- `models/`: Contains the models we created.
- `scripts/`: Contains the scripts used for the analysis, cleaning, downloading data, making predictions and creating models.
