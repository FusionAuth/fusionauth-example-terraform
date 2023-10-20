#!/bin/bash
docker compose up -d;
mkdir fusionauth-cli;
cd fusionauth-cli/;
npm i @fusionauth/cli;
npx fusionauth email:download -k RySMQQxaTxuoqW5LetZ3YBLJZ28FKV_IpFBHZQaeb5zCy1Eko6lXCMQ_;
mkdir templates;
for fullTemplateName in `ls */name.txt`; do
  templateName=`cat $fullTemplateName | nawk -F"] " '{ print $2 }'`;
  fileTemplateName=`sed 's/ /_/g' <<< $templateName`;
  echo `echo $fullTemplateName | nawk -F/ '{ print "cp "$1"/body.txt" }'` templates/$fileTemplateName.txt.ftl;
  echo `echo $fullTemplateName | nawk -F/ '{ print "cp "$1"/body.html" }'` templates/$fileTemplateName.html.ftl;
done;
