def camelize(str)
  # Removes spaces, underscores and hyphens, and capitalizes the first letter of each word
	str.split(/ |\_|\-/).map(&:capitalize).join()
end

# Path to the directory with images
PATH = "./images";

# Specify relative path in the export string, 
# for example, "./images" in "export { default as myInfo } from './images/myInfo.png';"
path_in_export_string = "./images"

# Get the names of the files in the specified directory
file_names = Dir.entries(PATH).drop(2)

# Declare a variable to store export strings
export_string = "";

# For each .png file, create the export string,
# for example, "export { default as myInfo } from './images/myInfo.png';"
file_names.each do |file_name|
	# Get the name of the file and the extension separately
	file_name_without_ext = file_name.split(".")[0]
	file_ext = file_name.split(".")[1];

	# Skip non-png files, and the files with @ in the name
	next if file_ext != "png" || file_name_without_ext.include?("@")

	# Make the camel case version of file names
  file_name_camel_case = camelize(file_name_without_ext)

  # Construct the export string
  export_string += "export { default as #{file_name_camel_case} } from '#{path_in_export_string}/#{file_name}';\n"
end

File.open("index.ts", 'w') { |f| f.write(export_string) }