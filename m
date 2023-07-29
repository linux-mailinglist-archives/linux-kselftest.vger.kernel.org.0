Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE4F7681CE
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 22:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjG2Uhm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 16:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjG2Uhl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 16:37:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8F41709;
        Sat, 29 Jul 2023 13:37:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B206660AF3;
        Sat, 29 Jul 2023 20:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B03C433C8;
        Sat, 29 Jul 2023 20:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690663059;
        bh=YPgSpddY9t4io6ikXCAUlDHPpj8ulBukto96IBJDPnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UyYSf2rL2uLdPSrcPn4/N9GQkTxV2zBIT8nd/j+Pzf7IOWlL0PseartNH8Cn0JhVZ
         COd+atrvWOy+pR5Xj10r0PicBAH309HUuAWue8TI+VqsKvXlV/1j5hjW/IJwfzhjsJ
         wV/VG0X1OD3dUfsEC1DHpVRHoKSAsqBmBBZUq2c6b55yGCMYY7xgXL8VF9fvAcRam+
         RdZEJzlrf/XHTZGqM8gvZZPBzuogVfCrwuWJPElLFGLb5X+WwtAd2KwiZfAL/lRcp3
         f1eCVHWjTgJVP6BQ/P/aJT8bfaoszMfOqWxMO0UQDiVLvKEaeMfWs9vucDczB2xF5O
         wJb9IiQv4jIZQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm/damon/core-test: add a test for damos_new_filter()
Date:   Sat, 29 Jul 2023 20:37:33 +0000
Message-Id: <20230729203733.38949-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729203733.38949-1-sj@kernel.org>
References: <20230729203733.38949-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

damos_new_filter() was having a bug that not initializing ->list field
of the returning damos_filter struct, which results in access to
uninitialized memory.  Add a unit test for the function.

Cc: stable@vger.kernel.org # 6.3.x-
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index bb07721909e1..4bddbfe243c3 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -341,6 +341,18 @@ static void damon_test_set_attrs(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
 }
 
+static void damos_test_new_filter(struct kunit *test)
+{
+	struct damos_filter *filter;
+
+	filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true);
+	KUNIT_EXPECT_EQ(test, filter->type, DAMOS_FILTER_TYPE_ANON);
+	KUNIT_EXPECT_EQ(test, filter->matching, true);
+	KUNIT_EXPECT_PTR_EQ(test, filter->list.prev, &filter->list);
+	KUNIT_EXPECT_PTR_EQ(test, filter->list.next, &filter->list);
+	damos_destroy_filter(filter);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -353,6 +365,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_set_regions),
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
+	KUNIT_CASE(damos_test_new_filter),
 	{},
 };
 
-- 
2.25.1

