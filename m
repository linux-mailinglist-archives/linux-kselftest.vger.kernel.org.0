Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5401D23DF3D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Aug 2020 19:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgHFRny (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Aug 2020 13:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbgHFRne (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Aug 2020 13:43:34 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE95AC061574;
        Thu,  6 Aug 2020 10:43:33 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so38132579ioe.9;
        Thu, 06 Aug 2020 10:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtseolvN6/zqJafrwR5VIYhs3afaZVZdwVkAVHy2pBs=;
        b=aA9V4euYlejLZQThC2d3rF9HpjylCMKqoNz9AwDb4EvLfi3W85WDy1HnkRH2atXD5o
         GIL8JomlJmGRj0GnLlTu6tEgjlGnGI0Z1ly/VrIuADBdG2iIRne5+CLLvxE5HRXGHaXP
         4MSmdhA6pZovFOwhds3M/0iUFnY/zu+I+gxutvsItvOsC+M1cWE5kp1Q0WaaZB0M2z4n
         C/hfv60cnjiHnsbnw07kBYlusOiLp0oBwfuKKJoyzd44rnPEoXTXoxKFeF+jr+OAbavu
         YWUskcItQoEQOeKWU4ax8soMjUmRR4o5+GPAsHXcJDoOMZlHApFuEWvtVmyvqHC7hCPk
         q7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtseolvN6/zqJafrwR5VIYhs3afaZVZdwVkAVHy2pBs=;
        b=OpEnmwZ/RHH2clDTaltSesGPp7za+/ejXVzoqaPcHvMI6z9DfrEi0ZRqklwUeK8fBi
         /nVkBR2+oFdJatrFT06c7+kH/8SEcIYT9F0IR9ivvL5FeRHCLgCkjObIxsPVWcHSYpjL
         DqD2VLIQ0+BHu9V0C2NowOqlzRZ8vNLCFHDpKobVxx6Vv5UqLdpEOwluM5A40KUNUWqr
         mvIyCLSv3TSN//bDFvDKM9Az0U5RcXNu/KcCUC4zb+66iO6dTkWjidJuje4r+ex0XDTy
         bWrg70CZnZPTJKOGmDHSLRZsIFqjapn/nKiK/4c8Ri2g6hy2R8Pea2WIGA9tnXsMx0j9
         b30A==
X-Gm-Message-State: AOAM532xGM4pRzAkGBHm/G95InQiWFyv0XmfcHr2kbL0T9oC1fMk/8CP
        J38h/I4ZCttJZnXdseAnhKs=
X-Google-Smtp-Source: ABdhPJzgjbcTJKDIFR57h75jmG/TQwAYddjmkuxNs5NJXyh6TtguA5NN32BeZdwACBpyXDHhGaJC9A==
X-Received: by 2002:a6b:e31a:: with SMTP id u26mr53739ioc.162.1596735812434;
        Thu, 06 Aug 2020 10:43:32 -0700 (PDT)
Received: from urieldev.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id s74sm4750141ilb.44.2020.08.06.10.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 10:43:31 -0700 (PDT)
From:   Uriel Guajardo <urielguajardojr@gmail.com>
To:     brendanhiggins@google.com
Cc:     urielguajardo@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Uriel Guajardo <urielguajardojr@gmail.com>
Subject: [PATCH 1/2] kunit: support failure from dynamic analysis tools
Date:   Thu,  6 Aug 2020 17:43:25 +0000
Message-Id: <20200806174326.3577537-1-urielguajardojr@gmail.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adds an API to allow dynamic analysis tools to fail the currently
running KUnit test case.

- Always places the kunit test in the task_struct to allow other tools
to access the currently running KUnit test.

- Creates a new header file to avoid circular dependencies that could be
created from the test.h file.

Requires KASAN-KUnit integration patch to access the kunit test from
task_struct:
https://lore.kernel.org/linux-kselftest/20200606040349.246780-2-davidgow@google.com/

Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
---
 include/kunit/test-bug.h | 24 ++++++++++++++++++++++++
 include/kunit/test.h     |  1 +
 lib/kunit/test.c         | 10 ++++++----
 3 files changed, 31 insertions(+), 4 deletions(-)
 create mode 100644 include/kunit/test-bug.h

diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
new file mode 100644
index 000000000000..283c19ec328f
--- /dev/null
+++ b/include/kunit/test-bug.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit API allowing dynamic analysis tools to interact with KUnit tests
+ *
+ * Copyright (C) 2020, Google LLC.
+ * Author: Uriel Guajardo <urielguajardo@google.com>
+ */
+
+#ifndef _KUNIT_TEST_BUG_H
+#define _KUNIT_TEST_BUG_H
+
+#if IS_ENABLED(CONFIG_KUNIT)
+
+extern void kunit_fail_current_test(void);
+
+#else
+
+static inline void kunit_fail_current_test(void)
+{
+}
+
+#endif
+
+#endif /* _KUNIT_TEST_BUG_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 3391f38389f8..81bf43a1abda 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -11,6 +11,7 @@
 
 #include <kunit/assert.h>
 #include <kunit/try-catch.h>
+#include <kunit/test-bug.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index dcc35fd30d95..d8189d827368 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -16,6 +16,12 @@
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
+void kunit_fail_current_test(void)
+{
+	if (current->kunit_test)
+		kunit_set_failure(current->kunit_test);
+}
+
 static void kunit_print_tap_version(void)
 {
 	static bool kunit_has_printed_tap_version;
@@ -284,9 +290,7 @@ static void kunit_try_run_case(void *data)
 	struct kunit_suite *suite = ctx->suite;
 	struct kunit_case *test_case = ctx->test_case;
 
-#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
 	current->kunit_test = test;
-#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
 
 	/*
 	 * kunit_run_case_internal may encounter a fatal error; if it does,
@@ -602,9 +606,7 @@ void kunit_cleanup(struct kunit *test)
 		spin_unlock(&test->lock);
 		kunit_remove_resource(test, res);
 	}
-#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
 	current->kunit_test = NULL;
-#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
 }
 EXPORT_SYMBOL_GPL(kunit_cleanup);
 
-- 
2.28.0.163.g6104cc2f0b6-goog

