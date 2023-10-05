# Remove zip file if one already exists
rm lambda_function_payload.zip

# Create a zip file with the installed libraries
cd dependecies
pip install --target ./dependecies boto3
pip install --target ./dependecies json
pip install --target ./dependecies uuid
pip install --target ./dependecies datetime

zip -r ../lambda_function_payload2.zip dependecies

# Add the lambda_function.py file to the root of the zip file
cd ..
zip lambda_function_payload2.zip lambda_function.py