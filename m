Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7611B2160C2
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jul 2020 23:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgGFVDz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jul 2020 17:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGFVDy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jul 2020 17:03:54 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C213C08C5DF;
        Mon,  6 Jul 2020 14:03:54 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t18so14224517ilh.2;
        Mon, 06 Jul 2020 14:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+16+7KnkX/9gcZH8MHFXYJspRfXIBLdOpWbNNV0TOlU=;
        b=uoHhmTNROZj8CmYMxmegK1DaKiSDsdZHNxaiyrGKuknTWf7XfxcYlL2/B1HC5Vnefx
         QbZs+8PCPr6ovkyUJUcj6AVRQxF7qCHorxJUOekBJ93gCdF6RLNFi1vQauAG6klyObQt
         HWpgFrEbygmL0bue+hCOAHc5CR/UkL1EKuYy9fPktSYt98AX5AYSCHaFMz7wvCiUdhFu
         sEnkYZW9onZboUyQx3itTIFECyro/r6Ur5KJtGtAnV0k2CeZW1FEwgS7x9tvLCBdf7R+
         dKwkpj7AXrfD4+8KX195ILZWkuZJktd7pAbOL7vnTkv/Ke90qnrOAIiD0H15/k5A4KFM
         3c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+16+7KnkX/9gcZH8MHFXYJspRfXIBLdOpWbNNV0TOlU=;
        b=eFwmtpgMSM0Thw4RWxfeNbOSo/2G+2LFqUnTbS2jAMwiXd5jwj1snlI99comoT6tsX
         wJaCWeP6unE6C2OIvppr/f7ktzRnvQ5kLIckJ3MYO4X7069u+Z5eXttt0dQYxlDtGH0H
         cKAgX558AHO09y08NyjfHyK7wfNOTzcNxGl+gs4LdobSnv2hPJAaZyMZaOdXNmGHHWWD
         GJmRImZ+49pmb3iBAejE03cdxkRKUV7P9/XwhKRU4slFXrhOQECo0Y3L3u6qIxDVjdyv
         Q6p9cZk5UJR9ZfWaYkpAfmYEh8D5LwzhweN4Nz2xVnApRKCELuRSgrwe/qDsJ+u0EwWs
         XpuQ==
X-Gm-Message-State: AOAM533s+3YGfdnq5FAMY9I5dFBObKWqwSXnIHMJfveQQrLoUXMXQWFg
        5AEjPbOcoX03MkXE7fIRc0U=
X-Google-Smtp-Source: ABdhPJyfWwbEsh9gv+AvxPR/xbUztYmTYm1aQ9jTqeSoVV0XtSLhv5JpxCx3BxKDwUK9nd4PpxUufA==
X-Received: by 2002:a05:6e02:13a9:: with SMTP id h9mr32832029ilo.232.1594069433952;
        Mon, 06 Jul 2020 14:03:53 -0700 (PDT)
Received: from urieldev.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id v10sm11522730ilj.40.2020.07.06.14.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 14:03:53 -0700 (PDT)
From:   Uriel Guajardo <urielguajardojr@gmail.com>
To:     brendanhiggins@google.com, catalin.marinas@arm.com,
        akpm@linux-foundtation.org
Cc:     changbin.du@intel.com, rdunlap@infradead.org, masahiroy@kernel.org,
        0x7f454c46@gmail.com, urielguajardo@google.com, krzk@kernel.org,
        kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org
Subject: [PATCH 1/2] kunit: support kunit failures from debugging tools
Date:   Mon,  6 Jul 2020 21:03:26 +0000
Message-Id: <20200706210327.3313498-2-urielguajardojr@gmail.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200706210327.3313498-1-urielguajardojr@gmail.com>
References: <20200706210327.3313498-1-urielguajardojr@gmail.com>
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

