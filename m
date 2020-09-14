Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7238C26828C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Sep 2020 04:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgINCW6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Sep 2020 22:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgINCWx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Sep 2020 22:22:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6377BC06174A;
        Sun, 13 Sep 2020 19:22:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o16so4668409pjr.2;
        Sun, 13 Sep 2020 19:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b2bBXZkh0jhvef6kCSC1RofX3ZIFXsI/OhQfJ9yWyI8=;
        b=ba7opNHLboxB61OBFimi217/Gvjk9FYh6u1x8tswdV5o5eHlZDncYNta6PXyzBH8VX
         xlxdVX/0xC9Z0fbagyoVFSeLQAXhARaqHRv+6+II4Mab7neZ5UufDYnuV9UcD0NWbSTX
         M46oPX5wMqrBHXQvc9Du2xV0Ru65n+NH8Oga5dsfO+ejxIHxD/eMom89rZyhBPHWLWQD
         6k0htSaRJO39e21r4zWZqgy1Ai44ku74FSyxFLpS097HL4L+gqu+QiurJjHd7nV73vHU
         ThR/Dzf2Rlk6EdASFmX3vvoPglvvXnIKfr+AmkArpjrdXuIhZIQHa8BgQjmVbBd+f9Va
         QtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2bBXZkh0jhvef6kCSC1RofX3ZIFXsI/OhQfJ9yWyI8=;
        b=OZrCJEh/oCvPUaocep4CmciBkRhIkWumbXs6CQM4a27eXt7dYGSkW3b9js4KoiGC8t
         Gwyp1wvaM4L5/kZqQH3S77Lw1B4l8kp6IU3T+jgsprvmWo7giCv/4OZTxOyCoAMHCSpd
         z69Ug/V0stOD+omQmvooM2YvrCMh6i2H/MXZbfZMtMTtnqOknynuflseYt+3A16mnTkj
         zcTWYx6Lc2I6nbAWlQODgNR/V6nkEYQZd65bA6PE6q/21ZyHmLunym3VeSCJVe2K1NnL
         trzZ0xm5cfklgQHy6iINot7ZcxT+mQkBKOtpHEuMcg8+aMytJjjYE0xg/dww1/1MVpiF
         2zJQ==
X-Gm-Message-State: AOAM530LgOXznktpSe1hYWSSFhBTTIMbINYDLNWr9ulOscFI4f7bvNOT
        d+gPbZWck7gCPQ3qc+iLPdKOtb2G45NfKQ==
X-Google-Smtp-Source: ABdhPJybRO5QZZZU7FOZj/R0+f/hWTOqWRxKUsJlGGHX038s2f3u9fSPj91Hyt4IWNR6U/2gHn8HzA==
X-Received: by 2002:a17:90a:a787:: with SMTP id f7mr11264165pjq.99.1600050172656;
        Sun, 13 Sep 2020 19:22:52 -0700 (PDT)
Received: from dhcp-12-153.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n2sm8398125pfa.182.2020.09.13.19.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 19:22:52 -0700 (PDT)
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tim.Bird@sony.com,
        Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv5 kselftest next] selftests/run_kselftest.sh: make each test individually selectable
Date:   Mon, 14 Sep 2020 10:22:27 +0800
Message-Id: <20200914022227.437143-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200914021758.420874-1-liuhangbin@gmail.com/>
References: <20200914021758.420874-1-liuhangbin@gmail.com/>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, after generating run_kselftest.sh, there is no way to choose
which test we could run. All the tests are listed together and we have
to run all every time. This patch enhanced the run_kselftest.sh to make
the tests individually selectable. e.g.

  $ ./run_kselftest.sh -t "bpf size timers"

Before the patch:
================

$ cat run_kselftest.sh
\#!/bin/sh
BASE_DIR=$(realpath $(dirname $0))
cd $BASE_DIR
. ./kselftest/runner.sh
ROOT=$PWD
if [ "$1" = "--summary" ]; then
  logfile=$BASE_DIR/output.log
  cat /dev/null > $logfile
fi
[ -w /dev/kmsg ] && echo "kselftest: Running tests in android" >> /dev/kmsg
cd android
run_many        \
        "run.sh"
