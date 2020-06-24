Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B37A207DE3
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jun 2020 22:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391524AbgFXU6t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 16:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391515AbgFXU6Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 16:58:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAA7C061795
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jun 2020 13:58:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z7so3620079ybz.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jun 2020 13:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ELTbA/D53vsks4KNfy6c7mQozTKHq2tz0SeyuFYbWuc=;
        b=ilF4ZofCice348g6KB6xSbAmaiBIaMLdgB2x4VfxAnKms5hnHM29LdJdEkLcg+w0cr
         V5nXQOsr8G0nghC3r/MDSXyZf2OzLdnCCn5QbiFutcQHKyjyPX1QI+3DQV6rok1+Zf1y
         OfxCl8q3ALVu6cNLL6CMNLHBhNoEMxddHhG8uX0WzkS1CC8OiAUUqcqbaAa9ejhPFfHJ
         3h7wuoWBngJbF/FlIuDf3o+kWe1WRPJGISa3/TUMG4656RgRwSpqWGZAQgKD7QHjvk2R
         HoTmt5ufrAxtzgtWTEmq55TxrcLMgZLWPpzHntLs1g+B8g2yFfRiefWbJk1ye6mXF/qW
         4fLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ELTbA/D53vsks4KNfy6c7mQozTKHq2tz0SeyuFYbWuc=;
        b=bAqrY9XOHTQByV5Qs+Z4o9LYvIWAxmbkZMNSXEbOoieY2A9Amj0ApFIDdq7U2s56Qj
         d6pNZEYezLNdx3wRYpBec31KzPuIXaZLuWiYKHO/6WxEb2A2+0fpEADqG6gfJxLiqV8F
         s9PeKLdJfimgwUF1MM1VS0W6BeakC8As0ZuNFaRmswHme3UrBfrqcv+3kWB/hT+oZWwl
         jCcLJSF1MDIOxZMBBOZVpAJ0W3mZ2zP/MWikAtreBZNckty4VrijVtsHk0G+HFeVkcd7
         +r7WsCl5cwOskdBm48yTmHZqZG5Y8Mh+Z7dFNnLba5h52f8jxFHBpbWG/09EhTe78UVX
         Ax7w==
X-Gm-Message-State: AOAM531LZyYyuf6iQuuuyz8Ps3Fx09/kH9x/7z8dYzO88vNKuHvYtp92
        einvZxr2CR1H5n46X59t8C7PfBoQHEtMy3zAo4+JMg==
X-Google-Smtp-Source: ABdhPJwMX93RLZR1j2HmJ2CmsK4Dqy1QxjPoSR3y8pYRYoe3oDKKU/eTUSWi6Lj9+STu8VVJTKJ8m5oEBr3oAlbQViQoFw==
X-Received: by 2002:a25:ab12:: with SMTP id u18mr44695321ybi.142.1593032303409;
 Wed, 24 Jun 2020 13:58:23 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:55:47 -0700
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
Message-Id: <20200624205550.215599-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 08/11] init: main: add KUnit to kernel init
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
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
index d13965eb624d4..7cb1c47388c56 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -228,6 +228,15 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites);
 
 void __kunit_test_suites_exit(struct kunit_suite **suites);
 
+#if IS_BUILTIN(CONFIG_KUNIT)
+int kunit_run_all_tests(void);
+#else
+static inline int kunit_run_all_tests(void)
+{
+	return 0;
+}
+#endif /* IS_BUILTIN(CONFIG_KUNIT) */
+
 /**
  * kunit_test_suites() - used to register one or more &struct kunit_suite
  *			 with KUnit.
diff --git a/init/main.c b/init/main.c
index 0ead83e86b5aa..d3101d8874dea 100644
--- a/init/main.c
+++ b/init/main.c
@@ -106,6 +106,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/initcall.h>
 
+#include <kunit/test.h>
+
 static int kernel_init(void *);
 
 extern void init_IRQ(void);
@@ -1504,6 +1506,8 @@ static noinline void __init kernel_init_freeable(void)
 
 	do_basic_setup();
 
+	kunit_run_all_tests();
+
 	console_on_rootfs();
 
 	/*
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 7015e7328dce7..4aab7f70a88c3 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -11,7 +11,7 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
-static int kunit_run_all_tests(void)
+int kunit_run_all_tests(void)
 {
 	struct kunit_suite * const * const *suites;
 
@@ -23,6 +23,4 @@ static int kunit_run_all_tests(void)
 	return 0;
 }
 
-late_initcall(kunit_run_all_tests);
-
 #endif /* IS_BUILTIN(CONFIG_KUNIT) */
-- 
2.27.0.212.ge8ba1cc988-goog

