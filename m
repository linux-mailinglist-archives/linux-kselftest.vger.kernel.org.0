Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5428A24402C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Aug 2020 22:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgHMU5e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Aug 2020 16:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMU5d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Aug 2020 16:57:33 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963C4C061757;
        Thu, 13 Aug 2020 13:57:33 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u126so8671787iod.12;
        Thu, 13 Aug 2020 13:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtseolvN6/zqJafrwR5VIYhs3afaZVZdwVkAVHy2pBs=;
        b=LCKTmMxBJmbGgDljt2Hm8ezcnEQBtvCF1dzDUEKqKYMMtV9bowlJ93fzTTYLQhDu8d
         FX2epQT5ZTQz/L74FakXaKZ79j1Sw2xXpreHa2pgxHJt/MH1j79IdfoacV53KRwC+E8J
         Qe4l129kiJHyCYrfYbjctDikfQ2U8mTEYctPZWOYJWTCnPGFoV9+EWt0eobnNCVRVVSm
         YypPt2tWNkFJdIF15wWrhWnH31F3faIO5wOTmmxJz1u/XPtkg/jFiRcY43T4VrCOgMbN
         xEYwC9Nrbb6F6nGf7WJGwXJwNSGfZOisUnCeHdr4dyvMzfDwGdPJcdp87NmbNLW9edex
         LQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtseolvN6/zqJafrwR5VIYhs3afaZVZdwVkAVHy2pBs=;
        b=kodQbd08xpklnPv4HbqtYUAeRVCM7n2bFlj7F7DfDQVuBRDONhiZs07x0xc74SHIfx
         zCTp9TJOUMZEdnbx0gbmZYQPYkt3W7AH6IpGrCPAp034aUsEnblM8y2csrBXDC/FYsmx
         fTgxK/AZeYCbxyVCzlgRUM93we4VAe9up0V940UXuIu5UKCUFLMrt7VJFy18f0BHA3HN
         5UwzYBxP/Q0bc+HSjRlJl/jpyVC6VUDr22rPOjRScBePrrqk2CS+N9f8BTf5HsWM9sa5
         7ASc3QaDxY3OSXU3cxDzEK9TD1dQIQUJbYMkA5KpgO2JpU5Cgjl5WlzlPNDmWb4Ecwdh
         dZKw==
X-Gm-Message-State: AOAM530+paNtLgiDxi1XvGT3LAOEPiVFCWFJk0odrG4qVye7aUvi9ERo
        qL5I90tp/4sX0t7zVuF6Ve8=
X-Google-Smtp-Source: ABdhPJzyw2jYcTYfxJ8VBN8TfWy68Up6wecEYDl2rrRr5Nw2UakFVSs3PQJtLEnH/03Kp6q1waw1YQ==
X-Received: by 2002:a05:6638:305:: with SMTP id w5mr7267114jap.10.1597352252848;
        Thu, 13 Aug 2020 13:57:32 -0700 (PDT)
Received: from urieldev.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id s3sm3148603iol.49.2020.08.13.13.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 13:57:31 -0700 (PDT)
From:   Uriel Guajardo <urielguajardojr@gmail.com>
To:     brendanhiggins@google.com
Cc:     urielguajardo@google.com, akpm@linux-foundation.org,
        keescook@chromium.org, rdunlap@infradead.org,
        herbert@gondor.apana.org.au, christian.brauner@ubuntu.com,
        peterz@infradead.org, ardb@kernel.og, arnd@arndb.de,
        julien.grall@arm.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Uriel Guajardo <urielguajardojr@gmail.com>
Subject: [PATCH 1/2] kunit: support failure from dynamic analysis tools
Date:   Thu, 13 Aug 2020 20:57:21 +0000
Message-Id: <20200813205722.1384108-1-urielguajardojr@gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
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

