Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3131C6A269F
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 02:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBYBpx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 20:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBYBpw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 20:45:52 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B6763DED
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Feb 2023 17:45:50 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-53865bdc1b1so19270547b3.16
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Feb 2023 17:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sfeWRo0fTOF5FILLunZvL4iOLuWT2s/FUKmq+WiUJJo=;
        b=f7jJdMTH/6WrBvdqAZ59+T/e3Yloov2i13fv/nLWqtIUzaFIJgeFXnUazRWkC2S+vV
         cGe25yFMUT1AqleoBCScrJOSXi3p7Z/aaZiQDk/C2fLDeJsNF6WPxujQCAjvGYJjwzJ6
         qMQ28W3S6mJJyjqJhBHQZ68mthu68I5gOhUw0REFv6Whfz1BMTBYruqdka5SKoeI+jzy
         YyN2Xq84inp93xbHWhqjsE9vKUT5TWBIL4sWCkVh1636bjz9sOnLCbhVlXvt6cdtzJPx
         ZRRA0Wh2qbsiJjsx8cO3AbzP6XLEUKmYE6z4+9wEwJyn+Gklt5JiK7Jw9s+hJNOQL8SI
         BdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sfeWRo0fTOF5FILLunZvL4iOLuWT2s/FUKmq+WiUJJo=;
        b=lc5YU7CDS7GhypzpfnKo3+uhuRwTPKAaiNEuwl674KG5frqc0YcERiprJJ7BMAPClQ
         d26uQiTb+xTEb6PJsweURufUe+I3LwXj/GRZjL6pGj/uQ5DNDTPL8rVT6zQhGY4HYxMk
         QtvPfBxgfaoAUmeF6WxLqpV8zmmWr4zpmyVna0wmPkB8WgNw2nL51SsmO9CfkDR5tbUK
         +H+wQbpd1D01SIyEk9o3uZFJoNm4rEuhGaeDG3CSsts3teKjBEclVhdxy0Elr2XP3KMo
         9fZ7bKHe2XazXa0s1xKIRP0Qniqtc/EbJ5fW4Zn4PtBtBVRFouPfEGAtdxvvcp5KBLPy
         F/pg==
X-Gm-Message-State: AO0yUKU6J9cRqicMxjfw/cxzRvU+iqS5BLWN+YqSqhyZ/Qc6ZD8/XRCc
        FD2DaRVNVAc/SIqSu+hUqVHNQXvluYblDg==
X-Google-Smtp-Source: AK7set9mVPJXSm2LqIDNOlJOARvbkMoO0jRzztqXdbE7wUBIOKD86QoTogleYpnETVHn4uRFoE3hDyMraIq+eg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a5b:b07:0:b0:9fe:1493:8b8 with SMTP id
 z7-20020a5b0b07000000b009fe149308b8mr4985732ybp.6.1677289549973; Fri, 24 Feb
 2023 17:45:49 -0800 (PST)
Date:   Sat, 25 Feb 2023 09:45:30 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230225014529.2259752-1-davidgow@google.com>
Subject: [PATCH] kunit: Fix 'hooks.o' build by recursing into kunit
From:   David Gow <davidgow@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit's 'hooks.o' file need to be built-in whenever KUnit is enabled
(even if CONFIG_KUNIT=m). We'd previously attemtped to do this by adding
'kunit/hooks.o' to obj-y in lib/Makefile, but this caused hooks.c to be
rebuilt even when it was unchanged.

Instead, always recurse into lib/kunit using obj-y when KUnit is
enabled, and add the hooks there.

Fixes: 7170b7ed6acb ("kunit: Add "hooks" to call into KUnit when it's built as a module").
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/linux-kselftest/CAHk-=wiEf7irTKwPJ0jTMOF3CS-13UXmF6Fns3wuWpOZ_wGyZQ@mail.gmail.com/
Signed-off-by: David Gow <davidgow@google.com>
---

I like this way of handling the makefiles much better. I had tried it
when originally writing the hooks patch and not managed to get it
working. Not sure what's changed now, but it works in all of the usual
cases (CONFIG_KUNIT={n,y,m}, kunit.py run, etc).

Linus, Shuah: Let me know if you want this to go via the KUnit branch,
or if you just want to apply it directly and get rid of the annoyances
ASAP.

---
 lib/Makefile       | 12 ++++--------
 lib/kunit/Makefile |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 469be6240523..baf2821f7a00 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -127,14 +127,10 @@ CFLAGS_test_fpu.o += $(FPU_CFLAGS)
 
 obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
 
-obj-$(CONFIG_KUNIT) += kunit/
-# Include the KUnit hooks unconditionally. They'll compile to nothing if
-# CONFIG_KUNIT=n, otherwise will be a small table of static data (static key,
-# function pointers) which need to be built-in even when KUnit is a module.
-ifeq ($(CONFIG_KUNIT), m)
-obj-y += kunit/hooks.o
-else
-obj-$(CONFIG_KUNIT) += kunit/hooks.o
+# Some KUnit files (hooks.o) need to be built-in even when KUnit is a module,
+# so we can't just use obj-$(CONFIG_KUNIT).
+ifdef CONFIG_KUNIT
+obj-y += kunit/
 endif
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index da665cd4ea12..cb417f504996 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -13,7 +13,7 @@ kunit-objs +=				debugfs.o
 endif
 
 # KUnit 'hooks' are built-in even when KUnit is built as a module.
-lib-y +=				hooks.o
+obj-y +=				hooks.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
 
-- 
2.39.2.637.g21b0678d19-goog

