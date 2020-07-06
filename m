Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A47C2160DF
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jul 2020 23:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgGFVNQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jul 2020 17:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFVNP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jul 2020 17:13:15 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9501BC061755;
        Mon,  6 Jul 2020 14:13:15 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id c16so40915870ioi.9;
        Mon, 06 Jul 2020 14:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+16+7KnkX/9gcZH8MHFXYJspRfXIBLdOpWbNNV0TOlU=;
        b=q4ZqsO86c89YhXHMa8mndzuuWKeikqJBiNdooYKBQ59lbnHySGj2CkCuwC12c5KGPG
         91pUyLBL+Ipzq6ohMANeeQKM/WoXPQDmg012R5LRgzirkNae03AFDibyxL4bI63sDO2y
         fgXAr0HF/9gAXJZYBioRmdXCLL6A1Sbc/C8rSHbuzGjfUIUyy7IKbo1Mp3lWzPmv3OIe
         avTwWB5fSeKGfirW4zyvsZReTnDiBng8yiFE+j6ANVXCgYFMWImmgpticBGIKHphSzw6
         hYbg4pr0YmzChHJ8mF8YBJ7LnSCJ5NgHqC5Gb/MZOSsdGfntT77ExNXSdWNbyBzV6hxZ
         B0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+16+7KnkX/9gcZH8MHFXYJspRfXIBLdOpWbNNV0TOlU=;
        b=bIPxD1KsgayEo/ourvLIzmMDtptfMt2vsgHMJ85I8R3JX30J3mReSaFoonyOaX7ZOh
         Lem+YSOArKq+Mij3gsDJrH9mFC8H8ed0ssJ7c9nMcFcdWLYu+q8817yVZrnBOGq1+IjC
         cJXk/1GgluYGneDAfLqOdes2cLOiWVN30SclkXH+mDoKdZCexrG6FZN0CZ8MczYEL9vC
         EyRjCxlrANZd8Kc3wAi5YrycZwxQYn83lyqpL+wvdsbsca/3Qq40vDQDBbVTFiLWAdRz
         aFciMsZJgCXWpNnVLRVHVsJaVcHhSXwXQnafAP4eOZe2kmyCPi1hTee/zaVyvTEmUISm
         vAUA==
X-Gm-Message-State: AOAM531aoZQ79el8pCqJzH2sATaL8RiRTP6R4g+3uvwSQJvuBfNPqd0r
        9B/rfqAUK6dKPdkPTj5q+Pw=
X-Google-Smtp-Source: ABdhPJz/oP9a0GR+Mz0G+YElZIM2kl7GU+Tjgdq41tPYHxqnhl/0p6pgyQhjjkDDhbSsfn6/Mz2E5g==
X-Received: by 2002:a05:6602:2f92:: with SMTP id u18mr27569915iow.63.1594069995005;
        Mon, 06 Jul 2020 14:13:15 -0700 (PDT)
Received: from urieldev.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id i10sm1063652ild.14.2020.07.06.14.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 14:13:14 -0700 (PDT)
From:   Uriel Guajardo <urielguajardojr@gmail.com>
To:     brendanhiggins@google.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org
Cc:     changbin.du@intel.com, rdunlap@infradead.org, masahiroy@kernel.org,
        0x7f454c46@gmail.com, urielguajardo@google.com, krzk@kernel.org,
        kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org
Subject: [PATCH 1/2] kunit: support kunit failures from debugging tools
Date:   Mon,  6 Jul 2020 21:13:08 +0000
Message-Id: <20200706211309.3314644-2-urielguajardojr@gmail.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200706211309.3314644-1-urielguajardojr@gmail.com>
References: <20200706211309.3314644-1-urielguajardojr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Uriel Guajardo <urielguajardo@google.com>

Dynamic analyis tools can now fail the currently running kunit
test case by calling kunit_fail_current_test().

A new header file is created so that no circular dependencies are
created with external tools.

This patch requires "kunit: KASAN integration", which places the
currently running kunit test in task_struct. [1]

[1] https://lore.kernel.org/linux-kselftest/20200606040349.246780-2-davidgow@google.com

Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
---
 include/kunit/test-bug.h | 15 +++++++++++++++
 include/kunit/test.h     |  1 +
 lib/kunit/test.c         | 10 ++++++----
 3 files changed, 22 insertions(+), 4 deletions(-)
 create mode 100644 include/kunit/test-bug.h

diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
new file mode 100644
index 000000000000..69ec3dd91c52
--- /dev/null
+++ b/include/kunit/test-bug.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Base unit test (KUnit) API.
+ *
+ * Copyright (C) 2020, Google LLC.
+ * Author: Uriel Guajardo <urielguajardo@google.com>
+ */
+
+#if IS_ENABLED(CONFIG_KUNIT)
+extern void kunit_fail_current_test(void);
+#else
+static inline void kunit_fail_current_test(void)
+{
+}
+#endif
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 1dc3d118f64b..c46715c739b5 100644
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
index ef3bfb9fae48..8580ed831a8f 100644
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
@@ -603,9 +607,7 @@ void kunit_cleanup(struct kunit *test)
 		spin_unlock(&test->lock);
 		kunit_remove_resource(test, res);
 	}
-#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
 	current->kunit_test = NULL;
-#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
 }
 EXPORT_SYMBOL_GPL(kunit_cleanup);
 
-- 
2.27.0.212.ge8ba1cc988-goog

