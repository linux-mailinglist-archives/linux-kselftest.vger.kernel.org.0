Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D630E776478
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 17:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjHIPzD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 11:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjHIPzA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 11:55:00 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97FF1FFA;
        Wed,  9 Aug 2023 08:54:59 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 379EvsGN002928;
        Wed, 9 Aug 2023 10:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=vsT2Du1dpYSZqCMgCeFpQVAdMU8X3uG+X2sBeOR9zkc=; b=
        oYWXedbE0utI51TIuu4NPDiDYX1xZC01SBr5ck50i1VzJpNdrKRx8TBHr342rhdi
        mjb8TVMxAKDU2hk7K1TzghEGkK47Idh5bOEBt4vWlBVTRNX27sorDdNn459G/8x+
        V0ifLnP6+WauVj4ck6MM3gA/wHIEpwcMTyTMoyKu5wPHpffFGxqnyshGNX7PUalV
        5qyVBPPNWpwwTCAQDwbiXvmUovv6TLEpQzxWicB00tbyXD+1BZvXejZ6hEoZXx6N
        4/PoGYGnCjRDsQsMl2gMN859FA15kTgszwfUwz67lORZf/zPPOcDE+xDoPRaQOVF
        GrmAvNOodiUBNKCriY2owg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhuvg7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 10:54:50 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 16:54:47 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Wed, 9 Aug 2023 16:54:47 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 25903357C;
        Wed,  9 Aug 2023 15:54:47 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 4/7] kunit: kunit-test: Test logging a line that exactly fills a fragment
Date:   Wed, 9 Aug 2023 16:54:35 +0100
Message-ID: <20230809155438.22470-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230809155438.22470-1-rf@opensource.cirrus.com>
References: <20230809155438.22470-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZDf1cKSOuqUQ1CRxQx4_V9XNri9AY5gA
X-Proofpoint-ORIG-GUID: ZDf1cKSOuqUQ1CRxQx4_V9XNri9AY5gA
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If a log string is the exact length of a log fragment buffer
kunit_log_append() should now exactly fill that fragment without
extending the log.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 lib/kunit/kunit-test.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index c0ee33a8031e..9ac81828d018 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -763,12 +763,49 @@ static void kunit_log_extend_test_2(struct kunit *test)
 #endif
 }
 
+static void kunit_log_frag_sized_line_test(struct kunit *test)
+{
+#ifdef CONFIG_KUNIT_DEBUGFS
+	struct kunit_suite suite;
+	struct kunit_log_frag *frag, *src;
+
+	suite.log = kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
+	INIT_LIST_HEAD(suite.log);
+	frag = kunit_kzalloc(test, sizeof(*frag), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
+	kunit_init_log_frag(frag);
+	list_add_tail(&frag->list, suite.log);
+
+	src = kunit_kzalloc(test, sizeof(*src), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, src);
+	memset(src->buf, 'x', sizeof(src->buf) - 2);
+	KUNIT_ASSERT_EQ(test, strlen(src->buf), sizeof(src->buf) - 2);
+
+	/* Log a string that exactly fills the fragment */
+	kunit_log_append(suite.log, "%s\n", src->buf);
+	KUNIT_EXPECT_TRUE(test, list_is_singular(suite.log));
+	KUNIT_EXPECT_EQ(test, strlen(frag->buf), sizeof(frag->buf) - 1);
+	strlcat(src->buf, "\n", sizeof(src->buf));
+	KUNIT_EXPECT_STREQ(test, frag->buf, src->buf);
+
+	/* Logging another string should extend the log */
+	kunit_log_append(suite.log, "Next\n");
+	KUNIT_EXPECT_EQ(test, list_count_nodes(suite.log), 2);
+	frag = list_last_entry(suite.log, struct kunit_log_frag, list);
+	KUNIT_EXPECT_STREQ(test, frag->buf, "Next\n");
+#else
+	kunit_skip(test, "only useful when debugfs is enabled");
+#endif
+}
+
 static struct kunit_case kunit_log_test_cases[] = {
 	KUNIT_CASE(kunit_log_init_frag_test),
 	KUNIT_CASE(kunit_log_test),
 	KUNIT_CASE(kunit_log_newline_test),
 	KUNIT_CASE(kunit_log_extend_test_1),
 	KUNIT_CASE(kunit_log_extend_test_2),
+	KUNIT_CASE(kunit_log_frag_sized_line_test),
 	{}
 };
 
-- 
2.30.2

