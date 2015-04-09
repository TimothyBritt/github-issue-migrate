# Github Issue Migrator
A simple, interactive Ruby class that helps you migrate issues from one repository to another

Sometimes, the structure of your project changes so drastically that it would break your repository.
You need an easy way to start from scratch and just commit everything to a new repository.
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
irb> im.pull_source_issues
  => [{...}]
  
irb> im.push_issues
```

This will migrate issues, their labels, and their comments, in order from the source to the target. Done!

### Considerations

- This simple tool utilizes the [Octokit](https://github.com/octokit/octokit.rb) library for all the heavy lifiting.
- The octokit auto-paginate feature will only handle smallish collections of issues (if you have under 500, you should be okay.) If you have a large list of issues, you will have to hack the code to handle this.
- Label colors are not transferred but the labels are. You can easily reapply the colors of your labels by editing the labels in the issues panel of your repository.
- Original names of issue creators are not preserved. All migrated issues are shown as "Opened by" the username used in the migration client initializer.
- Created at timestamps are not preserved, all issues will show as created at the time that the migration was executed.

This is a super-simple, utility that could be easily adapted and reused in other projects! 
Feel free to fork, break, fix and contribute. Enjoy!
