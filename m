Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D1059AEC5
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Aug 2022 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiHTPD2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Aug 2022 11:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346147AbiHTPD0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Aug 2022 11:03:26 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0CA10FE5
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Aug 2022 08:03:23 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 9665C30EB94;
        Sat, 20 Aug 2022 17:03:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1661007800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vz1mQ8TTgTSwRJzhr5SbzzwydwAm9hzJe9xRSznxUFg=;
        b=NSUrJZHhRJzjdtXM3WyeZewA1VD5+jXv4iNPPN5TA8iHQJWv61HWoL0/2Sv3NzMok28OrK
        hluVpSOzWqLCAXtGerrxAyp1rniZAmFHbqTsSI5x/kCMx7z2qIRSPEoMenkLNOcFMK3cI9
        Qj6KPaufJ0Ge2Ad/htYtfW0yT0xdcosrJ755FcSELb1nwsnn/dT/D73wcZ9NqVo3G1v3Qz
        /X51VyhW27eCOvINv49Skv2ZdKYYdNPu1yq2wTL506vD5J1hKLq/9lpR2I9/cBGE+outJu
        YIkzFMt0R4ed0UqCyGBBMn2Gy78wmnMnMbzKI2mMGU8bQkA4BSH2v9hLamjvUQ==
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
Subject: [PATCH v2 4/5] lib/cpumask_kunit: log mask contents
Date:   Sat, 20 Aug 2022 17:03:12 +0200
Message-Id: <98cb4e5323c2059506e93cb39c32ba471031e487.1661007339.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661007338.git.sander@svanheule.net>
References: <cover.1661007338.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
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
Reviewed-by: David Gow <davidgow@google.com>
---
 lib/cpumask_kunit.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/cpumask_kunit.c b/lib/cpumask_kunit.c
index 4d353614d853..0f8059a5e93b 100644
--- a/lib/cpumask_kunit.c
+++ b/lib/cpumask_kunit.c
@@ -51,6 +51,10 @@
 static cpumask_t mask_empty;
 static cpumask_t mask_all;
 
+#define STR_MASK(m)			#m
+#define TEST_CPUMASK_PRINT(test, mask)	\
+	kunit_info(test, "%s = '%*pbl'\n", STR_MASK(mask), nr_cpumask_bits, cpumask_bits(mask))
+
 static void test_cpumask_weight(struct kunit *test)
 {
 	KUNIT_EXPECT_TRUE(test, cpumask_empty(&mask_empty));
@@ -103,6 +107,9 @@ static void test_cpumask_iterators_builtin(struct kunit *test)
 	/* Ensure the dynamic masks are stable while running the tests */
 	cpu_hotplug_disable();
 
+	TEST_CPUMASK_PRINT(test, cpu_online_mask);
+	TEST_CPUMASK_PRINT(test, cpu_present_mask);
+
 	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, online);
 	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, present);
 
@@ -114,6 +121,9 @@ static int test_cpumask_init(struct kunit *test)
 	cpumask_clear(&mask_empty);
 	cpumask_setall(&mask_all);
 
+	TEST_CPUMASK_PRINT(test, &mask_all);
+	TEST_CPUMASK_PRINT(test, cpu_possible_mask);
+
 	return 0;
 }
 
-- 
2.37.2

