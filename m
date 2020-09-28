Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8784C27B63A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Sep 2020 22:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgI1U0z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 16:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgI1U0y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 16:26:54 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEDAC0613CF
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 13:26:54 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id d13so1893698pgl.6
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZOrfE0wnl6Q5jHyL+t54vVabQfAKKdOXl04nt52zYdk=;
        b=f1z2MXwb2iQEYv4KPFFnxv+HHKJhJrXpDOH+8K8NSuUJ3aFSmK19MG64n1ptPT1LiH
         I8zrgXqXf/KsjWY4BV8/xLc2b8iTSVV06C7TLglCRfuDU9Eo6xeLMVrQNdd99RqMx9rA
         y9bMe/0vUpC2pVInrvkR7nTpQDY4Zbffwbcc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZOrfE0wnl6Q5jHyL+t54vVabQfAKKdOXl04nt52zYdk=;
        b=s4Dn5RmhdiB8cfXg4sioao9B/TrhvIJizhrzHktiLtizLlTKV2Roc4mAnS+bfAAC+7
         S5l1aQp7U6/F2FSlaDb/XpGkxu0T6Agnl2+xp3WOdXVGONJAIXZ0j+MP6SVYiLg+0doJ
         FLPzhqmGbk5yereWyz/ksJ1//edP7mMAwdAR7790IJA2OFPrR13yBPuOLRY6uTuz8qkb
         7zPSot9TFvhSCuoEMQjZGRR9sxZtDESw5B7QxvZWJo7N7k1KLXIw9p0JrcrO04tq7yOL
         qLhgTCri1mR8ECG1SOyu6fXO9S5T+r6GnPjAVXrPoI+kU/qpJ31WuTVtvo3XyXRI0eP6
         fKpw==
X-Gm-Message-State: AOAM533bHa4FV9VDTRoQzYnQUHNsSAHKMktpRzV6/ntXp17/dMN2oaKR
        334l4SSTNjZFdwZUoQydd7+kGA==
X-Google-Smtp-Source: ABdhPJxQuzqMyk4kjJoEQF/hXYqx8+JzbpEgS7yS3So3A3BdkwoayVUzOf2a8+ctWxPK/muoOVAP9g==
X-Received: by 2002:aa7:9f10:0:b029:142:2501:34d4 with SMTP id g16-20020aa79f100000b0290142250134d4mr968913pfr.45.1601324813912;
        Mon, 28 Sep 2020 13:26:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s22sm2742242pfd.90.2020.09.28.13.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 13:26:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Tim.Bird@sony.com, lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/3] selftests: Extract run_kselftest.sh and generate stand-alone test list
Date:   Mon, 28 Sep 2020 13:26:48 -0700
Message-Id: <20200928202650.2530280-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928202650.2530280-1-keescook@chromium.org>
References: <20200928202650.2530280-1-keescook@chromium.org>
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

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/Makefile         | 26 ++++++----------------
 tools/testing/selftests/lib.mk           |  5 ++---
 tools/testing/selftests/run_kselftest.sh | 28 ++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 22 deletions(-)
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
index 000000000000..8b0ad4766d78
--- /dev/null
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Run installed kselftest tests.
+#
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

