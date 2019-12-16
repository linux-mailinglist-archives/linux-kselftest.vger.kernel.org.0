Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFD08121C67
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 23:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfLPWHQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 17:07:16 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:54165 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfLPWHA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 17:07:00 -0500
Received: by mail-qk1-f202.google.com with SMTP id 12so5571815qkf.20
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2019 14:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g4iCY0XKOYvOdNm2o5ubHQIC+0sd2MLwVwFTH1VbWR4=;
        b=eUKWeLUHl5e6Iza28SAKvx6Zq+BxsVkv4uL89+TqB8OuEzqq6FuXTVIVUu1GQ8dno1
         l7cHlVmOrBkeH7XWMmILFxVKFZV7rsury5fJhw1xxyKJSWfKCdS/wNPDJCKDp5ySJeiG
         ECDGgFAdQS5ynkDgjAJgwvPqM/HDl6zCiTrTpVjemJKsivs7hkdHasHA2wDDv+YGPfZ8
         TiEm7sUU9Ms4asZTQeRuB6s2iOCMB8mrcCjvsiqYxx24tsA3YfbTNIonQf7sL+QQNzEr
         v/1i4c16+71Snz07T8iZzvdlkTb4fE05SoSEQfnbpe9veNktankDVkf33+XPv6tAz2dE
         t/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g4iCY0XKOYvOdNm2o5ubHQIC+0sd2MLwVwFTH1VbWR4=;
        b=Tbf59A6+RPyNCnitt7pFnZcszlvp99w3lIhTThUaplFeN/ZonXSdAZ8d767XKiS8Nx
         jsRdoL5xaDa4dkML84sPHuLsLiqemK6428zucSsEeIYiyWAzn5EhjFwl/TfDnTthLNVG
         utHVg+cS8D0XJT4SdxHQ4f6q/Mvsqpf9qXDxMplIFtLCi1WvN5Jd0ouEpxtbNN0Q4dTs
         q5LeCRqpk7QnsQv5vAoi0odJ8aP3H06iRImEGN1tgNkLIVHAGMtCfaUvfTS/jF8B6CK9
         xRhw/+tQOV3ly+dWjr8qseEYmg1UrJP/qrhMgFu7IdNEENJT+5ktqodiH/x780xl8n5S
         /p8w==
X-Gm-Message-State: APjAAAWyrlf6+KdMWNHoSeM5sNqOTdPqrtAMPlhx8Hgu7nscGUF4EAki
        WnpOB/9un2+5FGFIVKWK8Jv/sV8YFqD/iI63v4LuZw==
X-Google-Smtp-Source: APXvYqy1y35y01Wvspoaet51cZ880b6BVTx+UkgakDke3s1m8DfU2hecucqQU/8/Yb1EnMCG30tZoyXobwMCULi6qGbq/A==
X-Received: by 2002:ac8:534b:: with SMTP id d11mr1654558qto.170.1576534017374;
 Mon, 16 Dec 2019 14:06:57 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:05:52 -0800
In-Reply-To: <20191216220555.245089-1-brendanhiggins@google.com>
Message-Id: <20191216220555.245089-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [RFC v1 3/6] kunit: test: create a single centralized executor for
 all tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a centralized executor to dispatch tests rather than relying on
late_initcall to schedule each test suite separately.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Co-developed-by: Iurii Zaikin <yzaikin@google.com>
Signed-off-by: Iurii Zaikin <yzaikin@google.com>
---
 include/kunit/test.h |  7 ++-----
 lib/kunit/Makefile   |  3 ++-
 lib/kunit/executor.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 6 deletions(-)
 create mode 100644 lib/kunit/executor.c

diff --git a/include/kunit/test.h b/include/kunit/test.h
index dba48304b3bd3..c070798ebb765 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -217,11 +217,8 @@ int kunit_run_tests(struct kunit_suite *suite);
  * everything else is definitely initialized.
  */
 #define kunit_test_suite(suite)						       \
-	static int kunit_suite_init##suite(void)			       \
-	{								       \
-		return kunit_run_tests(&suite);				       \
-	}								       \
-	late_initcall(kunit_suite_init##suite)
+	static struct kunit_suite *__kunit_suite_##suite		       \
+	__used __aligned(8) __section(.kunit_test_suites) = &suite
 
 /*
  * Like kunit_alloc_resource() below, but returns the struct kunit_resource
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 769d9402b5d3a..893df8a685880 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -1,7 +1,8 @@
 obj-$(CONFIG_KUNIT) +=			test.o \
 					string-stream.o \
 					assert.o \
-					try-catch.o
+					try-catch.o \
+					executor.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		test-test.o \
 					string-stream-test.o
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
new file mode 100644
index 0000000000000..978086cfd257d
--- /dev/null
+++ b/lib/kunit/executor.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Base unit test (KUnit) API.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/init.h>
+#include <linux/printk.h>
+#include <kunit/test.h>
+
+/*
+ * These symbols point to the .kunit_test_suites section and are defined in
+ * include/asm-generic/vmlinux.lds.h, and consequently must be extern.
+ */
+extern struct kunit_suite *__kunit_suites_start[];
+extern struct kunit_suite *__kunit_suites_end[];
+
+static bool kunit_run_all_tests(void)
+{
+	struct kunit_suite **suite;
+	bool has_test_failed = false;
+
+	for (suite = __kunit_suites_start;
+	     suite < __kunit_suites_end;
+	     ++suite) {
+		if (kunit_run_tests(*suite))
+			has_test_failed = true;
+	}
+
+	return !has_test_failed;
+}
+
+static int kunit_executor_init(void)
+{
+	if (kunit_run_all_tests())
+		return 0;
+	else
+		return -EFAULT;
+}
+
+late_initcall(kunit_executor_init);
-- 
2.24.1.735.g03f4e72817-goog

