Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E5A2202C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jul 2020 05:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgGODLd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jul 2020 23:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgGODLc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jul 2020 23:11:32 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522A0C061755
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jul 2020 20:11:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 6so647535qtt.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jul 2020 20:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f7B6nRu17D4hLq2dpnNEqUTozGMt7UQuNjvdNS+jJbU=;
        b=ovEc7xb3UBenViTIJEoNSptb30ZAYlKnZjOp5qED9m/e22xilVePTic9UoGc55lE+k
         kC75wEyvi6w6pCgu/7TfFf2BIdHVuuDsGmXyvFz9fC9+5JtIQq6aV36WN4hGo1nutneB
         M9rFUvpemCWKnKmOs+654u/Kc2/LoSZ57OddYNwJjsIETuOai/i7G3NkkMeJE/rbRzPU
         Di41NNl8yWr84/KYvGxbzQBO6utP/n7V+ikzI1FL7c53G3cMP+Fm5EdHaegqgxy3pHV7
         YufZu+DIVy9Iw2ZFfMyfHo4iluz1F1H7RTgQ9JcEdL/Hm8aLPhaCSGysnx1gQVJolQ/C
         EtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f7B6nRu17D4hLq2dpnNEqUTozGMt7UQuNjvdNS+jJbU=;
        b=W/roa0ncIp5rXtulNQPcuF2yRCL8KoCrLbS8BqSK/mX+eostHe0l+m4+6J7VbGO4nF
         avJETiybZrrme5RNcopSTFuQ+BmSscEyDSdJW65zSwRynWU5tiOYlXIBdvrpXF/Y1hzI
         ggvyQtTB8PNhM2cz2sYsgVi+4VheKZWhhEq5UT4VdD+yRclDJoJX2J4XMO16IPt0DjNo
         OgWbah8QNDy3ckagCUZwQKwM28XjHNgVoCd6E7fsA/yHksNJvgXkW/UuRmWqrXiN8NrO
         1xHEf11lfaZlSbr/4itT8SrhzHW5WG7LraxHIBjwgc4YcJHQUHptQm8EnHYTnh7HcDTz
         hx8g==
X-Gm-Message-State: AOAM533GZG7iEBIL1bE0hZGTWMJQtVvVtVxIxjEWVppYMw+aq5rMPjK8
        +AjziTxwZgagHvf0ot9l3A6vgA==
X-Google-Smtp-Source: ABdhPJxA8gzAAxGa3RZYJ9BLUMX1vyYZ+/mghOsWxHg2iON1/daKdrj6Rb3bTwDGFcNnKyMHc6PpYw==
X-Received: by 2002:aed:20e5:: with SMTP id 92mr8045746qtb.388.1594782691550;
        Tue, 14 Jul 2020 20:11:31 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id x29sm1269229qtx.74.2020.07.14.20.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 20:11:31 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, keescook@chromium.org,
        davidgow@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RFC 2/3] lib: Allows to borrow mm in userspace on KUnit
Date:   Wed, 15 Jul 2020 00:11:19 -0300
Message-Id: <20200715031120.1002016-3-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715031120.1002016-1-vitor@massaru.org>
References: <20200715031120.1002016-1-vitor@massaru.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 include/kunit/test.h  |  1 +
 lib/kunit/try-catch.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 59f3144f009a..49c38bdcb93e 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -222,6 +222,7 @@ struct kunit {
 	 * protect it with some type of lock.
 	 */
 	struct list_head resources; /* Protected by lock. */
+	struct mm_struct *mm;
 };
 
 void kunit_init_test(struct kunit *test, const char *name, char *log);
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 0dd434e40487..f677c2f2a51a 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -11,7 +11,8 @@
 #include <linux/completion.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
-
+#include <linux/sched/mm.h>
+#include <linux/sched/task.h>
 #include "try-catch-impl.h"
 
 void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
@@ -24,8 +25,17 @@ EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
 static int kunit_generic_run_threadfn_adapter(void *data)
 {
 	struct kunit_try_catch *try_catch = data;
+	struct kunit *test = try_catch->test;
+	
+	if (test->mm != NULL)
+		kthread_use_mm(try_catch->test->mm);
 
 	try_catch->try(try_catch->context);
+	if (try_catch->test->mm) {
+		if (test->mm != NULL)
+			kthread_unuse_mm(try_catch->test->mm);
+		try_catch->test->mm = NULL;
+	}
 
 	complete_and_exit(try_catch->try_completion, 0);
 }
@@ -65,6 +75,9 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 	try_catch->context = context;
 	try_catch->try_completion = &try_completion;
 	try_catch->try_result = 0;
+
+	test->mm = get_task_mm(current);
+
 	task_struct = kthread_run(kunit_generic_run_threadfn_adapter,
 				  try_catch,
 				  "kunit_try_catch_thread");
-- 
2.26.2

