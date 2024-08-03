# Z_DEPENDENCY_INJECTION

## Overview

This ABAP project showcases the application of several software design principles and patterns in the context of SAP ABAP development. The example demonstrates:

- **Dependency Injection:** Injecting dependencies into classes to promote loose coupling.
- **Interfaces:** Defining and implementing interfaces to abstract and encapsulate functionality.
- **Classes:** Using ABAP classes to model and manage data and behavior.
- **MVC Pattern:** Implementing the Model-View-Controller (MVC) pattern for a structured approach to application development.
- **Unit Testing:** Testing components in isolation to ensure correctness.

## Components

### 1. Interfaces

- `zif_model`: Defines a common interface for model classes with a method `select_t100` that returns a table of `t100` entries.

### 2. Model Classes

- `lcl_model`: A concrete implementation of the `zif_model` interface that fetches data from table `t100`.
- `lcl_model_fake`: A fake implementation of the `zif_model` interface used for testing purposes, returning predefined data.

### 3. Controller

- `lcl_controller`: Manages interaction between the view and the model. It is initialized with a model object and retrieves data through the `select_t100` method.

### 4. View

- `lcl_view`: Responsible for user interaction. It initializes a controller and model, retrieves data from the controller, and displays it.

### 5. Unit Testing

- `ltc_test`: Contains unit tests for the application. It uses a fake model to test the controller's ability to retrieve data correctly.

## Classes and Methods

### `zif_model` Interface

```abap
INTERFACE zif_model.
  METHODS select_t100 RETURNING VALUE(rt_t100) TYPE tt_t100.
ENDINTERFACE.
```

### `lcl_model` Class

- **Constructor**: Initializes the model.
- **`zif_model~select_t100`**: Fetches data from table `t100`.

### `lcl_model_fake` Class

- **Constructor**: Initializes the fake model.
- **`zif_model~select_t100`**: Returns predefined data for testing.

### `lcl_controller` Class

- **Constructor**: Initializes with a model object.
- **`select_t100`**: Retrieves data from the model's `select_t100` method.

### `lcl_view` Class

- **Constructor**: Initializes a new model and controller.
- **`start_of_selection`**: Retrieves data from the controller and displays it.

### `ltc_test` Class

- **`setup`**: Initializes test data and objects.
- **`test_select_t100`**: Tests the `select_t100` method of the controller using a fake model.

## How to Run

1. **Initialization**:
   - `DATA(o_view) = NEW lcl_view( ).`
   - This line initializes the view object, which in turn initializes the model and controller.

2. **Start of Selection**:
   - `o_view->start_of_selection( ).`
   - This line starts the execution, fetching data from the controller and displaying it in the output.

## Unit Testing

To run the unit tests:

1. Open the ABAP Unit Test tool in the SAP GUI.
2. Execute the `ltc_test` class to run the defined test methods.

## Author

- **Renan Itokazo**
- renanitokazo@gmail.com

## Notes

- Ensure that the `t100` table exists in your SAP environment for the model to fetch real data.
- The fake model (`lcl_model_fake`) is used for testing to simulate the behavior without relying on actual data.

---

Feel free to customize this README further based on specific requirements or additional details about the project.
