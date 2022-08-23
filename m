Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990B059D10B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 08:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240489AbiHWGM7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 02:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbiHWGM6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 02:12:58 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E1A5FF43
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 23:12:57 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 9A33431020D;
        Tue, 23 Aug 2022 08:12:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1661235174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ubT/JAtaWgq8nqhI71BuKm2VNLBkXvwuIwpSu5501wg=;
        b=Ym8u8oB/epFNEqAq3a/oD9kjx84kZjTkMOPtuOJvKIzBWxhqy2Jl5VpROVXwaeUd8ip4a1
        5toq0gewVbmdQHfRLGceMGsAZZI8GOO+vznTvMmaebFGbmAsgVwk7XEWzLlk2Ktyc+yK5n
        64JFXZgPwgeDFVojSUB1mmKQPmuobYppxlqPzuddySnyycw0WnaDh3UJTp5ZY4fNTLQN8C
        e5UdlerBzzBzRGWL9mhvp8e9XknRiy9p2L4Cq8QRNZ3VMuriCQrAGPSByTKOvi6Ag2iQZW
        N4nsE6iDo8Nf64WY3cnneuhmVW/5o5x/3dfgK+dNQuB5xCQas4hNcR126DWy5Q==
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
Subject: [PATCH v3 1/5] lib/test_cpumask: drop cpu_possible_mask full test
Date:   Tue, 23 Aug 2022 08:12:19 +0200
Message-Id: <e9eacbd07280acc41ccdc3a7f36f65be515016e2.1661234636.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661234636.git.sander@svanheule.net>
References: <cover.1661234636.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When the number of CPUs that can possibly be brought online is known at
boot time, e.g. when HOTPLUG is disabled, nr_cpu_ids may be smaller than
NR_CPUS. In that case, cpu_possible_mask would not be completely filled,
and cpumask_full(cpu_possible_mask) can return false for valid system
configurations.

Without this test, cpu_possible_mask contents are still constrained by
a check on cpumask_weight(), as well as tests in test_cpumask_first(),
test_cpumask_last(), test_cpumask_next(), and test_cpumask_iterators().

Fixes: c41e8866c28c ("lib/test: introduce cpumask KUnit test suite")
Link: https://lore.kernel.org/lkml/346cb279-8e75-24b0-7d12-9803f2b41c73@riseup.net/
Reported-by: Maíra Canal <mairacanal@riseup.net>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
Tested-by: Maíra Canal <mairacanal@riseup.net>
Reviewed-by: David Gow <davidgow@google.com>
---
Changes in v3:
- Update commit message to list remaining tests on cpu_possible_mask

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

