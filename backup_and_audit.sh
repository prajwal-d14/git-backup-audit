#!/bin/bash

Today=$(date +%Y%m%d_%H%M%S)
file="/home/ec2-user/repo-list.txt"

while IFS= read -r repo; do
    if [ -z "$repo" ]; then
        continue
		
	fi
	
	reponame=$(basename "$repo" .git)
	
	if [ -d "$reponame" ]; then
	
	cd $reponame
	
    git pull $repo
	
	sleep 10
	
	sudo tar -czf /home/ec2-user/git-backup-audit/${reponame}-$Today.tar.gz -C /home/ec2-user $reponame

	sleep 5
	
	git log --since=1.day >> /home/ec2-user/$reponame-audit-$Today.txt
	
	cd ..
	
	sudo mv	$reponame-audit-$Today.txt /home/ec2-user/git-backup-audit/
	
	else
	
		git clone $repo
		
	fi

	done < "$file"
