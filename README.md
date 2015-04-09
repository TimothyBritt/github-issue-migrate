# Github Issue Migrator
A simple, interactive Ruby class that helps you migrate issues from one repository to another

Sometimes, the structure of your project changes so drastically that it would break your repository.
You need an easy way to start from scratch and just commit everyything to a new repository.
But, you've got all these valuable issues in the repository on Github.

You need an easy way to migrate those.

The github-issue-migrate is a simple Ruby class that you can use require inside an irb session and
interactively migrate your issues from one repository you have permissions on, to another.

Try it out:

```
$: git clone https://github.com/trbritt/github-issue-migrate.git
$: cd github-issue-migrate && bundle install

$: irb

irb> require 'path/to/repo/lib/issue_migrator.rb'
irb> im = IssueMigrator.new("username", "password", "owner/source_repo", "owner/target_repo")
irb> im.pull_issues
  => [{...}]
  
irb> im.push_issues
```

This will migrate issues, their labels, and their comments, in order from the source to the target. Done!

This is a super-simple, utility that could be easily adapted and reused in other projects! 
Feel free to fork, break, fix and contribute. Enjoy!
