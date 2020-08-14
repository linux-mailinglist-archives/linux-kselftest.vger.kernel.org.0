Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703DD244F5C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Aug 2020 22:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgHNUze (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Aug 2020 16:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgHNUzd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Aug 2020 16:55:33 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8FAC061385;
        Fri, 14 Aug 2020 13:55:33 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j9so9550298ilc.11;
        Fri, 14 Aug 2020 13:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQzSrU0Gi5Sjm89BBWFHbVgrDbfIT0vez3tDP7LV0Ck=;
        b=HuhXZ2k+L8u5elkfVBaCt+llsu+YGTUbHPGidZYboHTOCt3uppdY1zuqpDpCSKnUam
         ta98tvelqCEoYPxtNn/wc04Nb1NQjvozC6hyC5Ke7nV98w5QzvgITyKJj0y+MjGKznUU
         2Jd3Sfg94lCRqNTV/5dU/NeejrRNVqxng1cMKlpMxssQrLchwI6pdt2ux5mYfrbwjQ0Q
         kotsiaVr/fms04MUQ8l8hjPSEFs/lhybSxLHwS5zr6GtKgJWCnCuX0oAVjhn5HgoJIGP
         FW2PnCEObZ1HCPJdDp5adjykCQhKESggU6Dn01i3zHgMOXiJr7mlEwmOT1X1GmHd9rxJ
         Tcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQzSrU0Gi5Sjm89BBWFHbVgrDbfIT0vez3tDP7LV0Ck=;
        b=kr5fqTuSY70vsamqTvRRWThxNzhEYz9klh79gX/IcUff2t3+h2kOqLLT9vO1QKRLyU
         RpJr9gzZe1t6e1C8kB4y8A8ZGp+rt3Bx9/5KmfxIIwd4GpBQ6AVsd4TNuSo4s5O7Z5xs
         SP3fscTp97euFhVFsRd38C/3lCTOs8knRlW4TqQ2PJa9qZiIZdMBtxsPMoXKfhxEY4PL
         lrR3/lrXrfEuKQP999W4xa2fQIAjkZk7s/Yr+ehAnGMYws9kiMSammp1uCPM0bVEEX0E
         oq5JxWnbCoMvZ9iz5IzIAdhNQ3tF5tYFDTtRXo69NW71G/eo448IgpJ4XwfY67Xz5rWi
         m+XA==
X-Gm-Message-State: AOAM532Jc+xdEzn7V+D5c70HTGyecAkiddrTzCtASryjRC8EsJOgMNlo
        TWLmSStrZPG+AFsSJkbxbbxQfq3ugRJHDA==
X-Google-Smtp-Source: ABdhPJzuWZ4AOrQbAQ71Gdv1J6WksTZC1nrvWMosEWrgHZ7EbiSlEUZfyrXbjCWzOO/ADg0TOTr9wA==
X-Received: by 2002:a92:2803:: with SMTP id l3mr1353224ilf.276.1597438532650;
        Fri, 14 Aug 2020 13:55:32 -0700 (PDT)
Received: from urieldev.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id z9sm4852652ilm.78.2020.08.14.13.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 13:55:32 -0700 (PDT)
From:   Uriel Guajardo <urielguajardojr@gmail.com>
To:     brendanhiggins@google.com, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, urielguajardo@google.com,
        alan.maguire@oracle.com
Subject: [PATCH v3] kunit: added lockdep support
Date:   Fri, 14 Aug 2020 20:55:27 +0000
Message-Id: <20200814205527.1833459-1-urielguajardojr@gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Uriel Guajardo <urielguajardo@google.com>

KUnit will fail tests upon observing a lockdep failure. Because lockdep
turns itself off after its first failure, only fail the first test and
warn users to not expect any future failures from lockdep.

Similar to lib/locking-selftest [1], we check if the status of
debug_locks has changed after the execution of a test case. However, we
do not reset lockdep afterwards.

Like the locking selftests, we also fix possible preemption count
corruption from lock bugs.

Depends on kunit: support failure from dynamic analysis tools [2]

[1] https://elixir.bootlin.com/linux/v5.7.12/source/lib/locking-selftest.c#L1137

[2] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/

Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
---
v3 changes:
- Moved lockdep checking to own file [Alan]
- Fail if preemption count changes during test [Peter]
v2 changes:
- Removed lockdep_reset [Peter]
- Added warning to users about lockdep shutting off
---
 include/kunit/kunit-lockdep.h | 38 +++++++++++++++++++++++++++++++++++
 lib/kunit/Makefile            |  2 ++
 lib/kunit/kunit-lockdep.c     | 37 ++++++++++++++++++++++++++++++++++
 lib/kunit/test.c              |  7 ++++++-
 4 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/kunit-lockdep.h
 create mode 100644 lib/kunit/kunit-lockdep.c

diff --git a/include/kunit/kunit-lockdep.h b/include/kunit/kunit-lockdep.h
new file mode 100644
index 000000000000..9cb8b931a9c6
--- /dev/null
+++ b/include/kunit/kunit-lockdep.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Lockdep integration into KUnit tests
+ *
+ * Copyright (C) 2020, Google LLC.
+ * Author: Uriel Guajardo <urielguajardo@google.com>
+ */
+#ifndef _KUNIT_LOCKDEP_H
+#define _KUNIT_LOCKDEP_H
+
+#include <kunit/test.h>
+
+struct kunit_lockdep {
+	int preempt_count;
+	bool debug_locks;
+};
+
+#if IS_ENABLED(CONFIG_LOCKDEP)
+
+void kunit_init_lockdep(struct kunit *test, struct kunit_lockdep *lockdep);
+
+void kunit_check_lockdep(struct kunit *test, struct kunit_lockdep *lockdep);
+
+#else
+
+static inline void kunit_init_lockdep(struct kunit *test,
+				      struct kunit_lockdep *lockdep)
+{
+}
+
+static inline void kunit_check_lockdep(struct kunit *test,
+				       struct kunit_lockdep *lockdep)
+{
+}
+
+#endif
+
+#endif /* _KUNIT_LOCKDEP_H */
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 724b94311ca3..084806cea994 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -5,6 +5,8 @@ kunit-objs +=				test.o \
 					assert.o \
 					try-catch.o
 
+obj-$(CONFIG_LOCKDEP) +=		kunit-lockdep.o
+
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
 endif
diff --git a/lib/kunit/kunit-lockdep.c b/lib/kunit/kunit-lockdep.c
new file mode 100644
index 000000000000..cc8c1baf25cd
--- /dev/null
+++ b/lib/kunit/kunit-lockdep.c
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Lockdep integration into KUnit tests
+ *
+ * Copyright (C) 2020, Google LLC.
+ * Author: Uriel Guajardo <urielguajardo@google.com>
+ */
+
+#include <kunit/kunit-lockdep.h>
+#include <linux/debug_locks.h>
+#include <linux/sched.h>
+
+void kunit_init_lockdep(struct kunit *test, struct kunit_lockdep *lockdep) {
+	lockdep->debug_locks = debug_locks;
+	lockdep->preempt_count = preempt_count();
+}
+
+void kunit_check_lockdep(struct kunit *test, struct kunit_lockdep *lockdep) {
+	int saved_preempt_count = lockdep->preempt_count;
+	bool saved_debug_locks = lockdep->debug_locks;
+
+	if (DEBUG_LOCKS_WARN_ON(preempt_count() != saved_preempt_count))
+		preempt_count_set(saved_preempt_count);
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	if (softirq_count())
+		current->softirqs_enabled = 0;
+	else
+		current->softirqs_enabled = 1;
+#endif
+
+	if (saved_debug_locks && !debug_locks) {
+		kunit_set_failure(test);
+		kunit_warn(test, "Dynamic analysis tool failure from LOCKDEP.");
+		kunit_warn(test, "Further tests will have LOCKDEP disabled.");
+	}
+}
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index d8189d827368..7f0af0465e6f 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <kunit/kunit-lockdep.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/sched/debug.h>
@@ -290,6 +291,9 @@ static void kunit_try_run_case(void *data)
 	struct kunit_suite *suite = ctx->suite;
 	struct kunit_case *test_case = ctx->test_case;
 
+	struct kunit_lockdep lockdep;
+	kunit_init_lockdep(test, &lockdep);
+
 	current->kunit_test = test;
 
 	/*
@@ -298,7 +302,8 @@ static void kunit_try_run_case(void *data)
 	 * thread will resume control and handle any necessary clean up.
 	 */
 	kunit_run_case_internal(test, suite, test_case);
-	/* This line may never be reached. */
+	/* These lines may never be reached. */
+	kunit_check_lockdep(test, &lockdep);
 	kunit_run_case_cleanup(test, suite);
 }
 
-- 
2.28.0.220.ged08abb693-goog

