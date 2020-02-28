Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75CA0172E35
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2020 02:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbgB1BVH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Feb 2020 20:21:07 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:50894 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730632AbgB1BVG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Feb 2020 20:21:06 -0500
Received: by mail-pl1-f202.google.com with SMTP id g5so716328plq.17
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2020 17:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8lHd0YZkwZG2tzVOdxbzliRdb15FJbxx1Rjn1yB5+70=;
        b=Bty/Q2oVTN47foIGrI34kAsL9y3zp5FC92Tuh2vIv90lA66BfzLsxq5CRGdQbuTU/V
         n9fsZay5lgeSnvTqrjeQFbuDLt8lGR8C8QILxlmjfijeVL9WgNaefmZfmv/doN7k5/S8
         KDIo01iFyP9kibL/VroPQ24eUBVXE2M+B5HjmVxniWizwDLZv8WhkeLTRcTVx2Dtg/pA
         ASEMv/Lpre04igKn6rhqAcPph95bj91sQcBUU9tgeRwUFrU2REdGiZETCN6W1ZkhBUr4
         XN7JrUYawuanT9NktwcCxIrp78dZRMo5IxQc8AD4YNi8wC1H11QUDW5GjX6zndj+Wze/
         4MGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8lHd0YZkwZG2tzVOdxbzliRdb15FJbxx1Rjn1yB5+70=;
        b=gf0FLWYwpMvPQGL553pwLVq+ybqS7sKGS4jDO5wvOaWjrsWG8H2qPx8xL+9IIFzrmX
         DfGDYYEuZiMPAyjIqb14qoq4n8VbkKWs73doc8ofMd+kL1noTOSH1ZjnJA/S/lgTazww
         DmnVCyAqPaxfnBxdxzXs9yi+lCUlBpgClEcQgiVBlTrWUjEL0aXd0qqu1nS4tZqbrXlJ
         UfzCjY1LRVUCacprr3t4MAfX3GE6OADIWY0Ygm9LAktBYL0dLPeEAe705uwFnuVisBYh
         u8ctj17cvrNoXJNaFmZrxBEaIYBoKzgfz4gnyI9e7xbUXGKVqj3qfKmVhKDj1VXzxNaa
         Cfvw==
X-Gm-Message-State: APjAAAX6zC7m+a6RNxQy9VQDz/knvoLw1aalSBiH0N9VwQVns+tTPRUi
        P0Ar3G7c5SykKelHIUMvYNFRGBuHJOpN2tlwGnHtzQ==
X-Google-Smtp-Source: APXvYqwGEoxXjZAGlPCODTL6b1fAO5IM9ZcV9N9/Stf3e2FL1lhptdTQ9Z2499r3LVL2+l69sq+uvpIK6dT577YqJbUzyg==
X-Received: by 2002:a63:b949:: with SMTP id v9mr2010452pgo.336.1582852865540;
 Thu, 27 Feb 2020 17:21:05 -0800 (PST)
Date:   Thu, 27 Feb 2020 17:20:33 -0800
In-Reply-To: <20200228012036.15682-1-brendanhiggins@google.com>
Message-Id: <20200228012036.15682-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200228012036.15682-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v3 4/7] init: main: add KUnit to kernel init
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove KUnit from init calls entirely, instead call directly from
kernel_init().

Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/kunit/test.h | 9 +++++++++
 init/main.c          | 4 ++++
 lib/kunit/executor.c | 4 +---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 8a02f93a6b505..8689dd1459844 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -197,6 +197,15 @@ void kunit_init_test(struct kunit *test, const char *name);
 
 int kunit_run_tests(struct kunit_suite *suite);
 
+#if IS_BUILTIN(CONFIG_KUNIT)
+int kunit_run_all_tests(void);
+#else
+static inline int kunit_run_all_tests(void)
+{
+	return 0;
+}
+#endif /* IS_BUILTIN(CONFIG_KUNIT) */
+
 /*
  * If a test suite is built-in, module_init() gets translated into
  * an initcall which we don't want as the idea is that for builtins
diff --git a/init/main.c b/init/main.c
index ee4947af823f3..7875a5c486dc4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -104,6 +104,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/initcall.h>
 
+#include <kunit/test.h>
+
 static int kernel_init(void *);
 
 extern void init_IRQ(void);
@@ -1444,6 +1446,8 @@ static noinline void __init kernel_init_freeable(void)
 
 	do_basic_setup();
 
+	kunit_run_all_tests();
+
 	console_on_rootfs();
 
 	/*
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 6429927d598a5..b75a46c560847 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -11,7 +11,7 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
-static int kunit_run_all_tests(void)
+int kunit_run_all_tests(void)
 {
 	struct kunit_suite * const * const *suites, * const *subsuite;
 	bool has_test_failed = false;
@@ -31,6 +31,4 @@ static int kunit_run_all_tests(void)
 	return 0;
 }
 
-late_initcall(kunit_run_all_tests);
-
 #endif /* IS_BUILTIN(CONFIG_KUNIT) */
-- 
2.25.1.481.gfbce0eb801-goog

