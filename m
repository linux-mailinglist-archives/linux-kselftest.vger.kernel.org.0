Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D6559AECA
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Aug 2022 17:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiHTPD0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Aug 2022 11:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344493AbiHTPDY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Aug 2022 11:03:24 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E305BF7C
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Aug 2022 08:03:21 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id EC5F130EB91;
        Sat, 20 Aug 2022 17:03:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1661007799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+7AAdDRL/f7FSphHpccBaW6Xe1Vk3ErU6kmokpL3Rw=;
        b=7lAHiwN1M6TeEfTRC+rmea1OcIvfct2NbCM7g7JOD690ZXNs4Urh8v/b3LMgazRfk2YKiM
        qDkfZcLkSgbW4acHvkTNKlBwX9dtNII8oZAZlDjAPF8xhHfHxBocSb2fCzrQFnMmSXEQ1D
        K/6aawqsXf3IqoyHM/ne6w0fc8Fv4yhfYW7mZI+A+TdZdNCNUJ9V/KnkyWhke/IQNtSIsd
        tYpP0CQ+8wQxciSTDsuNfub79dDi4QYADeqMiH6l+AHPyNlC9tqTk5FkAharfrfiLkjXJb
        d/KVqkcWfnoAmbN35II/SC5U7l/6jvPkgodydP/FJ579Sl9OfBuGpk6md/pzPA==
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
Subject: [PATCH v2 1/5] lib/test_cpumask: drop cpu_possible_mask full test
Date:   Sat, 20 Aug 2022 17:03:09 +0200
Message-Id: <6dfd4d3a4d77f97f13ab3f22bc53c96c38ba908e.1661007339.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661007338.git.sander@svanheule.net>
References: <cover.1661007338.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When the number of CPUs that can possibly be brought online is known at
boot time, e.g. when HOTPLUG is disabled, nr_cpu_ids may be smaller than
NR_CPUS. In that case, cpu_possible_mask would not be completely filled,
and cpumask_full(cpu_possible_mask) can return false for valid system
configurations.

Fixes: c41e8866c28c ("lib/test: introduce cpumask KUnit test suite")
Link: https://lore.kernel.org/lkml/346cb279-8e75-24b0-7d12-9803f2b41c73@riseup.net/
Reported-by: Maíra Canal <mairacanal@riseup.net>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
Tested-by: Maíra Canal <mairacanal@riseup.net>
Reviewed-by: David Gow <davidgow@google.com>
---
Changes in v2:
Rewrite commit message to explain why this test is wrong

 lib/test_cpumask.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
index a31a1622f1f6..4ebf9f5805f3 100644
--- a/lib/test_cpumask.c
+++ b/lib/test_cpumask.c
@@ -54,7 +54,6 @@ static cpumask_t mask_all;
 static void test_cpumask_weight(struct kunit *test)
 {
 	KUNIT_EXPECT_TRUE(test, cpumask_empty(&mask_empty));
-	KUNIT_EXPECT_TRUE(test, cpumask_full(cpu_possible_mask));
 	KUNIT_EXPECT_TRUE(test, cpumask_full(&mask_all));
 
 	KUNIT_EXPECT_EQ(test, 0, cpumask_weight(&mask_empty));
-- 
2.37.2

