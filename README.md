# Lifespan Analysis of Lemurs in Wild and Captive Environments

This repository contains the neccessary code, data and files for producing the paper "Lifespan Analysis of Lemurs in Wild and Captive Environments".

The [paper](/paper/paper.pdf) is available in the paper folder. The models created in this paper, can be used using the frontend live [here](http://3.99.183.165:5173). The code for the frontend can be found in [this repo](https://github.com/khushaal-nandwani/predicting-lemurs-frontend). The backend or the API code can be found in [this repo](https://github.com/khushaal-nandwani/predicting-lemurs-api).

The study explores the lifespan of lemurs in wild and captive environments using data from the Duke Lemur Center. It employs statistical modeling techniques to analyze the impact of variables such as sex, species, genus, and birth month on lemur longevity.

## LLM Usage
Certain code and text was written using the help of ChatGPT 4o. Its usage can be tracked under [llm_usage.txt](other/llm_usage/llm_usage.txt).

# File Structure

The repository is structured as follows:

- `data/`: Contains the data used in the project.
    - `analysis_data/`: Contains the data used for the analysis, that is after cleaning and preprocessing.
    - `raw_data/`: Contains the raw data used
    - `predictions/`: Contains the predictions made by the models we created.
- `paper/`: Contains the final paper and the references file.
- `other/`: 
    - `llm_usage/`: Contains the llm usage file.
    - `sketches/`: Contains the sketches used for the paper.
- `models/`: Contains the models we created.
- `scripts/`: Contains the scripts used for the analysis, cleaning, downloading data, making predictions and creating models.
