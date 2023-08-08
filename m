Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE64C773CC2
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjHHQJb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjHHQHa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:07:30 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A8D7694;
        Tue,  8 Aug 2023 08:46:09 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 378CIdoP005342;
        Tue, 8 Aug 2023 07:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=+4e/xqTw8lqmf/V+eCtyHeNZMgbrGjTO2UMnqK+W1hQ=; b=
        nDUc3qF/yME8qTvJXN3/kKjZl2M6EyhFLQ6s4GP9LRluQdqwkZ/YXgzqJk9Op+xe
        WfrhCaX+QuKtAGnLYnRqJgC0p+Z781A580+sqcKejX6kb4kCRDchi+c965GPjz4F
        HLdzcatRfafU9QEeS0ULkgI/zoU7Y/5AtedDVwWh+Z8btT3qZWaI7w5KLXpIlQi0
        LGru0xPBfkdYPMT7VLOETP13X9lAHG7N8JReJsq9ra7LyjS08Z7JPxEwfMVi1B/9
        9RCvuX6rW4zUJ+8eUUiu+PnFB/KheAhP+GDLglZv0Bog5Rf20p9fH2A1aurSNzWU
        fQW/JJjzD7pO73CHXdfyVw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhtjv4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 07:35:34 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 13:35:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 8 Aug 2023 13:35:32 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 92E8B15B7;
        Tue,  8 Aug 2023 12:35:32 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 2/6] kunit: kunit-test: Add test cases for extending log buffer
Date:   Tue, 8 Aug 2023 13:35:25 +0100
Message-ID: <20230808123529.4725-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230808123529.4725-1-rf@opensource.cirrus.com>
References: <20230808123529.4725-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EPww4PnPDzjn6O5PameaDZYxTpJvY-lx
X-Proofpoint-ORIG-GUID: EPww4PnPDzjn6O5PameaDZYxTpJvY-lx
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

kunit_log_extend_test_1() logs a series of numbered lines then tests
that the resulting log contains all the lines.

kunit_log_extend_test_2() logs a large number of lines of varying length
to create many fragments, then tests that all lines are present.

kunit_log_frag_sized_line_test() logs a line that exactly fills a
fragment. This should not cause an extension of the log or truncation
of the line.

kunit_log_newline_test() has a new test to append a line that is exactly
the length of the available space in the current fragment and check that
the resulting log has a trailing '\n'.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 lib/kunit/kunit-test.c | 204 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 204 insertions(+)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 54dc011c8980..48967d12e053 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -7,6 +7,7 @@
  */
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
+#include <linux/prandom.h>
 
 #include "try-catch-impl.h"
 
@@ -530,6 +531,31 @@ static struct kunit_suite kunit_resource_test_suite = {
 	.test_cases = kunit_resource_test_cases,
 };
 
+static char *get_concatenated_log(struct kunit *test, const struct list_head *log,
+				  int *num_frags)
+{
+	struct kunit_log_frag *frag;
+	size_t len = 0;
+	int frag_count = 0;
+	char *p;
+
+	list_for_each_entry(frag, log, list)
+		len += strlen(frag->buf);
+
+	len++; /* for terminating '\0' */
+	p = kunit_kmalloc(test, len, GFP_KERNEL);
+
+	list_for_each_entry(frag, log, list) {
+		strlcat(p, frag->buf, len);
+		++frag_count;
+	}
+
+	if (num_frags)
+		*num_frags = frag_count;
+
+	return p;
+}
+
 static void kunit_log_test(struct kunit *test)
 {
 	struct kunit_suite suite;
@@ -568,7 +594,9 @@ static void kunit_log_test(struct kunit *test)
 
 static void kunit_log_newline_test(struct kunit *test)
 {
+	struct kunit_suite suite;
 	struct kunit_log_frag *frag;
+	char *p;
 
 	kunit_info(test, "Add newline\n");
 	if (test->log) {
@@ -576,14 +604,190 @@ static void kunit_log_newline_test(struct kunit *test)
 		KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(frag->buf, "Add newline\n"),
 			"Missing log line, full log:\n%s", frag->buf);
 		KUNIT_EXPECT_NULL(test, strstr(frag->buf, "Add newline\n\n"));
+
+		suite.log = kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
+		INIT_LIST_HEAD(suite.log);
+		frag = kunit_kmalloc(test, sizeof(*frag), GFP_KERNEL);
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
+	frag = kunit_kmalloc(test, sizeof(*frag), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
+	kunit_init_log_frag(frag);
+	KUNIT_EXPECT_EQ(test, frag->buf[0], '\0');
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
+	frag = kunit_kmalloc(test, sizeof(*frag), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
+	kunit_init_log_frag(frag);
+	KUNIT_EXPECT_EQ(test, frag->buf[0], '\0');
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
+static void kunit_log_frag_sized_line_test(struct kunit *test)
+{
+#ifdef CONFIG_KUNIT_DEBUGFS
+	struct kunit_suite suite;
+	struct kunit_log_frag *frag, *src;
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
+#else
+	kunit_skip(test, "only useful when debugfs is enabled");
+#endif
+}
+
 static struct kunit_case kunit_log_test_cases[] = {
 	KUNIT_CASE(kunit_log_test),
 	KUNIT_CASE(kunit_log_newline_test),
+	KUNIT_CASE(kunit_log_extend_test_1),
+	KUNIT_CASE(kunit_log_extend_test_2),
+	KUNIT_CASE(kunit_log_frag_sized_line_test),
 	{}
 };
 
-- 
2.30.2