cd $ROOT
...<snip>...
[ -w /dev/kmsg ] && echo "kselftest: Running tests in zram" >> /dev/kmsg
cd zram
run_many        \
        "zram.sh"
cd $ROOT

After the patch:
===============

$ cat run_kselftest.sh
\#!/bin/sh
BASE_DIR=$(realpath $(dirname $0))
. ./kselftest/runner.sh
TESTS="android ...<snip>... filesystems/binderfs ...<snip>... zram"

run_android()
{
        [ -w /dev/kmsg ] && echo "kselftest: Running tests in android" >> /dev/kmsg
        cd android
        run_many        \
                "run.sh"
        cd $ROOT
}

...<snip>...

run_filesystems_binderfs()
{
        [ -w /dev/kmsg ] && echo "kselftest: Running tests in filesystems/binderfs" >> /dev/kmsg
        cd filesystems/binderfs
        run_many        \
                "binderfs_test"
        cd $ROOT
}

...<snip>...

run_zram()
{
        [ -w /dev/kmsg ] && echo "kselftest: Running tests in zram" >> /dev/kmsg
        cd zram
        run_many        \
                "zram.sh"
        cd $ROOT
}

usage()
{
        cat <<EOF
usage: ${0##*/} OPTS
        -s | --summary          Only print summary info and put detailed log in output.log
        -t | --tests            Test name you want to run specifically
        -h | --help             Show this usage info
EOF
}

while true; do
        case "$1" in
        -s | --summary ) logfile=$BASE_DIR/output.log; cat /dev/null > $logfile; shift ;;
        -t | --tests ) TESTS=$2; shift 2 ;;
	-l | --list ) echo $TESTS; exit 0 ;;
        -h | --help ) usage; exit 0 ;;
        "" ) break;;
        * ) usage; exit 1;;
        esac
done

cd $BASE_DIR
ROOT=$PWD
for folder in $TESTS; do
        folder=$(echo $folder | tr -s '/-' '_')
        run_$folder
done

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

---
v5:
Forgot to update commit description for the new added -l option

v4:
Add parameter -l to list available tests, suggested by Bird, Tim

v3:
1) rebase the patch to latest code
2) move `tr -s "/-" "_"` in for loop at the end so user could use test
   folder name directly. Before the fix, user need to use
   ./run_kselftest.sh -t 'networking_forwarding'. Now they can just run
   ./run_kselftest.sh -t 'networking/forwarding' directly.

v2: update document and commit description.
---
 Documentation/dev-tools/kselftest.rst |  8 +++++
 tools/testing/selftests/Makefile      | 51 +++++++++++++++++++++------
 tools/testing/selftests/lib.mk        |  2 +-
 3 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 469d115a95f1..7b92f9c177f6 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -151,6 +151,14 @@ note some tests will require root privileges::
    $ cd kselftest
    $ ./run_kselftest.sh
 
+Or you can run some specific test cases in the installed Kselftests by::
+
+   $ ./run_kselftest.sh -t "bpf size timers"
+
+You can view the available tests to run with::
+
+   $ ./run_kselftest.sh -l
+
 Packaging selftests
 ===================
 
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 15c1c1359c50..4c8159dd2bd7 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -225,13 +225,9 @@ ifdef INSTALL_PATH
 	@# Ask all targets to emit their test scripts
 	echo "#!/bin/sh" > $(ALL_SCRIPT)
 	echo "BASE_DIR=\$$(realpath \$$(dirname \$$0))" >> $(ALL_SCRIPT)
-	echo "cd \$$BASE_DIR" >> $(ALL_SCRIPT)
 	echo ". ./kselftest/runner.sh" >> $(ALL_SCRIPT)
-	echo "ROOT=\$$PWD" >> $(ALL_SCRIPT)
-	echo "if [ \"\$$1\" = \"--summary\" ]; then" >> $(ALL_SCRIPT)
-	echo "  logfile=\$$BASE_DIR/output.log" >> $(ALL_SCRIPT)
-	echo "  cat /dev/null > \$$logfile" >> $(ALL_SCRIPT)
-	echo "fi" >> $(ALL_SCRIPT)
+	echo "TESTS=\"$(TARGETS)\"" >> $(ALL_SCRIPT)
+	echo "" >> $(ALL_SCRIPT);
 
 	@# While building run_kselftest.sh skip also non-existent TARGET dirs:
 	@# they could be the result of a build failure and should NOT be
