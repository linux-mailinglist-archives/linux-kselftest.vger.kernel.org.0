Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3ECE3B21E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 22:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhFWUmL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 16:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhFWUmI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 16:42:08 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029E3C061756
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 13:39:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x22so1773717pll.11
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 13:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0p8CmnZcgKw/qBa8l8GhA+tejn8NuFe/v2fTm6mOatA=;
        b=Ld3dnJzwkASwHNh4UKy0njC4K70Un+Vi4APlJKV9Ef4wyL5/mXObvHYjnduK0s6Egv
         MU6ECnaLnS4pmrWXHHwgJToYaUO6tvRZ4YGFh/RxWzDuYdMnUJXGd9Nc0ojr+i1wBlzP
         JVnpzNrGp/VRIDPsXF/RozbZtmHDrih6eJM7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0p8CmnZcgKw/qBa8l8GhA+tejn8NuFe/v2fTm6mOatA=;
        b=Nyp2W72JKEJhyqLHBaa1DjqKKEob6DYaisL/DpFVcERy+4L7wyKD0zKWcWxn3giXOE
         VPnRGRD1+2gNAfU65S5L95eY3WmimTlg/teFxeWpqHn6HH2DkPDiSFRlLIsPE3W2R45R
         xOAOWmTwujYxRfp/OJzgDz/xFwOyNpW3L1u3aKwzBiHjDETZg4yHh5S/E4tK1nR/yP7g
         w3kUZVGaxQR6svO7wS90uMV1YaU9+C3/5bXRVzPKws/O8U+YVSHLRgjM/Mg5QRDxA5Fr
         4u+XBeaFJrT/RX+ArPUK4Fvy3VCE/6GoYBNBQxZT0FpaOVp8DjQgdux1R9s/JMlGjGHQ
         2TLw==
X-Gm-Message-State: AOAM5313n7Wv32wxS17RFJZJEeTrgE3M38udgNhjTHiOF5nYyRwkIOHy
        LRMGgJ4TcL3qARFFLxYzjNqCHg==
X-Google-Smtp-Source: ABdhPJxcfSfVu4fr32AHcmeClwNpA5RxHuzicdKsJP3tTotu8VXHv7dVDw+LSPdUfX+/Zjmz54f+IQ==
X-Received: by 2002:a17:902:7085:b029:114:557b:fb02 with SMTP id z5-20020a1709027085b0290114557bfb02mr1439590plk.14.1624480789570;
        Wed, 23 Jun 2021 13:39:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i20sm645692pfo.130.2021.06.23.13.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 5/9] lkdtm/heap: Add vmalloc linear overflow test
Date:   Wed, 23 Jun 2021 13:39:32 -0700
Message-Id: <20210623203936.3151093-6-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623203936.3151093-1-keescook@chromium.org>
References: <20210623203936.3151093-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3649; h=from:subject; bh=Rd9dxqPVzEvJaUgYUyjZ9N+UCrmg2sAZSjOVx9WFfeg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg05wGLxAIiNFpzMFbSLa96E0IxGPiEeMhCRuhHLfE 7MTJscuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYNOcBgAKCRCJcvTf3G3AJpjzEA CQpQ8ui/SBVcA03P4O9zpsIH93GSrqIDygQ2ZdNF2uvopvd2m/960BakuUrGt9s+CgA8PzK/bVpjJj 8/N/aiRbNNJ8WtCiBGZtxlS6ggQvwQADzJQIboI54ao0vx3BDCPKvsqCITxQkQ9Nq+idc3wluV+JYm ryJfFCk9Du1pTdhaDnMW32qZ+c42HHMLnRd1idMuo7mRPUEq8pKXgR2buRdCxsTTTg0JCOzhrg2INj ShjU7AQGcPQVF7LdtTtazqsEZaiqp8vVnC3Pm8Btm9dKH41YepYpk2hZKb5FtSmoYlKPezQw2SE2cA WbtOH65Y7mIt/5jZhr8+OG5P78UkcyYbNHylLLw26KrJGwZTpLlRDJZzDHy/avAFRS4dZ2ijT9c8dz meYXxpYkspBvYmvl2VTdv3fTCVIqsGCJ7vQQp9Z4rVuSvKwyetLypmbq1W8OnK9yV+sEiwmO+jukQK gxeo5HtSBhonxtUq8CASocXmX6Ro9OOsrSkEpsvioNTvVACZ4E99nzZ530SNOgCZ+lhRTxzARiKrVn HaNttRn6OJA5A0iSDjbHM7SdwNJwC7ZBRJ3+B4BFkHO9XrlPc4H/D3KBbbvwFBq0wBwx0RzXMf4QzM FwamnUQkFiKFpjl9mGXnCs9tbCP02PisTRkWBAIU+LWSWCcpYq/s/gJ2F5aQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Similar to the existing slab overflow and stack exhaustion tests, add
VMALLOC_LINEAR_OVERFLOW (and rename the slab test SLAB_LINEAR_OVERFLOW).
Additionally unmarks the test as destructive. (It should be safe in the
face of misbehavior.)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/core.c               |  3 ++-
 drivers/misc/lkdtm/heap.c               | 22 +++++++++++++++++++++-
 drivers/misc/lkdtm/lkdtm.h              |  3 ++-
 tools/testing/selftests/lkdtm/tests.txt |  3 ++-
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 8024b6a5cc7f..645b31e98c77 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -120,7 +120,8 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(UNALIGNED_LOAD_STORE_WRITE),
 	CRASHTYPE(FORTIFY_OBJECT),
 	CRASHTYPE(FORTIFY_SUBOBJECT),
