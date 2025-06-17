#!/bin/bash

Today=$(date+%Y%m%d_%H%M%S)
file="/home/ubuntu/repo-list.txt"

while IFS= read -r repo; do
    if [ -z "$repo" ]; then
        continue
		
	fi
	
	reponame=$(basename "$repo" .git)
	
	if [ -d "$reponame" ]; then
	
	cd $reponame
	
    	git pull $repo
	
	sleep 10
	
	sudo tar -czf /home/ubuntu/git-backup-audit/${reponame}-$Today.tar.gz -C /home/ubuntu $reponame

	sleep 5
	
	sudo git log --since=1.day >> /home/ubuntu/git-backup-audit/$reponame-audit-$Today.txt

	cat /home/ubuntu/git-backup-audit/$reponame-audit-$Today.txt
	
	else
	
		git clone $repo
		
	fi

	done < "$file"
