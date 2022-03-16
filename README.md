# Simple asset generator file for your project

- Step 1: Add asset_generator in your pubspec.yaml file under `dev_dependencies`
- Step 2: Add `assets` in your pubspec.yaml file
- Step 3: Add `generated_assets_path` in your pubspec.yaml file 
- Step 4: Run command 
    ```
        flutter pub run asset_generator:main
    ```

***

```
Note: Make sure all your assets file name must be in alphabet and follow lowercase_with_underscores lint rule 
```
# For example:
```

    Bad: house512.png
    Good: house_large.png

    Bad: blackBike.png
    Good black_bike.png
```

- you can also change file or class name according to your choice.
- see [example file](/example/pubspec.yaml)