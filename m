Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6717F2983C4
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Oct 2020 22:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418983AbgJYVs4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Oct 2020 17:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1418981AbgJYVsv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Oct 2020 17:48:51 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B28DC061755
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Oct 2020 14:48:51 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id v19so7384993edx.9
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Oct 2020 14:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cCvtSrWUoPfjEX3MMgBAPpFowxLdp4ZIN2gqdndxr2k=;
        b=YVUcgWiMnFEVymldu6NwvFVQ/iODVY2Me/b603T8P+yLTFzayAhQ4TcXi6GVUOGlXT
         C5e5z4KjVtabsaTt+bW1YrqRjERzD41hasjbeCPU8ka+c9X9qSZk2k0GCEgK2/G1I24/
         YpFolPYq4MNEte2aEV8C/AnTtCKsZX3uGXoBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cCvtSrWUoPfjEX3MMgBAPpFowxLdp4ZIN2gqdndxr2k=;
        b=rXLHk2E55UrSbdCdLA6FH+hoxEA4qGX8DxdsOv5LdixT5QlGbMOIogWLgGr8un1FRT
         gRJYgmQVaeJWPeTNtrISPmrkDg/gryaSPrF5K+bEDw28hdS+GfKGAZF8SzVzmq4oJgks
         sLiO2Vh9ZFiohPypfxKLF1PoyaE85Y9iForyREfL+A1lNGY8q5N0QpO8VLIJI4Dcf3kI
         3FXO+dlqi97Kb65mxWGrArgg7GL3rblo2gr5fBCYrfBMJ5wKv+JRAE5IBDPucJJHOgbG
         K8H9eP2VPl7a/Rr7IeTUHzgQ7C0Am60Tzv+jnNZqNHRUbAIOtLjcqENf+tUNTPGhu/WT
         ztvQ==
X-Gm-Message-State: AOAM5335mqrCnXh5B3EyTAYx9xmhVCiCrA9Zr5u+mmkRIVOZ+VbaUUBh
        R/KBB+D/QjCTKUVYpruQRjHosg==
X-Google-Smtp-Source: ABdhPJyRXxvVb1mq0cFESQTCfX7TrThR73A0MfZ4vV7HWiF8yz2HPztG24hB4iqv4YSAK8TqoiKldw==
X-Received: by 2002:aa7:cd42:: with SMTP id v2mr10886769edw.191.1603662530159;
        Sun, 25 Oct 2020 14:48:50 -0700 (PDT)
Received: from prevas-ravi.prevas.se (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id k18sm4115867eds.93.2020.10.25.14.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 14:48:49 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>, Willy Tarreau <w@1wt.eu>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 3/4] kselftest_module.h: add struct rnd_state and seed parameter
Date:   Sun, 25 Oct 2020 22:48:41 +0100
Message-Id: <20201025214842.5924-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201025214842.5924-1-linux@rasmusvillemoes.dk>
References: <20201025214842.5924-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some test suites make use of random numbers to increase the test
coverage when the test suite gets run on different machines and
increase the chance of some corner case bug being discovered - and I'm
planning on extending some existing ones in that direction as
well. However, should a bug be found this way, it's important that the
exact same series of tests can be repeated to verify the bug is
fixed. That means the random numbers must be obtained
deterministically from a generator private to the test module.

To avoid adding boilerplate to various test modules, put some logic
into kselftest_module.h: If the module declares that it will use
random numbers, add a "seed" module parameter. If not explicitly given
when the module is loaded (or via kernel command line), obtain a
random one. In either case, print the seed used, and repeat that
information if there was at least one test failing.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 tools/testing/selftests/kselftest_module.h | 35 ++++++++++++++++++++--
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kselftest_module.h b/tools/testing/selftests/kselftest_module.h
index c81c0b0c054befaf665b..43f3ca58fcd550b8ac83 100644
--- a/tools/testing/selftests/kselftest_module.h
+++ b/tools/testing/selftests/kselftest_module.h
@@ -3,14 +3,31 @@
 #define __KSELFTEST_MODULE_H
 
 #include <linux/module.h>
+#include <linux/prandom.h>
+#include <linux/random.h>
 
 /*
  * Test framework for writing test modules to be loaded by kselftest.
  * See Documentation/dev-tools/kselftest.rst for an example test module.
  */
 
+/*
+ * If the test module makes use of random numbers, define KSTM_RANDOM
+ * to 1 before including this header. Then a module parameter "seed"
+ * will be defined. If not given, a random one will be obtained. In
+ * either case, the used seed is reported, so the exact same series of
+ * tests can be repeated by loading the module with that seed
+ * given.
+ */
+
+#ifndef KSTM_RANDOM
+#define KSTM_RANDOM 0
+#endif
+
 static unsigned int total_tests __initdata;
 static unsigned int failed_tests __initdata;
+static struct rnd_state rnd_state __initdata;
+static u64 seed __initdata;
 
 #define KSTM_CHECK_ZERO(x) do {						\
 	total_tests++;							\
@@ -22,11 +39,13 @@ static unsigned int failed_tests __initdata;
 
 static inline int kstm_report(unsigned int total_tests, unsigned int failed_tests)
 {
-	if (failed_tests == 0)
+	if (failed_tests == 0) {
 		pr_info("all %u tests passed\n", total_tests);
-	else
+	} else {
 		pr_warn("failed %u out of %u tests\n", failed_tests, total_tests);
-
+		if (KSTM_RANDOM)
+			pr_info("random seed used was 0x%016llx\n", seed);
+	}
 	return failed_tests ? -EINVAL : 0;
 }
 
@@ -34,6 +53,12 @@ static inline int kstm_report(unsigned int total_tests, unsigned int failed_test
 static int __init __module##_init(void)			\
 {							\
 	pr_info("loaded.\n");				\
+	if (KSTM_RANDOM) {				\
+		if (!seed)				\
+			seed = get_random_u64();	\
+		prandom_seed_state(&rnd_state, seed);	\
+		pr_info("random seed = 0x%016llx\n", seed);	\
+	}						\
 	selftest();					\
 	return kstm_report(total_tests, failed_tests);	\
 }							\
@@ -44,4 +69,8 @@ static void __exit __module##_exit(void)		\
 module_init(__module##_init);				\
 module_exit(__module##_exit)
 
+#if KSTM_RANDOM
+module_param(seed, ullong, 0444);
+#endif
+
 #endif	/* __KSELFTEST_MODULE_H */
-- 
2.23.0

