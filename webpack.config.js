const path = require('path');

module.exports = {
	module: {
		rules: [
			{
				test: /\.imba$/,
				loader: 'imba/loader'
			}
		]
	},
	devServer: {
		contentBase: path.resolve(__dirname, 'public'),
		watchContentBase: true,
		historyApiFallback: true
	},
	resolve: {
		extensions: [".imba", ".js", ".json", ".css"],
		alias: {
      "#": path.resolve(__dirname, 'src/components/'),
			"~": path.resolve(__dirname, 'src/models'),
			"@": path.resolve(__dirname, 'src/'),
    }
	},
	entry: "./src/client.imba",
	output: { path: __dirname + '/dist', filename: "client.js" }
}