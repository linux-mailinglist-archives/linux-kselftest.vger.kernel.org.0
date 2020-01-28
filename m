Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1323314B052
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2020 08:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgA1HU2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jan 2020 02:20:28 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:53315 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgA1HU0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jan 2020 02:20:26 -0500
Received: by mail-qt1-f201.google.com with SMTP id m8so7920937qta.20
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2020 23:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4MjEglgwzQeYmQHEj7lVD/Q2s1JVUJ8kKFlc6FnNZt0=;
        b=hIhlGtjLGzw1SUt6Jw8C/K2HF2ecgfBO3NMmc4gRUVfjoFHBM4NiKRBnLRD2nyc6Tj
         mdWKOvijFU7VJ362/OXCxdB7zrDTl3GprOBtzyB/drE/LeQWfnCPkcr1TQ8NilYTEUU9
         WFHk5H+QRn9Ln+War8nzP8jDodqFXT5aeCGz84nZ9AVByzxHK0kZdSen7KPpq/C60+s2
         6JEDMiocGrIQwTYouQO/R2DEAtJYad5Q+mApL0OLG5Jww4JozmqfWCb4/LYTR7lM3kMC
         7mQF5PmYLc017GRTgEOhNfK/HEuD8MoNOKvabILsxoZYKcPv3QHAUrwzFAuPjVP2tfTN
         RNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4MjEglgwzQeYmQHEj7lVD/Q2s1JVUJ8kKFlc6FnNZt0=;
        b=VMohy1tnMBOhGo/r7yHMAZZelTY5Jnh6tlUktRJqkp4bM/9s5mvlyXlb9FpOSew07D
         jW10EagVTSo/96H98IaW0MPE/8vGp2UW+4IGCEm6s0gOfIKNeeUzYTF4AFuWEwkYjeos
         fjDnCll+lS/SG6bHTZCFrzdRA6i+WbkL1oxbbCdk0NUtaw3c+gvtgOM4Aj8xXWoT3V/9
         FyRJpGffTj8gQNzpp7eSNwiTLR//36hKSGlHWEsI4FE3VE1KfNgSku0xzo1M4AMYZZdX
         4HzAwyuUCEA57FocM8Mct0a1LCRo07YKmxDNXa06jQ5hiWYxJwCsZhfVbxTogI/Idypa
         U5Jg==
X-Gm-Message-State: APjAAAXRqpWdf5aPo8UQvoGQnlKFG0uB1fnAKGaHoTuHg3MzQTanXoRd
        veoqgPZ3aL9JhsPZoSZdWnuHIbVKzDsjM+NhA7omUg==
X-Google-Smtp-Source: APXvYqxGcm6m1ET1DVlbjNLLOCIax2s4cEucHeJOXLwB5vmRbR5b7p9xrmal0f4br+4TUTmY99J/qnO69CzvwxBlR0vrNg==
X-Received: by 2002:a0c:8e08:: with SMTP id v8mr21132536qvb.4.1580196025518;
 Mon, 27 Jan 2020 23:20:25 -0800 (PST)
Date:   Mon, 27 Jan 2020 23:19:59 -0800
In-Reply-To: <20200128072002.79250-1-brendanhiggins@google.com>
Message-Id: <20200128072002.79250-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200128072002.79250-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1 4/7] init: main: add KUnit to kernel init
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
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
index 2cd736059416f..90301d4fbd1bb 100644
--- a/init/main.c
+++ b/init/main.c
@@ -103,6 +103,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/initcall.h>
 
+#include <kunit/test.h>
+
 static int kernel_init(void *);
 
 extern void init_IRQ(void);
@@ -1201,6 +1203,8 @@ static noinline void __init kernel_init_freeable(void)
 
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
2.25.0.341.g760bfbb309-goog

