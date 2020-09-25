Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630ED2794EA
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Sep 2020 01:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgIYXpp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Sep 2020 19:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbgIYXpk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Sep 2020 19:45:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFD9C0613D5
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Sep 2020 16:45:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x123so4744538pfc.7
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Sep 2020 16:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gL/U50HEdkA9zXVUDvcxtDA0H6PefSRQ4Pj0UKQtdr8=;
        b=EjXCHxdEWfuZ0hlFxUCXBKAVsg6Kd8LsuE7/9pNrNDaGELlK3IErFX3hdOiQOtF5EW
         YQ5YPYOz8UzQXsHh86gKOa9dfuiBIi1Ml8T2akCjjbUX2kyriDOLN+fGJ/IDMqBlK/ug
         a/TQSInloPGc7rtLXNXafE1MJQDfnhS71emU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gL/U50HEdkA9zXVUDvcxtDA0H6PefSRQ4Pj0UKQtdr8=;
        b=FfLWJvg72rtlU729ztmGOylsQEPP1V8oLqS+BHJbTvuZbVB7sv6pawQSY2acs5sA9D
         qw3xZgiR8fjUUQi9q60NOaUAPgBUIyR9apHjCQXyTxrHOZ/vvxz3485kyvnedDKGGTbI
         1kSYnYtNPAIbyati4Zz6YUwnnaIPPDMfi1afOwLQM4LpnbgnMGZN0UREGTUyZmrM0wDv
         EziZEH2ncRtmruji3FZxR6byeR1PjRhPqRFB/6o2sxr3i3ophELgE1CKULUcd2iDgMq+
         AGC8pC9KcyGwJfWNQ8DjHuW14z2TsVnNmrR4l78W1Iw69BNJmDPBXMInb4zpaPDsXz6R
         dojg==
X-Gm-Message-State: AOAM531bah0ObKEkHRWRXJd2Vn1jEy/h2ivlFrRLPDnBsyqnh/kZ7Jq0
        buyZLFV2ZyB29Z8FPrJnKVwXsA==
X-Google-Smtp-Source: ABdhPJwK7Zm7q3VTbdhKzjMD0TzXRXllcP8ZY7+AZuOENSvc3nOH46qPWFXaNmOEqppXtV56IpyoaQ==
X-Received: by 2002:a62:7b55:0:b029:13e:7367:2b2e with SMTP id w82-20020a627b550000b029013e73672b2emr851114pfc.7.1601077538508;
        Fri, 25 Sep 2020 16:45:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t12sm3564683pfh.73.2020.09.25.16.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:45:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Tim.Bird@sony.com, lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests: Extract run_kselftest.sh and generate stand-alone test list
Date:   Fri, 25 Sep 2020 16:45:26 -0700
Message-Id: <20200925234527.1885234-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925234527.1885234-1-keescook@chromium.org>
References: <20200925234527.1885234-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Instead of building a script on the fly (which just repeats the same
thing for each test collection), move the script out of the Makefile and
into run_kselftest.sh, which reads kselftest-list.txt.

Adjust the emit_tests target to report each test on a separate line so
that test running tools (e.g. LAVA) can easily remove individual
tests (for example, as seen in [1]).

[1] https://github.com/Linaro/test-definitions/pull/208/commits/2e7b62155e4998e54ac0587704932484d4ff84c8

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/Makefile         | 26 +++++++-----------------
 tools/testing/selftests/lib.mk           |  5 ++---
 tools/testing/selftests/run_kselftest.sh | 24 ++++++++++++++++++++++
 3 files changed, 33 insertions(+), 22 deletions(-)
 create mode 100755 tools/testing/selftests/run_kselftest.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 15c1c1359c50..d9c283503159 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -206,6 +206,7 @@ KSFT_INSTALL_PATH := $(abspath $(KSFT_INSTALL_PATH))
 # Avoid changing the rest of the logic here and lib.mk.
 INSTALL_PATH := $(KSFT_INSTALL_PATH)
 ALL_SCRIPT := $(INSTALL_PATH)/run_kselftest.sh
