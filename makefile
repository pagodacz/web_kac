deploy: 
	git push
	ssh j2m "cd www-prague-go-tournament; git pull"
