Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3CE59D116
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 08:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbiHWGND (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 02:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbiHWGNA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 02:13:00 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE795FF43
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 23:12:59 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 377C0310211;
        Tue, 23 Aug 2022 08:12:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1661235176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ckKpaCD769E2hBMsbXLCevh4mvbrBBZSXnA/2Bq2Ts=;
        b=nL+6b491BU5pCG8bf+n933PH+Kali59UqsHpRh+QGKNvnigOlMZ1m6KPvIP0v33k8+TO3E
        draM80XYL5Dh2F2JDTa458tGZQlgcmVUe2EJd1la+gGbqMcmNbOFJRQYuDeqmA1QR8GVlQ
        xyB8cZwMDBK1x3QiJGGamjPbVVgtkdFjet18KQeubBsayDzdlQWbKOTTdPiJ0fKUuUcCHQ
        lYKnLjaNuZ3HFH4qhryUmMIQCnEh+a1OPcGUcNPkAVvawwPSE+4NuUPhxLLs2RJaHkkku6
        Cde35jBgYS8Ibi/BjCCg+XUxGuujJ6l82KdfrWgmqU38tMPzj1t0TLj3b8LYrA==
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v3 4/5] lib/cpumask_kunit: log mask contents
Date:   Tue, 23 Aug 2022 08:12:22 +0200
Message-Id: <c4cf639db8bfbf2a77bd9b87c9f3fa0c2a8a84ae.1661234636.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661234636.git.sander@svanheule.net>
References: <cover.1661234636.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For extra context, log the contents of the masks under test.  This
should help with finding out why a certain test fails.

Link: https://lore.kernel.org/lkml/CABVgOSkPXBc-PWk1zBZRQ_Tt+Sz1ruFHBj3ixojymZF=Vi4tpQ@mail.gmail.com/
Suggested-by: David Gow <davidgow@google.com>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
Changes in v3:
Instead of unconditionally printing the mask contents before each test
with kunit_info(), use *_MSG() macros to only print on failure.
Drop David's Reviewed-by since the patch is completely rewritten.

 lib/cpumask_kunit.c | 51 +++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/lib/cpumask_kunit.c b/lib/cpumask_kunit.c
index 4d353614d853..ecbeec72221e 100644
--- a/lib/cpumask_kunit.c
+++ b/lib/cpumask_kunit.c
@@ -9,6 +9,10 @@
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 
+#define MASK_MSG(m) \
+	"%s contains %sCPUs %*pbl", #m, (cpumask_weight(m) ? "" : "no "), \
+	nr_cpumask_bits, cpumask_bits(m)
+
 #define EXPECT_FOR_EACH_CPU_EQ(test, mask)			\
 	do {							\
 		const cpumask_t *m = (mask);			\
@@ -16,7 +20,7 @@
 		int cpu, iter = 0;				\
 		for_each_cpu(cpu, m)				\
 			iter++;					\
-		KUNIT_EXPECT_EQ((test), mask_weight, iter);	\
+		KUNIT_EXPECT_EQ_MSG((test), mask_weight, iter, MASK_MSG(mask));	\
 	} while (0)
 
 #define EXPECT_FOR_EACH_CPU_NOT_EQ(test, mask)					\
@@ -26,7 +30,7 @@
 		int cpu, iter = 0;						\
 		for_each_cpu_not(cpu, m)					\
 			iter++;							\
-		KUNIT_EXPECT_EQ((test), nr_cpu_ids - mask_weight, iter);	\
+		KUNIT_EXPECT_EQ_MSG((test), nr_cpu_ids - mask_weight, iter, MASK_MSG(mask));	\
 	} while (0)
 
 #define EXPECT_FOR_EACH_CPU_WRAP_EQ(test, mask)			\
@@ -36,7 +40,7 @@
 		int cpu, iter = 0;				\
 		for_each_cpu_wrap(cpu, m, nr_cpu_ids / 2)	\
 			iter++;					\
-		KUNIT_EXPECT_EQ((test), mask_weight, iter);	\
+		KUNIT_EXPECT_EQ_MSG((test), mask_weight, iter, MASK_MSG(mask));	\
 	} while (0)
 
 #define EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, name)		\
@@ -45,7 +49,7 @@
 		int cpu, iter = 0;				\
 		for_each_##name##_cpu(cpu)			\
 			iter++;					\