+TEST_LIST := $(INSTALL_PATH)/kselftest-list.txt
 
 install: all
 ifdef INSTALL_PATH
@@ -214,6 +215,8 @@ ifdef INSTALL_PATH
 	install -m 744 kselftest/module.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/runner.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/
+	install -m 744 run_kselftest.sh $(INSTALL_PATH)/
+	rm -f $(TEST_LIST)
 	@ret=1;	\
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
@@ -222,33 +225,18 @@ ifdef INSTALL_PATH
 		ret=$$((ret * $$?));		\
 	done; exit $$ret;
 
-	@# Ask all targets to emit their test scripts
-	echo "#!/bin/sh" > $(ALL_SCRIPT)
-	echo "BASE_DIR=\$$(realpath \$$(dirname \$$0))" >> $(ALL_SCRIPT)
-	echo "cd \$$BASE_DIR" >> $(ALL_SCRIPT)
-	echo ". ./kselftest/runner.sh" >> $(ALL_SCRIPT)
-	echo "ROOT=\$$PWD" >> $(ALL_SCRIPT)
-	echo "if [ \"\$$1\" = \"--summary\" ]; then" >> $(ALL_SCRIPT)
-	echo "  logfile=\$$BASE_DIR/output.log" >> $(ALL_SCRIPT)
-	echo "  cat /dev/null > \$$logfile" >> $(ALL_SCRIPT)
-	echo "fi" >> $(ALL_SCRIPT)
 
-	@# While building run_kselftest.sh skip also non-existent TARGET dirs:
+	@# Ask all targets to emit their test scripts
+	@# While building kselftest-list.text skip also non-existent TARGET dirs:
 	@# they could be the result of a build failure and should NOT be
 	@# included in the generated runlist.
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		[ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
-		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
-		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
-		echo -n "run_many" >> $(ALL_SCRIPT); \
 		echo -n "Emit Tests for $$TARGET\n"; \
-		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
-		echo "" >> $(ALL_SCRIPT);	    \
-		echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
+		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET COLLECTION=$$TARGET \
+			-C $$TARGET emit_tests >> $(TEST_LIST); \
 	done;
-
-	chmod u+x $(ALL_SCRIPT)
 else
 	$(error Error: set INSTALL_PATH to use install)
 endif
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 51124b962d56..30848ca36555 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -107,9 +107,8 @@ endif
 emit_tests:
 	for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \
 		BASENAME_TEST=`basename $$TEST`;	\
-		echo "	\\";				\
-		echo -n "	\"$$BASENAME_TEST\"";	\
-	done;						\
+		echo "$(COLLECTION):$$BASENAME_TEST";	\
+	done
 
 # define if isn't already. It is undefined in make O= case.
 ifeq ($(RM),)
diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
new file mode 100755
index 000000000000..e07344be28ae
--- /dev/null
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+BASE_DIR=$(realpath $(dirname $0))
+cd $BASE_DIR
+TESTS="$BASE_DIR"/kselftest-list.txt
+if [ ! -r "$TESTS" ] ; then
+	echo "$0: Could not find list of tests to run ($TESTS)" >&2
+	exit 1
+fi
+available="$(cat "$TESTS")"
+
+. ./kselftest/runner.sh
+ROOT=$PWD
+
+if [ "$1" = "--summary" ] ; then
+	logfile="$BASE_DIR"/output.log
+	cat /dev/null > $logfile
+fi
+
+collections=$(echo "$available" | cut -d: -f1 | uniq)
+for collection in $collections ; do
+	[ -w /dev/kmsg ] && echo "kselftest: Running tests in $collection" >> /dev/kmsg
+	tests=$(echo "$available" | grep "^$collection:" | cut -d: -f2)
+	(cd "$collection" && run_many $tests)
+done
-- 
2.25.1

