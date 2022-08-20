Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F77059AEC9
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Aug 2022 17:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346238AbiHTPD1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Aug 2022 11:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345626AbiHTPDY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Aug 2022 11:03:24 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBA8E01C
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Aug 2022 08:03:22 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 9305E30EB92;
        Sat, 20 Aug 2022 17:03:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1661007799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYoXo9Uj1ClWwc72cGgN96VKKPWT/V+JrjDkhA1opnI=;
        b=JYkppuCD4ZTQdOKE171KtKZmI4+28+vHSTvaZVkbzygF8651ki0V8u2gJX6kY+EoVGiEFH
        fYSR/iBbu7PXPoUGewW6fOmmBSAIWki/xTK5sJKpgNxJFx9prQK0QGZjgAxMqpEYb0i2Pp
        8WAE30hRYG5iM/15hSlXKHcykLK1I07nvIP9VF1HjWbnpaE/6Ab3rtcEIbDUM96rZu/J1p
        QgymeV2XaQF35fzs8dZf5efYary+FbjbfOF6KieAwK6NPVs4o1EKvIwzjbtchcTrG2hMKJ
        mJdTuvER+yjVAVOzYHbTlnHARkAtohM86NhmtJmQ7kKYAVAsC9unTkUmyAj8jA==
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
Subject: [PATCH v2 2/5] lib/test_cpumask: fix cpu_possible_mask last test
Date:   Sat, 20 Aug 2022 17:03:10 +0200
Message-Id: <24124beb0fe001ab4cac141a8e5ebf41599d6792.1661007339.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661007338.git.sander@svanheule.net>
References: <cover.1661007338.git.sander@svanheule.net>
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

Since cpumask_first() on the cpu_possible_mask must return at most
nr_cpu_ids - 1 for a valid result, cpumask_last() cannot return anything
larger than this value.  As test_cpumask_weight() also verifies that the
total weight of cpu_possible_mask must equal nr_cpu_ids, the last bit
set in this mask must be at nr_cpu_ids - 1.

Fixes: c41e8866c28c ("lib/test: introduce cpumask KUnit test suite")
Link: https://lore.kernel.org/lkml/346cb279-8e75-24b0-7d12-9803f2b41c73@riseup.net/
Reported-by: Maíra Canal <mairacanal@riseup.net>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
Tested-by: Maíra Canal <mairacanal@riseup.net>
Reviewed-by: David Gow <davidgow@google.com>
---
 lib/test_cpumask.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
index 4ebf9f5805f3..4d353614d853 100644
--- a/lib/test_cpumask.c
+++ b/lib/test_cpumask.c
@@ -73,7 +73,7 @@ static void test_cpumask_first(struct kunit *test)
 static void test_cpumask_last(struct kunit *test)
 {
 	KUNIT_EXPECT_LE(test, nr_cpumask_bits, cpumask_last(&mask_empty));
-	KUNIT_EXPECT_EQ(test, nr_cpumask_bits - 1, cpumask_last(cpu_possible_mask));
+	KUNIT_EXPECT_EQ(test, nr_cpu_ids - 1, cpumask_last(cpu_possible_mask));
 }
 
 static void test_cpumask_next(struct kunit *test)
-- 
2.37.2

