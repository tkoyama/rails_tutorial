#!/bin/bash

slack_url="https://hooks.slack.com/services/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"
circleci="<https://circleci.com/gh/vividmuimui/rails_tutorial|rails_tutorial>"

curl -X POST --data-urlencode "payload={\"username\": \"Deploy\", \"text\": \"CircleCI is deploying ${circleci}\", \"icon_emoji\": \":shipit:\"}" $slack_url

git push git@heroku.com:rails-tutorial-sample-vivid.git $CIRCLE_SHA1:master
heroku run rake db:migrate --app rails-tutorial-sample-vivid

if [ $? -eq 0 ]
then
    curl -X POST --data-urlencode "payload={\"username\": \"Success\", \"text\": \"CircleCI deployed $circleci successfully.\", \"icon_emoji\": \":ok_woman:\"}" $slack_url
    true
else
    curl -X POST --data-urlencode "payload={\"username\": \"Failed\", \"text\": \"CircleCI failed to deploy ${circleci}\", \"icon_emoji\": \":imp:\"}" $slack_url
    false
fi

