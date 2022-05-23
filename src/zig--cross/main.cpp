#include <cstdlib>
#include <cstdio>
#include <string>
#include <vector>

// Source: https://stackoverflow.com/a/57346888/1806760
std::vector<std::string> split(const std::string& i_str, const std::string& i_delim)
{
	std::vector<std::string> result;

	size_t found = i_str.find(i_delim);
	size_t startIndex = 0;

	while (found != std::string::npos)
	{
		result.push_back(std::string(i_str.begin() + startIndex, i_str.begin() + found));
		startIndex = found + i_delim.size();
		found = i_str.find(i_delim, startIndex);
	}
	if (startIndex != i_str.size())
		result.push_back(std::string(i_str.begin() + startIndex, i_str.end()));
	return result;
}

int main(int argc, char** argv)
{
	auto program = std::string(argv[0]);
	{
		auto slash = program.find_last_of("/\\");
		if (slash != std::string::npos)
			program = program.substr(slash + 1);
		auto dot = program.find_last_of('.');
		if (dot != std::string::npos)
			program.resize(dot);
	}
	auto commands = split(program, "--");
	if (commands.at(0) != "zig")
	{
		fprintf(stderr, "Program is named '%s', should be: zig--<command>\n", program.c_str());
		return EXIT_FAILURE;
	}
	auto subcommand = commands.at(1);
	std::string command_line = "zig " + subcommand;
	for (int i = 1; i < argc; i++)
	{
		command_line += ' ';

		auto arg = std::string(argv[i]);
		// TODO: more quoting rules
		if (arg.find(' ') != std::string::npos)
		{
			arg = "\"" + arg + "\"";
		}
		command_line += arg;
	}
	return std::system(command_line.c_str());
}