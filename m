Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9344265BA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Sep 2020 10:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgIKIbS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Sep 2020 04:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgIKIbO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Sep 2020 04:31:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B712DC061573;
        Fri, 11 Sep 2020 01:31:14 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gf14so1344111pjb.5;
        Fri, 11 Sep 2020 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LbQB3S5x6xx4Jb0zTm7XcQVbWl22yVn5g91syEiS2MQ=;
        b=syVOVe01zamEEPtzfkERcVBgF2XqcoIOensW1NDs3k5WbB5AycPUJOdgKYPtS37I/i
         6bk/tCHeeZ1/6Wj97w+BE6rWK6kWU8L9mBUWBdYVr5EQ9zD3ZBqcFaLQZ0RxEzoeUxSf
         wScWUqf9iiNM/QFLCFFBRe2dg/OtTosjHYCqI4pHSLTgsP41s7FucscOwYt+8gbNFrr9
         4Ebp0E8JYXJ7vR5wqWtPSIA/sxoKgtdiQnhbJcoxxzjUejFk//H1ajDpmz+u/t2SvSZ6
         Rs19fFRDDk0HvmrJZwGkVjImUg/9+HSiUGKrFUOGgkZCSnQt02/jcZzjj64k4YwjKmia
         SwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LbQB3S5x6xx4Jb0zTm7XcQVbWl22yVn5g91syEiS2MQ=;
        b=glF+9fUiEKAn1cN4w4jUACANwh/gWBBDP4mheLHVV9KMIsXVCdCtsforZUBZzEHjWS
         9OLhBQDh7Ub0sFG8Get0uV5dE/etj13htgboH9G7Lv/gGXsXfYyaM2Kqryxzq4qLIiHW
         99yyWZ1/l+jTFiIGLeeQkRFzDsGd8ZTNgWDWDnEY6/bL1EXMAFuVlkm9QCeo89mpmmIA
         EkizsvzHLUjq/DcHQH6Bk9lksC84bzXNVCNuqBelxPdLVRoi4x8mP3wUJYuMa+FCWPfx
         bLegasXO+IglrW7JAYYiWSvrLMcpfxgSPpCzbf2kttvknbB8L/JfCCrlgHgia2piMLhM
         xkyg==
X-Gm-Message-State: AOAM530hxytLFCxoQE8P9bzrsBFuyN8SJFQVaBZMyF4dwCwu5nXfagTp
        9ZMMhVTirv+aVCjDwvqHs1FPkN8EVTMmXQ==
X-Google-Smtp-Source: ABdhPJzf5Vdy7OT8jta7JYuEdU/QgbIjnz8gLz87+YOYvLHhXECrx3I5CToJgiX7oZFsXO0xmgUP9g==
X-Received: by 2002:a17:90a:a081:: with SMTP id r1mr1249361pjp.159.1599813073748;
        Fri, 11 Sep 2020 01:31:13 -0700 (PDT)
Received: from dhcp-12-153.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x9sm1527084pfj.96.2020.09.11.01.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 01:31:13 -0700 (PDT)
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3] selftests/run_kselftest.sh: make each test individually selectable
Date:   Fri, 11 Sep 2020 16:30:53 +0800
Message-Id: <20200911083053.2816576-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200316072626.24037-1-liuhangbin@gmail.com>
References: <20200316072626.24037-1-liuhangbin@gmail.com>
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
        -h | --help ) usage; exit 0;;
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
v3:
1) rebase the patch to latest code
2) move `tr -s "/-" "_"` to the for loop at the end so user could use test
   folder name directly. Before the update, user need to run
   ./run_kselftest.sh -t 'networking_forwarding'. Now they can just run
   ./run_kselftest.sh -t 'networking/forwarding' directly.

v2: update document and commit description.
---
 Documentation/dev-tools/kselftest.rst |  4 +++
 tools/testing/selftests/Makefile      | 49 +++++++++++++++++++++------
 tools/testing/selftests/lib.mk        |  2 +-
 3 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 469d115a95f1..94da633dd5f8 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -151,6 +151,10 @@ note some tests will require root privileges::
    $ cd kselftest
    $ ./run_kselftest.sh
 
+Or you can run some specific test cases in the installed Kselftests by::
+
+   $ ./run_kselftest.sh -t "bpf size timers"
+
 Packaging selftests
 ===================
 
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 15c1c1359c50..6b11d5e33019 100644
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
@@ -239,15 +235,48 @@ ifdef INSTALL_PATH
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
+	echo -e "\t-h | --help\t\tShow this usage info" >> $(ALL_SCRIPT);
+	echo "EOF" >> $(ALL_SCRIPT);
+	echo "}" >> $(ALL_SCRIPT);
+	echo "" >> $(ALL_SCRIPT);
+
+	echo "while true; do" >> $(ALL_SCRIPT);
+	echo -e "\tcase \"\$$1\" in" >> $(ALL_SCRIPT);
+	echo -e "\t-s | --summary ) logfile=\$$BASE_DIR/output.log; cat /dev/null > \$$logfile; shift ;;" >> $(ALL_SCRIPT);
+	echo -e "\t-t | --tests ) TESTS=\$$2; shift 2 ;;" >> $(ALL_SCRIPT);
+	echo -e "\t-h | --help ) usage; exit 0;;" >> $(ALL_SCRIPT);
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

