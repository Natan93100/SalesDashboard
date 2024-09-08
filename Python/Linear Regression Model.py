import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

class SimpleLinearRegression:
    def __init__(self):
        self.slope = 0  # Sets as Default
        self.intercept = 0  # Sets as Default

    def fit(self, X, y):
        # X: independent variable
        # y: dependent variable

        # Mean of X and y
        X_mean = np.mean(X)
        y_mean = np.mean(y)

        # Calculating the slope (m) using the formula for linear regression
        numerator = np.sum((X - X_mean) * (y - y_mean))
        denominator = np.sum((X - X_mean) ** 2)
        self.slope = numerator / denominator

        # Calculating the intercept (b)
        self.intercept = y_mean - self.slope * X_mean

    def predict(self, X):
        # A multiplication of the slope by a Scalar X;
        # the intercept (b) will be added as per the formula
        return self.slope * X + self.intercept


# Example usage
if __name__ == '__main__':

    X = np.array([20, 25, 30, 35, 40])

    y = np.array([100, 150, 200, 250, 300])

    # Creating the model
    model = SimpleLinearRegression()

    # Training the model
    model.fit(X, y)

    # Predict the ice cream sales for a temperature of 32°C
    predicted_sales = model.predict(32)

    print(f"Slope (m): {model.slope}")
    print(f"Intercept (b): {model.intercept}")
    print(f"Predicted ice cream sales at 32°C: {predicted_sales}")

    # A visualization of the function based on the DataSet

    data = {
        'temperature': [20, 25, 30, 35, 40],
        'ice_cream_sales': [100, 150, 200, 250, 300]
    }
    df = pd.DataFrame(data)

    # Creating a scatter chart
    plt.figure(figsize=(10, 6))
    plt.scatter(df['temperature'], df['ice_cream_sales'])
    plt.xlabel('Temperature (°C)')
    plt.ylabel('Ice Cream Sales')
    plt.title('Effect of Temperature on Ice Cream Sales')
    plt.show()