-	CRASHTYPE(OVERWRITE_ALLOCATION),
+	CRASHTYPE(SLAB_LINEAR_OVERFLOW),
+	CRASHTYPE(VMALLOC_LINEAR_OVERFLOW),
 	CRASHTYPE(WRITE_AFTER_FREE),
 	CRASHTYPE(READ_AFTER_FREE),
 	CRASHTYPE(WRITE_BUDDY_AFTER_FREE),
diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 1323bc16f113..36be5e353cd0 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -5,24 +5,44 @@
  */
 #include "lkdtm.h"
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/sched.h>
 
 static struct kmem_cache *double_free_cache;
 static struct kmem_cache *a_cache;
 static struct kmem_cache *b_cache;
 
+/*
+ * If there aren't guard pages, it's likely that a consecutive allocation will
+ * let us overflow into the second allocation without overwriting something real.
+ */
+void lkdtm_VMALLOC_LINEAR_OVERFLOW(void)
+{
+	char *one, *two;
+
+	one = vzalloc(PAGE_SIZE);
+	two = vzalloc(PAGE_SIZE);
+
+	pr_info("Attempting vmalloc linear overflow ...\n");
+	memset(one, 0xAA, PAGE_SIZE + 1);
+
+	vfree(two);
+	vfree(one);
+}
+
 /*
  * This tries to stay within the next largest power-of-2 kmalloc cache
  * to avoid actually overwriting anything important if it's not detected
  * correctly.
  */
-void lkdtm_OVERWRITE_ALLOCATION(void)
+void lkdtm_SLAB_LINEAR_OVERFLOW(void)
 {
 	size_t len = 1020;
 	u32 *data = kmalloc(len, GFP_KERNEL);
 	if (!data)
 		return;
 
+	pr_info("Attempting slab linear overflow ...\n");
 	data[1024 / sizeof(u32)] = 0x12345678;
 	kfree(data);
 }
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 99f90d3e5e9c..c6baf4f1e1db 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -39,7 +39,8 @@ void lkdtm_FORTIFY_SUBOBJECT(void);
 /* heap.c */
 void __init lkdtm_heap_init(void);
 void __exit lkdtm_heap_exit(void);
-void lkdtm_OVERWRITE_ALLOCATION(void);
+void lkdtm_VMALLOC_LINEAR_OVERFLOW(void);
+void lkdtm_SLAB_LINEAR_OVERFLOW(void);
 void lkdtm_WRITE_AFTER_FREE(void);
 void lkdtm_READ_AFTER_FREE(void);
 void lkdtm_WRITE_BUDDY_AFTER_FREE(void);
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index a94d4d8eeb5c..30080cc15623 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -15,7 +15,8 @@ UNSET_SMEP pinned CR4 bits changed:
 DOUBLE_FAULT
 CORRUPT_PAC
 UNALIGNED_LOAD_STORE_WRITE
-#OVERWRITE_ALLOCATION Corrupts memory on failure
+SLAB_LINEAR_OVERFLOW
+VMALLOC_LINEAR_OVERFLOW
 #WRITE_AFTER_FREE Corrupts memory on failure
 READ_AFTER_FREE call trace:|Memory correctly poisoned
 #WRITE_BUDDY_AFTER_FREE Corrupts memory on failure
-- 
2.30.2

