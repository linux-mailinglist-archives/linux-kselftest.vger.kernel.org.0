Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 251E314E5F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2020 00:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgA3XIo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jan 2020 18:08:44 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:33633 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgA3XIl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jan 2020 18:08:41 -0500
Received: by mail-pl1-f202.google.com with SMTP id bd7so2622967plb.0
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2020 15:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MP470Mm16Hbis3uK4k7c4Y0juRzNAQ4jaojQ4FBlGRU=;
        b=qUKS4/biEzUnqRfVp6CMVb9g2VsQwQM5ss8wWgmxhAEh7N2VSqjHFRlpTPo/f7mWRg
         9PO1MoSacP4zU4ZonpKGxOZYrEyppqNSUoXZa0FQt//aqOuXc89cbAvr0ezWDJ4GamtO
         BiZt1ehsxt7k4vkVItcppjb3GvfT1saAPVkTubBH/5WHPjLpLZrfNxtsAs4tlFqaM8Ct
         0NQxiswyTirVUAHgkpirY4VdeJZ14+VcQUYvCB5Hq+v/C2MpCBLC95YavwPj0wL7qRwo
         8DhYch1X7zqIrC958MLGmLeDXLdHjcpXcFAd8h8WSAOLOUVu7byljiU1Xi2E8Io7bhXC
         eiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MP470Mm16Hbis3uK4k7c4Y0juRzNAQ4jaojQ4FBlGRU=;
        b=RFbg0XyLf0Jy1dwfWZ33f7dlwD25kSYRJFwdyRoowzFtWEW8YHPQbo8rLCgtjsMAH3
         DgbYAmxeqWOZ6JFKHTCOsVWtAKPu+6vA/W/c0W5w3yS48PzEBKgotEBFmeK4+ipu3fuZ
         Yrb7RYTBOQblaxCg6hHIg0sdHBFllSq0qy+Gnn9h3HrEguMSm4yxkQu5t8Tb9hufnPp6
         n6eg4FqTGi/IEsb0KkazC9Nk/KyerJC2UgnT8Z/jf2a2+GI29ibk0lUCTb5V09zSwMM6
         bWfvqGfMXAqdv/qmHViZ34dcEIdM9QOFxXmpw+RlaTOTwe9ZIcpJyu9E8wM4jvf7YAGP
         kTNQ==
X-Gm-Message-State: APjAAAV7nBjCWj+5WyOmuM657nney3d+2ubApVESi3GPamOLai5n2OwM
        vd8SA79XcuXTulIYriBQB5N9O2cGo7vsGTjUjVRu8g==
X-Google-Smtp-Source: APXvYqyakXU44AbYhg6GU2MGJUC6PijcNjm4QFympm/fEDorxw23X7egQMZVQ745p6ST6BfiY6ejMzNK6GIvB25GXWjyng==
X-Received: by 2002:a63:4503:: with SMTP id s3mr7221610pga.311.1580425719434;
 Thu, 30 Jan 2020 15:08:39 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:08:09 -0800
In-Reply-To: <20200130230812.142642-1-brendanhiggins@google.com>
Message-Id: <20200130230812.142642-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200130230812.142642-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 4/7] init: main: add KUnit to kernel init
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

