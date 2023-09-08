# Remove zip file if one already exists
rm my_deployment_package.zip

# Create a zip file with the installed libraries
cd dependecies
zip -r ../my_deployment_package.zip

# Add the lambda_function.py file to the root of the zip file
cd ..
zip my_deployment_package.zip lambda_function.py