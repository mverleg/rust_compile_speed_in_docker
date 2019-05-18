from urllib.request import urlopen
from json import loads
from sys import stderr

PAGES = 3
for page in range(0, PAGES):
	url = 'https://crates.io/api/v1/crates?page={0:d}&per_page=20&sort=recent-downloads'.format(page + 1)
	with urlopen(url) as uh:
		stderr.write('page {} of {}\n'.format(page + 1, PAGES))
		data = loads(uh.read().decode())
		for crate in data['crates']:
			print('{} = {{version = "{}"}}'.format(crate['id'], crate['max_version']))
		
	
