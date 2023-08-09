Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44605776476
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 17:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjHIPzD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 11:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjHIPzA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 11:55:00 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985B21729;
        Wed,  9 Aug 2023 08:54:59 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 379EvsGL002928;
        Wed, 9 Aug 2023 10:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=c0+NukA+EoHsX21OuWFjmky1fG8j/3yMLBFVBs2CY6w=; b=
        Q6AhjrDu2RhqQq2gB1DNxz86p6FTnuVuStz1XHuVbFLBTevyr3kJBcXSKYuN1APe
        m+v+QkBxmGeyQT8NfdWLvBgpo0RJ81ilp26WFahZQhi5n7XURTmZ6m75dr7ngaNn
        Drz2MG3KuexPhnYqMNjEulFsbWf7Bb/Rl1Jgt39iyWnLYTO+S/+YbruXYvRnPraN
        qrTcEx6BmFa0WxWVEFiefGVoW34haiJXl0AatyakI0eM4ae5qcF/PEBaiwInqTDs
        q0PligxtP9CftIsqLA/j18Rq7PQXhpMfWm+kWRRbIQSkvc4peSla2RvUkaRAoxqJ
        5Z1jHi/eHdNHWeY4CPzBGg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhuvg7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 10:54:48 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 16:54:46 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Wed, 9 Aug 2023 16:54:46 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1CB2945D;
        Wed,  9 Aug 2023 15:54:46 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 2/7] kunit: kunit-test: Add test cases for extending log buffer
Date:   Wed, 9 Aug 2023 16:54:33 +0100
Message-ID: <20230809155438.22470-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230809155438.22470-1-rf@opensource.cirrus.com>
References: <20230809155438.22470-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ctyYVCGN5YvT4vffDpuyZ-Y5sQ2Z8oMC
X-Proofpoint-ORIG-GUID: ctyYVCGN5YvT4vffDpuyZ-Y5sQ2Z8oMC
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add test cases for the dynamically-extending log buffer.

kunit_log_init_frag_test() tests that kunit_init_log_frag() correctly
initializes new struct kunit_log_frag.

kunit_log_extend_test_1() logs a series of numbered lines then tests
that the resulting log contains all the lines.

kunit_log_extend_test_2() logs a large number of lines of varying length
to create many fragments, then tests that all lines are present.

