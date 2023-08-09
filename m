Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B17B776479
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 17:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjHIPzE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 11:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjHIPzB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 11:55:01 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FDE2100;
        Wed,  9 Aug 2023 08:55:01 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 379EvsGO002928;
        Wed, 9 Aug 2023 10:54:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=6QLn6bSvhN4NK1Fgih/1NOqLGf5bUsI0DnIadC7OYbA=; b=
        o1nRpUkE1OX3f2d2OGJR6JgnofdOuSMJz5TPNrvG2yeT8nNJ9OBKG0BfpycXT28Q
        Fh0oWZBmzcgRuw0GRtAWenxKxWHgLbMq2xWJfWhc9XjDKLdbe68wsleIaPuMq2Bt
        VUhxywsNzSb54RkVdwLT/SGKjiO+sIpzgq8/4MGZ8yB2hVrysRsBiA0+zvPKpjnH
        4AJette8oaveJIWeBs1t4zKuc5AURcwOE8OwT53GUtX15LnQmNt5M0hvwVdY1ZC2
        tjEvYllpOoNWzwcXsj6J85STtMI/OX6H1dYQrkyQlJVM23UbDxrMedUwL+u8J3Xw
        of3VOlKF1VdwrtLwayt+rQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhuvg7-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 10:54:51 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 16:54:47 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Wed, 9 Aug 2023 16:54:47 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 90B0D45D;
        Wed,  9 Aug 2023 15:54:47 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 5/7] kunit: kunit-test: Add test cases for logging very long lines
Date:   Wed, 9 Aug 2023 16:54:36 +0100
Message-ID: <20230809155438.22470-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230809155438.22470-1-rf@opensource.cirrus.com>
References: <20230809155438.22470-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4qyh8ChHAm8i7968d0VHjHYw4fYRL-XX
X-Proofpoint-ORIG-GUID: 4qyh8ChHAm8i7968d0VHjHYw4fYRL-XX
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add kunit_log_long_line_test() to test that logging a line longer than
the buffer fragment size doesn't truncate the line.

Add extra tests to kunit_log_newline_test() for lines longer than the
buffer fragment size.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 lib/kunit/kunit-test.c | 84 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 9ac81828d018..c079550c3afd 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -609,7 +609,7 @@ static void kunit_log_newline_test(struct kunit *test)
 {
 	struct kunit_suite suite;
 	struct kunit_log_frag *frag;
-	char *p;
+	char *p, *line;
 
 	kunit_info(test, "Add newline\n");
 	if (test->log) {
@@ -635,6 +635,33 @@ static void kunit_log_newline_test(struct kunit *test)
 		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
 		KUNIT_EXPECT_NOT_NULL_MSG(test, strstr(p, "x12345678\n"),
 			"Newline not appended when fragment is full. Log is:\n'%s'", p);
+		kunit_kfree(test, p);
+
+		/* String that is much longer than a fragment */
+		line = kunit_kzalloc(test, sizeof(frag->buf) * 6, GFP_KERNEL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, line);
+		memset(line, 'x', (sizeof(frag->buf) * 6) - 1);
+		kunit_log_append(suite.log, "%s", line);
+		p = get_concatenated_log(test, suite.log, NULL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+		KUNIT_EXPECT_EQ(test, p[strlen(p) - 1], '\n');
+		KUNIT_EXPECT_NULL(test, strstr(p, "\n\n"));
+		kunit_kfree(test, p);
+
+		kunit_log_append(suite.log, "%s\n", line);
+		p = get_concatenated_log(test, suite.log, NULL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+		KUNIT_EXPECT_EQ(test, p[strlen(p) - 1], '\n');
+		KUNIT_EXPECT_NULL(test, strstr(p, "\n\n"));
+		kunit_kfree(test, p);
+
+		line[strlen(line) - 1] = '\n';
+		kunit_log_append(suite.log, "%s", line);
+		p = get_concatenated_log(test, suite.log, NULL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+		KUNIT_EXPECT_EQ(test, p[strlen(p) - 1], '\n');
+		KUNIT_EXPECT_NULL(test, strstr(p, "\n\n"));
+		kunit_kfree(test, p);
 	} else {
 		kunit_skip(test, "only useful when debugfs is enabled");
 	}
@@ -799,6 +826,60 @@ static void kunit_log_frag_sized_line_test(struct kunit *test)
 #endif
 }
 
+static void kunit_log_long_line_test(struct kunit *test)
+{
+#ifdef CONFIG_KUNIT_DEBUGFS
+	struct kunit_suite suite;
+	struct kunit_log_frag *frag;
+	struct rnd_state rnd;
+	char *line, *p, *pn;
+	size_t line_buf_size, len;
+	int num_frags, i;
+
+	suite.log = kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
+	INIT_LIST_HEAD(suite.log);
+	frag = kunit_kmalloc(test, sizeof(*frag), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
+	kunit_init_log_frag(frag);
+	KUNIT_EXPECT_EQ(test, frag->buf[0], '\0');
+	list_add_tail(&frag->list, suite.log);
+
+	/* Create a very long string to be logged */
+	line_buf_size = sizeof(frag->buf) * 6;
+	line = kunit_kmalloc(test, line_buf_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, line);
+	line[0] = '\0';
+
+	prandom_seed_state(&rnd, 3141592653589793238ULL);
+	len = 0;
+	do {
+		static const char fill[] =
+			"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
+
+		i = prandom_u32_state(&rnd) % (sizeof(fill) - 1);
+		len = strlcat(line, &fill[i], line_buf_size);
+	} while (len < line_buf_size);
+
+	kunit_log_append(suite.log, "%s\n", line);
+
+	p = get_concatenated_log(test, suite.log, &num_frags);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+	KUNIT_EXPECT_GT(test, num_frags, 1);
+
+	kunit_info(test, "num_frags:%d total len:%zu\n", num_frags, strlen(p));
+
+	/* Don't compare the trailing '\n' */
+	pn = strrchr(p, '\n');
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, pn);
+	*pn = '\0';
+	KUNIT_EXPECT_EQ(test, strlen(p), strlen(line));
+	KUNIT_EXPECT_STREQ(test, p, line);
+#else
+	kunit_skip(test, "only useful when debugfs is enabled");
+#endif
+}
+
 static struct kunit_case kunit_log_test_cases[] = {
 	KUNIT_CASE(kunit_log_init_frag_test),
 	KUNIT_CASE(kunit_log_test),
@@ -806,6 +887,7 @@ static struct kunit_case kunit_log_test_cases[] = {
 	KUNIT_CASE(kunit_log_extend_test_1),
 	KUNIT_CASE(kunit_log_extend_test_2),
 	KUNIT_CASE(kunit_log_frag_sized_line_test),
+	KUNIT_CASE(kunit_log_long_line_test),
 	{}
 };
 
-- 
2.30.2

