Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A969F1865AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Mar 2020 08:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgCPH0k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Mar 2020 03:26:40 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38316 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729554AbgCPH0k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Mar 2020 03:26:40 -0400
Received: by mail-qv1-f67.google.com with SMTP id p60so8273120qva.5;
        Mon, 16 Mar 2020 00:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=faItreCP5r0+oIAAYCGxgKu+OE+Ay1+bPlAFFz83FQI=;
        b=Q7F+KDCGPJ83Hxlp9t40RdunVcdST3R/waK3vYRcxAJDcMvQpnCpubDp8M0a0QEbte
         HhDhhKXSy3fWSB8W4gLtmjn9nZiklQ0XoeVAyHr50MJMd3Yrjq9fox8OVpiG07KlyCCY
         dZGSB2Ys2aTBzYaK/Km4++srjG7qaNQBlJvx1i3m4Wqln5gkDGr/6SC0nDtTttGRd/DH
         3+E0inqsyO+eqUTD6XmUZ/wCx77U76IxknXD5xmnCuNCyyv/x4bm43yljV1FfqgneJlX
         Z5DdRJ8EKPVQG+vkjrG7NKOUYo3tVYiJeIaTurAcs3l5+ZGbM0WCJb+A+oWls0MKZ+x5
         UZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=faItreCP5r0+oIAAYCGxgKu+OE+Ay1+bPlAFFz83FQI=;
        b=efU2BQ481TOrxFY/a12DacsANr1H0Pp6u8xcBjoteplMQKSVfl1LAir1fFAHlZM6wW
         GuI+ILi/eBS1GWonDoBHpd3gxinfqpcFqxNyZWK5fQg/4FI5ICWYUwnqTXOLbghnWczS
         kHGrJQDu8MBjuJLgEy/vLOs9iKexTzSsI9Wk2+g+296UoYdK06r6QKLoVamjzMY6jK0o
         qJS2UDuDwlW7P4br5bqa0qEDWhsqdJzysAG/1+aFFzq7qVM+6h7aIv+CaY2AZXpT30/u
         4muD3aasN8JekVkuIgMRQLIXHDy1MTHPn+MA2FjMLBQ17J/8X1csOaLxGsgw8c0OIoG3
         yCTw==
X-Gm-Message-State: ANhLgQ3EzOon1/Tsrd7NzH5wpg+oAhNTxU8VDKeJt+HtCxSToTf732QP
        EjCCv/5D3FrqlfAXnVYB60hizvlPAes=
X-Google-Smtp-Source: ADFU+vt9LUg8yfYeUPu6y6CbYlK4XN761ggzE4bPBRB7Aq8wc3/fWOqXg7FwQ1Tfwd4PzHVK+MC7AQ==
X-Received: by 2002:ad4:4364:: with SMTP id u4mr11000387qvt.58.1584343598492;
        Mon, 16 Mar 2020 00:26:38 -0700 (PDT)
Received: from dhcp-12-139.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b7sm16799644qkh.0.2020.03.16.00.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 00:26:37 -0700 (PDT)
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>
Subject: [RFC PATCHv2] selftests/run_kselftest.sh: make each test individually selectable
Date:   Mon, 16 Mar 2020 15:26:26 +0800
Message-Id: <20200316072626.24037-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20200309101256.868-1-liuhangbin@gmail.com>
References: <20200309101256.868-1-liuhangbin@gmail.com>
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

Note: I use `tr -s "/-" "_"` to cover the path name to function name in
tests. e.g. networking/timestamping -> networking_timestamping.

Before the patch:

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
$ cat run_kselftest.sh
\#!/bin/sh
BASE_DIR=$(realpath $(dirname $0))
. ./kselftest/runner.sh
TESTS="android ...<snip>... zram"

run_android()
{
        [ -w /dev/kmsg ] && echo "kselftest: Running tests in android" >> /dev/kmsg
        cd android
        run_many        \
                "run.sh"
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
for test in $TESTS; do
        run_$test
done

v2: update document and commit description.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/dev-tools/kselftest.rst |  4 +++
 tools/testing/selftests/Makefile      | 48 +++++++++++++++++++++------
 tools/testing/selftests/lib.mk        |  2 +-
 3 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 61ae13c44f91..e856713a1deb 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -151,6 +151,10 @@ note some tests will require root privileges::
    $ cd kselftest
    $ ./run_kselftest.sh
 
+Or you can run some specific test cases in the installed Kselftests by::
+
+   $ ./run_kselftest.sh -t "bpf size timers"
+
 Contributing new tests
 ======================
 
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index be22dbe94a4c..5481ea0634cf 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -212,13 +212,9 @@ ifdef INSTALL_PATH
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
+	echo "TESTS=\"$(TARGETS)\"" | tr -s "/-" "_" >> $(ALL_SCRIPT)
+	echo "" >> $(ALL_SCRIPT);
 
 	@# While building run_kselftest.sh skip also non-existent TARGET dirs:
 	@# they could be the result of a build failure and should NOT be
@@ -226,15 +222,47 @@ ifdef INSTALL_PATH
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
+	echo "for test in \$$TESTS; do" >> $(ALL_SCRIPT); \
+	echo -e "\trun_\$$test" >> $(ALL_SCRIPT); \
+	echo "done" >> $(ALL_SCRIPT); \
 	chmod u+x $(ALL_SCRIPT)
 else
 	$(error Error: set INSTALL_PATH to use install)
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 1c8a1963d03f..2dc5a0cca6f3 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -107,7 +107,7 @@ emit_tests:
 	for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \
 		BASENAME_TEST=`basename $$TEST`;	\
 		echo "	\\";				\
-		echo -n "	\"$$BASENAME_TEST\"";	\
+		echo -ne "\t\t\"$$BASENAME_TEST\"";	\
 	done;						\
 
 # define if isn't already. It is undefined in make O= case.
-- 
2.19.2