@@ -239,15 +235,50 @@ ifdef INSTALL_PATH
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		[ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
-		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
-		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
-		echo -n "run_many" >> $(ALL_SCRIPT); \
+		echo "run_$$TARGET()" | tr -s "/-" "_" >> $(ALL_SCRIPT); \
+		echo "{" >> $(ALL_SCRIPT); \
+		echo -e "\t[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
+		echo -e "\tcd $$TARGET" >> $(ALL_SCRIPT); \
+		echo -en "\trun_many" >> $(ALL_SCRIPT); \
 		echo -n "Emit Tests for $$TARGET\n"; \
 		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
 		echo "" >> $(ALL_SCRIPT);	    \
-		echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
+		echo -e "\tcd \$$ROOT" >> $(ALL_SCRIPT); \
+		echo "}" >> $(ALL_SCRIPT); \
+		echo "" >> $(ALL_SCRIPT); \
 	done;
 
+	echo "usage()" >> $(ALL_SCRIPT);
+	echo "{" >> $(ALL_SCRIPT);
+	echo -e "\tcat <<EOF" >> $(ALL_SCRIPT);
+	echo "usage: \$${0##*/} OPTS" >> $(ALL_SCRIPT);
+	echo -e "\t-s | --summary\t\tOnly print summary info and put detailed log in output.log" >> $(ALL_SCRIPT);
+	echo -e "\t-t | --tests\t\tTest name you want to run specifically" >> $(ALL_SCRIPT);
+	echo -e "\t-l | --list\t\tList the available tests" >> $(ALL_SCRIPT);
+	echo -e "\t-h | --help\t\tShow this usage info" >> $(ALL_SCRIPT);
+	echo "EOF" >> $(ALL_SCRIPT);
+	echo "}" >> $(ALL_SCRIPT);
+	echo "" >> $(ALL_SCRIPT);
+
+	echo "while true; do" >> $(ALL_SCRIPT);
+	echo -e "\tcase \"\$$1\" in" >> $(ALL_SCRIPT);
+	echo -e "\t-s | --summary ) logfile=\$$BASE_DIR/output.log; cat /dev/null > \$$logfile; shift ;;" >> $(ALL_SCRIPT);
+	echo -e "\t-t | --tests ) TESTS=\$$2; shift 2 ;;" >> $(ALL_SCRIPT);
+	echo -e "\t-l | --list ) echo \$$TESTS; exit 0 ;;" >> $(ALL_SCRIPT);
+	echo -e "\t-h | --help ) usage; exit 0 ;;" >> $(ALL_SCRIPT);
+	echo -e "\t\"\" ) break;;" >> $(ALL_SCRIPT);
+	echo -e "\t* ) usage; exit 1;;" >> $(ALL_SCRIPT);
+	echo -e "\tesac" >> $(ALL_SCRIPT);
+	echo "done" >> $(ALL_SCRIPT);
+	echo "" >> $(ALL_SCRIPT);
+
+	echo "cd \$$BASE_DIR" >> $(ALL_SCRIPT)
+	echo "ROOT=\$$PWD" >> $(ALL_SCRIPT)
+
+	echo "for folder in \$$TESTS; do" >> $(ALL_SCRIPT); \
+	echo -e "\tfolder=\$$(echo \$$folder | tr -s '/-' '_')" >> $(ALL_SCRIPT); \
+	echo -e "\trun_\$$folder" >> $(ALL_SCRIPT); \
+	echo "done" >> $(ALL_SCRIPT); \
 	chmod u+x $(ALL_SCRIPT)
 else
 	$(error Error: set INSTALL_PATH to use install)
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 51124b962d56..3c4c94a5d184 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -108,7 +108,7 @@ emit_tests:
 	for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \
 		BASENAME_TEST=`basename $$TEST`;	\
 		echo "	\\";				\
-		echo -n "	\"$$BASENAME_TEST\"";	\
+		echo -ne "\t\t\"$$BASENAME_TEST\"";	\
 	done;						\
 
 # define if isn't already. It is undefined in make O= case.
-- 
2.25.4