kunit_log_newline_test() has a new test to append a line that is exactly
the length of the available space in the current fragment and check that
the resulting log has a trailing '\n'.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 lib/kunit/kunit-test.c | 182 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 174 insertions(+), 8 deletions(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index a199f83bac67..c0ee33a8031e 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -7,6 +7,7 @@
  */
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
+#include <linux/prandom.h>
 
 #include "try-catch-impl.h"
 
@@ -530,10 +531,12 @@ static struct kunit_suite kunit_resource_test_suite = {
 	.test_cases = kunit_resource_test_cases,
 };
 
-static char *get_concatenated_log(struct kunit *test, const struct list_head *log)
+static char *get_concatenated_log(struct kunit *test, const struct list_head *log,
+				  int *num_frags)
 {
 	struct kunit_log_frag *frag;
 	size_t len = 0;
+	int frag_count = 0;
 	char *p;
 
 	list_for_each_entry(frag, log, list)
@@ -542,24 +545,42 @@ static char *get_concatenated_log(struct kunit *test, const struct list_head *lo
 	len++; /* for terminating '\0' */
 	p = kunit_kzalloc(test, len, GFP_KERNEL);
 
-	list_for_each_entry(frag, log, list)
+	list_for_each_entry(frag, log, list) {
 		strlcat(p, frag->buf, len);
+		++frag_count;
+	}
+
+	if (num_frags)
+		*num_frags = frag_count;
 
 	return p;
 }
 
-static void kunit_log_test(struct kunit *test)
+static void kunit_log_init_frag_test(struct kunit *test)
 {
-	struct kunit_suite suite;
 	struct kunit_log_frag *frag;
 
-	suite.log = kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
-	INIT_LIST_HEAD(suite.log);
 	frag = kunit_kmalloc(test, sizeof(*frag), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
+	memset(frag, 0x5a, sizeof(*frag));
+
 	kunit_init_log_frag(frag);
 	KUNIT_EXPECT_EQ(test, frag->buf[0], '\0');
+	KUNIT_EXPECT_TRUE(test, list_is_first(&frag->list, &frag->list));
+	KUNIT_EXPECT_TRUE(test, list_is_last(&frag->list, &frag->list));
+}
+
+static void kunit_log_test(struct kunit *test)
+{
+	struct kunit_suite suite;
+	struct kunit_log_frag *frag;
+
+	suite.log = kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
+	INIT_LIST_HEAD(suite.log);
+	frag = kunit_kzalloc(test, sizeof(*frag), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
+	kunit_init_log_frag(frag);
 	list_add_tail(&frag->list, suite.log);
 
 	kunit_log(KERN_INFO, test, "put this in log.");
@@ -586,23 +607,168 @@ static void kunit_log_test(struct kunit *test)
 
 static void kunit_log_newline_test(struct kunit *test)
 {
+	struct kunit_suite suite;
 	struct kunit_log_frag *frag;
+	char *p;
 
 	kunit_info(test, "Add newline\n");
 	if (test->log) {
 		frag = list_first_entry(test->log, struct kunit_log_frag, list);
 		KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(frag->buf, "Add newline\n"),
 			"Missing log line, full log:\n%s",
-			get_concatenated_log(test, test->log));
+			get_concatenated_log(test, test->log, NULL));
 		KUNIT_EXPECT_NULL(test, strstr(frag->buf, "Add newline\n\n"));
+
+		suite.log = kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
+		INIT_LIST_HEAD(suite.log);
+		frag = kunit_kzalloc(test, sizeof(*frag), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
+		kunit_init_log_frag(frag);
+		list_add_tail(&frag->list, suite.log);
+
+		/* String that exactly fills fragment leaving no room for \n */
+		memset(frag->buf, 0, sizeof(frag->buf));
+		memset(frag->buf, 'x', sizeof(frag->buf) - 9);
+		kunit_log_append(suite.log, "12345678");
+		p = get_concatenated_log(test, suite.log, NULL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+		KUNIT_EXPECT_NOT_NULL_MSG(test, strstr(p, "x12345678\n"),
+			"Newline not appended when fragment is full. Log is:\n'%s'", p);
 	} else {
 		kunit_skip(test, "only useful when debugfs is enabled");
 	}
 }
 
+static void kunit_log_extend_test_1(struct kunit *test)
+{
+#ifdef CONFIG_KUNIT_DEBUGFS
+	struct kunit_suite suite;
+	struct kunit_log_frag *frag;
+	char line[60];
+	char *p, *pn;
+	size_t len, n;
+	int num_lines, num_frags, i;
+
+	suite.log = kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
+	INIT_LIST_HEAD(suite.log);
+	frag = kunit_kzalloc(test, sizeof(*frag), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
+	kunit_init_log_frag(frag);
+	list_add_tail(&frag->list, suite.log);
+
+	i = 0;
+	len = 0;
+	do {
+		n = snprintf(line, sizeof(line),
+			     "The quick brown fox jumps over the lazy penguin %d\n", i);
+		KUNIT_ASSERT_LT(test, n, sizeof(line));
+		kunit_log_append(suite.log, line);
+		++i;
+		len += n;
+	}  while (len < (sizeof(frag->buf) * 30));
+	num_lines = i;
+
+	p = get_concatenated_log(test, suite.log, &num_frags);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+	KUNIT_EXPECT_GT(test, num_frags, 1);
+
+	kunit_info(test, "num lines:%d num_frags:%d total len:%zu\n",
+		   num_lines, num_frags, strlen(p));
+
+	i = 0;
+	while ((pn = strchr(p, '\n')) != NULL) {
+		*pn = '\0';
+		snprintf(line, sizeof(line),
+			 "The quick brown fox jumps over the lazy penguin %d", i);
+		KUNIT_EXPECT_STREQ(test, p, line);
+		p = pn + 1;
+		++i;
+	}
+	KUNIT_EXPECT_EQ(test, i, num_lines);
+#else
+	kunit_skip(test, "only useful when debugfs is enabled");
+#endif
+}
+
+static void kunit_log_extend_test_2(struct kunit *test)
+{
+#ifdef CONFIG_KUNIT_DEBUGFS
+	struct kunit_suite suite;
+	struct kunit_log_frag *frag;
+	struct rnd_state rnd;
+	char line[101];
+	char *p, *pn;
+	size_t len;
+	int num_lines, num_frags, n, i;
+
+	suite.log = kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
+	INIT_LIST_HEAD(suite.log);
+	frag = kunit_kzalloc(test, sizeof(*frag), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
+	kunit_init_log_frag(frag);
+	list_add_tail(&frag->list, suite.log);
+
+	/* Build log line of varying content */
+	line[0] = '\0';
+	i = 0;
+	do {
+		char tmp[9];
+
+		snprintf(tmp, sizeof(tmp), "%x", i++);
+		len = strlcat(line, tmp, sizeof(line));
+	} while (len < sizeof(line) - 1);
+
+	/*
+	 * Log lines of different lengths until we have created
+	 * many fragments.
+	 * The "randomness" must be repeatable.
+	 */
+	prandom_seed_state(&rnd, 3141592653589793238ULL);
+	i = 0;
+	len = 0;
+	num_lines = 0;
+	do {
+		kunit_log_append(suite.log, "%s\n", &line[i]);
+		len += sizeof(line) - i;
+		num_lines++;
+		i = prandom_u32_state(&rnd) % (sizeof(line) - 1);
+	} while (len < (sizeof(frag->buf) * 30));
+
+	/* There must be more than one buffer fragment now */
+	KUNIT_EXPECT_FALSE(test, list_is_singular(suite.log));
+
+	p = get_concatenated_log(test, suite.log, &num_frags);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+	KUNIT_EXPECT_GT(test, num_frags, 1);
+
+	kunit_info(test, "num lines:%d num_frags:%d total len:%zu\n",
+		   num_lines, num_frags, strlen(p));
+
+	prandom_seed_state(&rnd, 3141592653589793238ULL);
+	i = 0;
+	n = 0;
+	while ((pn = strchr(p, '\n')) != NULL) {
+		*pn = '\0';
+		KUNIT_EXPECT_STREQ(test, p, &line[i]);
+		p = pn + 1;
+		n++;
+		i = prandom_u32_state(&rnd) % (sizeof(line) - 1);
+	}
+	KUNIT_EXPECT_EQ_MSG(test, n, num_lines, "Not enough lines.");
+#else
+	kunit_skip(test, "only useful when debugfs is enabled");
+#endif
+}
+
 static struct kunit_case kunit_log_test_cases[] = {
+	KUNIT_CASE(kunit_log_init_frag_test),
 	KUNIT_CASE(kunit_log_test),
 	KUNIT_CASE(kunit_log_newline_test),
+	KUNIT_CASE(kunit_log_extend_test_1),
+	KUNIT_CASE(kunit_log_extend_test_2),
 	{}
 };
 
-- 
2.30.2

