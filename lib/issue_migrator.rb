require 'octokit'

class IssueMigrator

  attr_accessor :issues, :client, :target_repo, :source_repo

  def initialize(username, password, source_repo, target_repo)
    @client = Octokit::Client.new(:login => username, :password => password)
    @source_repo = source_repo
    @target_repo = target_repo
  end

  def pull_source_issues
    @client.auto_paginate = true
    @issues = @client.issues(@source_repo, {:state => 'all'})
  end

  def push_issues
    @issues.reverse!
    @issues.each do |source_issue|
      source_labels = get_source_labels(source_issue)
      source_comments = get_source_comments(source_issue)
      if !source_issue.key?(:pull_request) || source_issue.pull_request.empty?
        target_issue = @client.create_issue(@target_repo, source_issue.title, source_issue.body, {labels: source_labels})
        push_comments(target_issue, source_comments) unless source_comments.empty?
        @client.close_issue(@target_repo, target_issue.number) if source_issue.state === 'closed'
      end
    end
  end

  def get_source_labels(source_issue)
    labels = []
    source_issue.labels.each do |lbl|
      labels << lbl.name
    end
    labels
  end

  def get_source_comments(source_issue)
    comments = []
    source_comments = @client.issue_comments(@source_repo, source_issue.number)
    source_comments.each do |cmt|
      comments << cmt.body
    end
    comments
  end

  def push_comments(target_issue, source_comments)
    source_comments.each do |cmt|
      @client.add_comment(@target_repo, target_issue.number, cmt)
    end
  end
end


