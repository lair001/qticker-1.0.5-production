require 'spec_helper.rb'

describe 'MainCli' do 

	let(:cli){MainCli.new}

	describe '#intialize' do
		it 'initializes a MainCli with a Scraper a DevCli' do
			expect(cli).to be_a(MainCli)
			expect(cli.scraper).to be_a(Scraper)
			expect(cli.dev).to be_a(DevCli)
		end
	end

	describe '#welcome, #ticker_symbol_prompt, #symbol_validation, #display_quote, #display_desc, #option_menu' do 
		it 'welcomes the user and allows the user to enter a stock symbol and view information on the company.' do 
			allow(cli).to receive(:gets).and_return("IBM", "\n", "1", "\n", "\n")
			output = capture_puts{cli.welcome("Quick Ticker", -> {cli.ticker_symbol_prompt})}
			expect(output).to include("Welcome to Quick Ticker!\n\nPlease enter a ticker symbol:")
			expect(output).to include("International Business Machines Corp. (NYSE:IBM)\n\nCurrent:")
			expect(output).to include("International Business Machines Corp. (NYSE:IBM)\n\nTechnology : IT Services & Consulting - NEC")
			expect(output).to include("1. Display a company description for IBM.\n2. Enter another ticker symbol.\nEnter any other key to exit.")
			expect(output).to include("1. Redisplay your quote for IBM.\n2. Enter another ticker symbol.\nEnter any other key to exit.")
		end
	end

	describe '#symbol validation' do 
		it 'prompts the user to input another ticker symbol if the user inputs an invalid symbol or a symbol for a mutual fund' do 
			allow(cli).to receive(:gets).and_return("a1b2c3d4", "FBIOX", "IBM", "\n", "1", "\n", "\n")
			output = capture_puts{cli.welcome("Quick Ticker", -> {cli.ticker_symbol_prompt})}
			expect(output).to include("Invalid ticker symbol.\n\nPlease enter a ticker symbol:")
			expect(output).to include("Invalid ticker symbol.\nMutual funds are not currently not supported.\n\nPlease enter a ticker symbol:")
		end
	end

end