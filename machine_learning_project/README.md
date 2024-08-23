# Machine Learning Project: Predicting Student Grades

This project analyzes student data and builds a machine learning model to predict student performance based on selected features. The model helps school leadership identify students who may need additional assistance to improve their grades.

## Files in this Project

- **PredictingStudentGrades.ipynb**: A Python notebook containing the technical implementation of the project. It includes code and markdown blocks detailing the data cleaning, analysis, feature scaling, custom transformations, training and testing of models, model selection, and performance metrics.
- **ExecutiveSummary_StudentsGrades.docx**: A Word document containing the executive summary to communicate insights to the stakeholders, present visualizations, and suggest next steps.
- **student-mat.csv**: The dataset was downloaded from [UC Irvine’s machine learning repository](https://archive.ics.uci.edu/dataset/320/student+performance) and modified for this assignment. It contains student performance data from two Portuguese schools, originally collected from school reports and questionnaires.

## Project Overview

The main goal of this project is to predict student grades based on several features such as study time, failures, and absences. The project uses various machine learning models, evaluates their performance, and selects the best model for prediction.

## Methodology

1. **Data Cleaning**: The dataset was preprocessed to handle missing values, encode categorical variables, and scale numerical features.
2. **Feature Engineering**: Features were selected based on their relevance to the target variable, and new features were created to improve model performance.
3. **Model Training**: Several machine learning models were trained, including linear regression, decision trees, and random forests.
4. **Model Evaluation**: The models were evaluated using cross-validation, and the best-performing model was selected based on accuracy, precision, recall, and F1-score.
5. **Insights and Recommendations**: The final model's predictions were analyzed to provide actionable insights for school leadership.

## Conclusion

The project demonstrates the application of machine learning techniques to solve real-world problems in education. The final model can help schools identify students at risk of poor performance and implement targeted interventions to support them.
