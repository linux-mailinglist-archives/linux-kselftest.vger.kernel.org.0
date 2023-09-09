Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1310B79961F
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 05:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240089AbjIIDhc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 23:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbjIIDha (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 23:37:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236861FE5;
        Fri,  8 Sep 2023 20:37:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA87C433C8;
        Sat,  9 Sep 2023 03:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694230646;
        bh=xT8faQ/VQn4QsrSETrKl21TSbXbkbXRLNmsjtMslsE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6nGX0tPVQa7fCjabWv9V2jpJs1DiN5xW7gllO09XsezCUlzsXPYyvzHVicPumwDV
         lQnjQlf0l+hoeoKIWbMAHjjrxe9+3JDdv8MpG5M9yHTg23+or5jvfqib8eX3+JpL2y
         Tgl+amkWP0P6lRiUwZcxGAi/ZVz6ECjZVVZBqKKd/9sNED8QDpRKxGOAfgsV77P3sV
         RvEBOP5H8fZIhDl871XivTV6JqG8VefCQc56DqGs/IhVAYPgftaTalFZp8iP0Vfy9N
         WNu3+4BqDt7DOpVmHvOL6X8XAsYAqNm6XCbHkhz2n5C4kvbPJKktYT2qEQy54weRGP
         Ed5aJ0cXUmMYw==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 4/8] mm/damon/core-test: add a unit test for damon_moving_sum()
Date:   Sat,  9 Sep 2023 03:37:07 +0000
Message-Id: <20230909033711.55794-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230909033711.55794-1-sj@kernel.org>
References: <20230909033711.55794-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a simple unit test for the pseudo moving-sum function
(damon_moving_sum()).

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..c539f0e8377e 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -341,6 +341,21 @@ static void damon_test_set_attrs(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
 }
 
+static void damon_test_moving_sum(struct kunit *test)
+{
+	unsigned int mvsum = 50000, nomvsum = 50000, len_window = 10;
+	unsigned int new_values[] = {10000, 0, 10000, 0, 0, 0, 10000, 0, 0, 0};
+	unsigned int expects[] = {55000, 50000, 55000, 50000, 45000, 40000,
+		45000, 40000, 35000, 30000};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(new_values); i++) {
+		mvsum = damon_moving_sum(mvsum, nomvsum, len_window,
+				new_values[i]);
+		KUNIT_EXPECT_EQ(test, mvsum, expects[i]);
+	}
+}
+
 static void damos_test_new_filter(struct kunit *test)
 {
 	struct damos_filter *filter;
@@ -425,6 +440,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_set_regions),
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
+	KUNIT_CASE(damon_test_moving_sum),
 	KUNIT_CASE(damos_test_new_filter),
 	KUNIT_CASE(damos_test_filter_out),
 	{},
-- 
2.25.1

