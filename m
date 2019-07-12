Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F53668DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2019 10:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfGLISV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jul 2019 04:18:21 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:35785 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfGLISU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jul 2019 04:18:20 -0400
Received: by mail-vs1-f73.google.com with SMTP id m186so1887847vsm.2
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2019 01:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Fb/CZ+Kk060SdN/y7lfCe8WEta+n71tTYM2wbCGeWoE=;
        b=FmXkk4uYzlilo3/LYNGIkKuoUfo+MoSUA/YAjdM+rpHf1RRGiaub7o0OuDR0kzTz9I
         Z6yEH5mGc+y+d4gBtC9AOjUSrac9agH1dhdJT0KtBQ5vYeoxwfjfStHDYGReqYHF/kta
         B/nYM10lVBsG7eP4TWz+neTw58dYzt28T16r0G9Wnt/KgabwBagpI0378QLnWKMTAIUo
         8OtS7XB+ZvjiFw7/btfeTorhv1KqzabfxfPjkjHDNyt+kBA27FJCDoO8PhG2R9ZpKku9
         HPlBFTgejj5tX4Jnbxcsq+GtYcYitg6OxfM2tJSK8cgRgbrgtbf0qsaxp7JDdCy5lOHv
         ioYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fb/CZ+Kk060SdN/y7lfCe8WEta+n71tTYM2wbCGeWoE=;
        b=I2WX7R+zbFokXTG9fO8BJ6uLryhBfUldvlprMAOJ6UeylLCwpLPFkremZ/GPJpuh/f
         rroGGk0Huu84uVEsa+jO37XyoAitOJJPfCzcDBaSOmrKrGWuPdZf8+aGF1MAwPDCprSG
         Htk6YxFvuKzVkYw3ME5bCXBrsydqicZc7+XzTP0mvlKHvAZlkwqQ6WXfRHRP12IupcmY
         IMkZEq/QSJ0idrNAM6PiS+CYOEA+PtT3stkF7sfjI02EnSLRT7/zGVQpC21bAiGiqENQ
         7HA/bbqfHtlhbZEmfG4ZChTgpHGvy6RdLWWngCfoSq/qRWPuPkhTsh0Vj7WcvpJ2T4Ef
         DlWA==
X-Gm-Message-State: APjAAAXQr9XQnnxbXXwh6CDxjca7kGfMY1IKfjFyZ8mVv1RUkWWDHVsX
        Vg+EvmLp2YKDr1UxwtWRY23Bw7R/DlwO3Ed++Yo8hw==
X-Google-Smtp-Source: APXvYqzlhlDuJEW0zoFINI6ofADg/Dms8NQSDzjf0rhAwVb///spVWR4p0/jIcB1IMda47T3oCHfBz0NP+wjvLGvfu39Jw==
X-Received: by 2002:ac5:c907:: with SMTP id t7mr5453666vkl.30.1562919499022;
 Fri, 12 Jul 2019 01:18:19 -0700 (PDT)
Date:   Fri, 12 Jul 2019 01:17:36 -0700
In-Reply-To: <20190712081744.87097-1-brendanhiggins@google.com>
Message-Id: <20190712081744.87097-11-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 10/18] kunit: test: add tests for kunit test abort
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add KUnit tests for the KUnit test abort mechanism (see preceding
commit). Add tests both for general try catch mechanism as well as
non-architecture specific mechanism.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 kunit/Makefile    |   3 +-
 kunit/test-test.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 kunit/test-test.c

diff --git a/kunit/Makefile b/kunit/Makefile
index 1f7680cfa11ad..533355867abd2 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_KUNIT) +=			test.o \
 					kunit-stream.o \
 					try-catch.o
 
-obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
+obj-$(CONFIG_KUNIT_TEST) +=		test-test.o \
+					string-stream-test.o
 
 obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	example-test.o
diff --git a/kunit/test-test.c b/kunit/test-test.c
new file mode 100644
index 0000000000000..88f4cdf03db2a
--- /dev/null
+++ b/kunit/test-test.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for core test infrastructure.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+#include <kunit/test.h>
+
+struct kunit_try_catch_test_context {
+	struct kunit_try_catch *try_catch;
+	bool function_called;
+};
+
+void kunit_test_successful_try(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+
+	ctx->function_called = true;
+}
+
+void kunit_test_no_catch(void *data)
+{
+	struct kunit *test = data;
+
+	KUNIT_FAIL(test, "Catch should not be called\n");
+}
+
+static void kunit_test_try_catch_successful_try_no_catch(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_test_successful_try,
+			     kunit_test_no_catch);
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+void kunit_test_unsuccessful_try(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_throw(try_catch);
+	KUNIT_FAIL(test, "This line should never be reached\n");
+}
+
+void kunit_test_catch(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+
+	ctx->function_called = true;
+}
+
+static void kunit_test_try_catch_unsuccessful_try_does_catch(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_test_unsuccessful_try,
+			     kunit_test_catch);
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+static int kunit_try_catch_test_init(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	test->priv = ctx;
+
+	ctx->try_catch = kunit_kmalloc(test,
+				       sizeof(*ctx->try_catch),
+				       GFP_KERNEL);
+
+	return 0;
+}
+
+static struct kunit_case kunit_try_catch_test_cases[] = {
+	KUNIT_CASE(kunit_test_try_catch_successful_try_no_catch),
+	KUNIT_CASE(kunit_test_try_catch_unsuccessful_try_does_catch),
+	{}
+};
+
+static struct kunit_suite kunit_try_catch_test_suite = {
+	.name = "kunit-try-catch-test",
+	.init = kunit_try_catch_test_init,
+	.test_cases = kunit_try_catch_test_cases,
+};
+kunit_test_suite(kunit_try_catch_test_suite);
-- 
2.22.0.410.gd8fdbe21b5-goog

