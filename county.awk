# Extract county data from census flat file.
# Wed Jan 22 19:10:44 EST 2014
# Mark Bucciarelli

BEGIN {
	OFS = "\t"
	print "county_ansi,state_ansi,county_fips,name,population"
	fmt = "%s,%s,%s,%s,%s\n"
	}

# Summary Level 050 = State-County.  
#
# See "Summary Level Sequence Chart" from the 2010 Census Demographic
# Profile Summary File (page 3-1 of demographic-profile.pdf).
#
# Column start and size used below are from Figure 2-4 of the same
# document (page 2-7).
#
# The ANSI codes are now preferred over FIPS.
substr($0, 9, 3) ~ /050/ {
	county_ansi = substr($0, 382,  8)
	state_ansi  = substr($0, 374,  8)
	county_fips = substr($0,  30,  3)
	name        = substr($0, 227, 90)
	population  = substr($0, 319,  9)
	#latitude    = substr($0, 337, 11)
	#longitude   = substr($0, 348, 12)

	# Trim leading spaces.
	gsub("  +", "", name)
	gsub("^ *", "", population)

	printf fmt, county_ansi, state_ansi, county_fips, name, population
	}
