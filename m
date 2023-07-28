Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1ABB767703
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 22:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjG1Ue4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 16:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjG1Uey (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 16:34:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D040B44B1;
        Fri, 28 Jul 2023 13:34:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25D0A621DE;
        Fri, 28 Jul 2023 20:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B8FC433C7;
        Fri, 28 Jul 2023 20:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690576490;
        bh=aTd7ZuoN2dqMb+Dc3vZmzHmkBbEHdDRR0W76w/Wxm9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHaALqesayPQAQaMFyoatkS0d9yBuH4VODT9oIuLMtnuAYobLsCePrdVnBbcsbqqI
         VBDvvxTRr6nqxiWs+zGazfRlogNLiP45rDy2vrRvGL7e6Uj5UlZciuqGHUfpgqoMv3
         0f6p2eJ4s3HUw0+aMGyXSDYfCSJ3HijPVajgOTVCY3bH4bKqTAumxSG5m8NKPOd7Di
         QE599sbBuX1GKUKHgOO2OWsG1PfEFk/S1J56QLMkx8qe4Zf0hIjqRfVgQ+ZKPqiIxQ
         WyWIfDqCEzRje4Caw7wlBeubHSlwUsIfL+O3Oaobp4qZeBM2YikOnI3sLb/ipF0D04
         f22X8tBKLD/Sw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/13] mm/damon/sysfs-schemes: support address range type DAMOS filter
Date:   Fri, 28 Jul 2023 20:34:34 +0000
Message-Id: <20230728203444.70703-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728203444.70703-1-sj@kernel.org>
References: <20230728203444.70703-1-sj@kernel.org>
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

Date: Sat, 22 Jul 2023 19:45:58 +0000
Subject: [RFC PATCH 03/13] mm/damon/core-test: add a unit test for
 __damos_filter_out()

Implement a kunit test for the core of address range DAMOS filter
handling, namely __damos_filter_out().  The test especially focus on
regions that overlap with given filter's target address range.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index bb07721909e1..44e925bbb094 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -341,6 +341,66 @@ static void damon_test_set_attrs(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
 }
 
+static void damos_test_filter_out(struct kunit *test)
+{
+	struct damon_target *t;
+	struct damon_region *r, *r2;
+	struct damos_filter *f;
+
+	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true);
+	f->addr_range = (struct damon_addr_range){
+		.start = DAMON_MIN_REGION * 2, .end = DAMON_MIN_REGION * 6};
+
+	t = damon_new_target();
+	r = damon_new_region(DAMON_MIN_REGION * 3, DAMON_MIN_REGION * 5);
+	damon_add_region(r, t);
+
+	/* region in the range */
+	KUNIT_EXPECT_TRUE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
+
+	/* region before the range */
+	r->ar.start = DAMON_MIN_REGION * 1;
+	r->ar.end = DAMON_MIN_REGION * 2;
+	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
+
+	/* region after the range */
+	r->ar.start = DAMON_MIN_REGION * 6;
+	r->ar.end = DAMON_MIN_REGION * 8;
+	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
+
+	/* region started before the range */
+	r->ar.start = DAMON_MIN_REGION * 1;
+	r->ar.end = DAMON_MIN_REGION * 4;
+	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
+	/* filter should have split the region */
+	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 1);
+	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 2);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	r2 = damon_next_region(r);
+	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 2);
+	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 4);
+	damon_destroy_region(r2, t);
+
+	/* region started in the range */
+	r->ar.start = DAMON_MIN_REGION * 2;
+	r->ar.end = DAMON_MIN_REGION * 8;
+	KUNIT_EXPECT_TRUE(test, __damos_filter_out(NULL, t, r, f));
+	/* filter should have split the region */
+	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 2);
+	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 6);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	r2 = damon_next_region(r);
+	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 6);
+	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 8);
+	damon_destroy_region(r2, t);
+
+	damon_free_target(t);
+	damos_free_filter(f);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -353,6 +413,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_set_regions),
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
+	KUNIT_CASE(damos_test_filter_out),
 	{},
 };
 
-- 
2.25.1