-		KUNIT_EXPECT_EQ((test), mask_weight, iter);	\
+		KUNIT_EXPECT_EQ_MSG((test), mask_weight, iter, MASK_MSG(cpu_##name##_mask));	\
 	} while (0)
 
 static cpumask_t mask_empty;
@@ -53,36 +57,43 @@ static cpumask_t mask_all;
 
 static void test_cpumask_weight(struct kunit *test)
 {
-	KUNIT_EXPECT_TRUE(test, cpumask_empty(&mask_empty));
-	KUNIT_EXPECT_TRUE(test, cpumask_full(&mask_all));
+	KUNIT_EXPECT_TRUE_MSG(test, cpumask_empty(&mask_empty), MASK_MSG(&mask_empty));
+	KUNIT_EXPECT_TRUE_MSG(test, cpumask_full(&mask_all), MASK_MSG(&mask_all));
 
-	KUNIT_EXPECT_EQ(test, 0, cpumask_weight(&mask_empty));
-	KUNIT_EXPECT_EQ(test, nr_cpu_ids, cpumask_weight(cpu_possible_mask));
-	KUNIT_EXPECT_EQ(test, nr_cpumask_bits, cpumask_weight(&mask_all));
+	KUNIT_EXPECT_EQ_MSG(test, 0, cpumask_weight(&mask_empty), MASK_MSG(&mask_empty));
+	KUNIT_EXPECT_EQ_MSG(test, nr_cpu_ids, cpumask_weight(cpu_possible_mask),
+			    MASK_MSG(cpu_possible_mask));
+	KUNIT_EXPECT_EQ_MSG(test, nr_cpumask_bits, cpumask_weight(&mask_all), MASK_MSG(&mask_all));
 }
 
 static void test_cpumask_first(struct kunit *test)
 {
-	KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_first(&mask_empty));
-	KUNIT_EXPECT_EQ(test, 0, cpumask_first(cpu_possible_mask));
+	KUNIT_EXPECT_LE_MSG(test, nr_cpu_ids, cpumask_first(&mask_empty), MASK_MSG(&mask_empty));
+	KUNIT_EXPECT_EQ_MSG(test, 0, cpumask_first(cpu_possible_mask), MASK_MSG(cpu_possible_mask));
 
-	KUNIT_EXPECT_EQ(test, 0, cpumask_first_zero(&mask_empty));
-	KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_first_zero(cpu_possible_mask));
+	KUNIT_EXPECT_EQ_MSG(test, 0, cpumask_first_zero(&mask_empty), MASK_MSG(&mask_empty));
+	KUNIT_EXPECT_LE_MSG(test, nr_cpu_ids, cpumask_first_zero(cpu_possible_mask),
+			    MASK_MSG(cpu_possible_mask));
 }
 
 static void test_cpumask_last(struct kunit *test)
 {
-	KUNIT_EXPECT_LE(test, nr_cpumask_bits, cpumask_last(&mask_empty));
-	KUNIT_EXPECT_EQ(test, nr_cpu_ids - 1, cpumask_last(cpu_possible_mask));
+	KUNIT_EXPECT_LE_MSG(test, nr_cpumask_bits, cpumask_last(&mask_empty),
+			    MASK_MSG(&mask_empty));
+	KUNIT_EXPECT_EQ_MSG(test, nr_cpu_ids - 1, cpumask_last(cpu_possible_mask),
+			    MASK_MSG(cpu_possible_mask));
 }
 
 static void test_cpumask_next(struct kunit *test)
 {
-	KUNIT_EXPECT_EQ(test, 0, cpumask_next_zero(-1, &mask_empty));
-	KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_next_zero(-1, cpu_possible_mask));
-
-	KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_next(-1, &mask_empty));
-	KUNIT_EXPECT_EQ(test, 0, cpumask_next(-1, cpu_possible_mask));
+	KUNIT_EXPECT_EQ_MSG(test, 0, cpumask_next_zero(-1, &mask_empty), MASK_MSG(&mask_empty));
+	KUNIT_EXPECT_LE_MSG(test, nr_cpu_ids, cpumask_next_zero(-1, cpu_possible_mask),
+			    MASK_MSG(cpu_possible_mask));
+
+	KUNIT_EXPECT_LE_MSG(test, nr_cpu_ids, cpumask_next(-1, &mask_empty),
+			    MASK_MSG(&mask_empty));
+	KUNIT_EXPECT_EQ_MSG(test, 0, cpumask_next(-1, cpu_possible_mask),
+			    MASK_MSG(cpu_possible_mask));
 }
 
 static void test_cpumask_iterators(struct kunit *test)
-- 
2.37.2

