Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E550C17DD04
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Mar 2020 11:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgCIKNM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Mar 2020 06:13:12 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33248 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIKNM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Mar 2020 06:13:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id d22so6564395qtn.0
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Mar 2020 03:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DTJKzFQSjQhbh2x0Oyy+sE5j12gSTOlD7QkiPO1+EYI=;
        b=ZujUKSXHYcD6kFn/MaNdpODSGOut11qDYS1oYN2JQKR5XeXX/8x/VJi8qQEY1bJHQ6
         vKb5V/C/9j9JtJUdpViV09+OXyjli/iTaQhT780zHE93D2WG+gr+YrDBH4RXt4yn+W3P
         9mUWREQi0o5wY3enCkcBetAgcydc/jO7ZbfDEzkQYLMy+rgyWDGkyQmPpBf9I2Vmvp8W
         ayE1T/0Jl6Ac2woXvtZzORwr24cKBm1OE5d3dkva9PlGjz7pTwWj+GZbLj7KbPnsc3uO
         vHuh49szSj7XtOlIRgNGxm4D7hjmNKg6dIa4eInG9vtGjq/+xzWFGJNJRJvXuBTvlH2E
         Otxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DTJKzFQSjQhbh2x0Oyy+sE5j12gSTOlD7QkiPO1+EYI=;
        b=UyjPEAXs1sCHdG1KbXLdn9tz6ny3iEujxgQw504wg1SZQcyz0jrUCPvVt1RBtsRyXF
         4AgVaGai9UckvKxh3MqqnyJthQ9+aHd3iI4xbKhvpCy7svdoc0BoJEO+MffSjIP/BHJ2
         bkcAmvy69kx0ZHiEw36EgNhI2u0H5v6lO7eVobdShCFvNueTF6LaGOcxSSp+NaBlhETW
         kA9W5eUqlqd5Qaz/rYccuoMFaMQ3I+bkKDcpv4EenE63zBQKL4JSc0/m+STxzJbqXJwR
         Q85PlcPfBGLBPLWwgKje2ChrFlGVzoz/012zzqKbhdkQ4LyILdX5Pdsc73pPpq+iL5ai
         a1lw==
X-Gm-Message-State: ANhLgQ0i6AuN/syXSE/xAyWYxyqD3joUdDIpYnxfoWUIBIMiCufudfkj
        Ha+CwZv9oDt5B3ld5+Z+pdSgfUs22ro=
X-Google-Smtp-Source: ADFU+vtE0MLb2a1/GHq4N3nsmK4DTOWIfQ4YiLKKh4dA+lEfL4j2Bg2AbsZq9IacvbL00AJyGPqvpw==
X-Received: by 2002:ac8:7158:: with SMTP id h24mr13595919qtp.63.1583748790889;
        Mon, 09 Mar 2020 03:13:10 -0700 (PDT)
Received: from dhcp-12-139.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t3sm20374416qkt.114.2020.03.09.03.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 03:13:10 -0700 (PDT)
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuahkh@osg.samsung.com>,
        Hangbin Liu <liuhangbin@gmail.com>
Subject: [RFC PATCH 1/1] selftests/run_kselftest.sh: make each test individually selectable
Date:   Mon,  9 Mar 2020 18:12:56 +0800
Message-Id: <20200309101256.868-2-liuhangbin@gmail.com>
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
the tests individually selectable.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/Makefile | 48 +++++++++++++++++++++++++-------
 tools/testing/selftests/lib.mk   |  2 +-
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6ec503912bea..3d4bc0071849 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -220,13 +220,9 @@ ifdef INSTALL_PATH
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
@@ -234,15 +230,47 @@ ifdef INSTALL_PATH
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
index 3ed0134a764d..c352d6dab91d 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -110,7 +110,7 @@ emit_tests:
 	for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \
 		BASENAME_TEST=`basename $$TEST`;	\
 		echo "	\\";				\
-		echo -n "	\"$$BASENAME_TEST\"";	\
+		echo -ne "\t\t\"$$BASENAME_TEST\"";	\
 	done;						\
 
 # define if isn't already. It is undefined in make O= case.
-- 
2.19.2

