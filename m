Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B45777B9DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 15:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjHNNXy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 09:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjHNNXi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 09:23:38 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D84E7D;
        Mon, 14 Aug 2023 06:23:37 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37E5t3EK003856;
        Mon, 14 Aug 2023 08:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=F1ndINnqWJNhTR4PfySXa0GVhkrYpQz+Jc3VDxBD5+o=; b=
        BqWkpUENNp3km6myrhPYoRR4IheJ5nk2iv2Ca3a8nN4NBXCNIMB0g2hqGWiIHiJC
        enqNnKvjMMsfdP5oaOo0GyZbA8bnvlqVgPr5B8T4f9ZhZWs8ZIqrnM67tzBWAYzb
        0s708uoKAoDJZeP1/wgH2V/hWvJHjC15nj32A5pPAVL/n6gYFwunxafZmQXR0UZf
        ztIxW5Ol9Kg/f+qC03wrilVspM46CsufOL5aNU+lIsx+dN2/8OKS5hl+ESzwaVwy
        MlFK95Kp4POYwUn7YnKYSscZYeb0tmf02gT/svfadyY8X7U+DzBDZvwnzxDWCY2S
        4XcHgL5VUUv56qOF8cFjfQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3se8kqt6x8-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 08:23:17 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 14 Aug
 2023 14:23:14 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Mon, 14 Aug 2023 14:23:14 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CBAE015B4;
        Mon, 14 Aug 2023 13:23:13 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v4 05/10] kunit: string-stream: Add cases for string_stream newline appending
Date:   Mon, 14 Aug 2023 14:23:04 +0100
Message-ID: <20230814132309.32641-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230814132309.32641-1-rf@opensource.cirrus.com>
References: <20230814132309.32641-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ovUZCUgveNTCqVnlqSXBVGMQLRW0mkFD
X-Proofpoint-GUID: ovUZCUgveNTCqVnlqSXBVGMQLRW0mkFD
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add test cases for testing the string_stream feature that appends a
newline to strings that do not already end with a newline.

string_stream_no_auto_newline_test() tests with this feature disabled.
Newlines should not be added or dropped.

string_stream_auto_newline_test() tests with this feature enabled.
Newlines should be added to lines that do not end with a newline.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 lib/kunit/string-stream-test.c | 51 ++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index efe13e3322b5..46c2ac162fe8 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -23,6 +23,7 @@ static void string_stream_init_test(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
 	KUNIT_EXPECT_PTR_EQ(test, stream->test, test);
 	KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);
+	KUNIT_EXPECT_FALSE(test, stream->append_newlines);
 
 	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
 }
@@ -226,12 +227,62 @@ static void string_stream_append_empty_string_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream), "Add this line");
 }
 
+/* Adding strings without automatic newline appending */
+static void string_stream_no_auto_newline_test(struct kunit *test)
+{
+	struct string_stream *stream;
+
+	stream = alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	/*
+	 * Add some strings with and without newlines. All formatted
+	 * newlines should be preserved. No extra newlines should be
+	 * added.
+	 */
+	string_stream_add(stream, "One");
+	string_stream_add(stream, "Two\n");
+	string_stream_add(stream, "%s\n", "Three");
+	string_stream_add(stream, "Four");
+	KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream),
+			   "OneTwo\nThree\nFour");
+}
+
+/* Adding strings with automatic newline appending */
+static void string_stream_auto_newline_test(struct kunit *test)
+{
+	struct string_stream *stream;
+
+	stream = alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	string_stream_set_append_newlines(stream, true);
+	KUNIT_EXPECT_TRUE(test, stream->append_newlines);
+
+	/*
+	 * Add some strings with and without newlines. Newlines should
+	 * be appended to lines that do not end with \n, but newlines
+	 * resulting from the formatting should not be changed.
+	 */
+	string_stream_add(stream, "One");
+	string_stream_add(stream, "Two\n");
+	string_stream_add(stream, "%s\n", "Three");
+	string_stream_add(stream, "%s", "Four\n");
+	string_stream_add(stream, "Five\n%s", "Six");
+	string_stream_add(stream, "Seven\n\n");
+	string_stream_add(stream, "Eight");
+	KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream),
+			   "One\nTwo\nThree\nFour\nFive\nSix\nSeven\n\nEight\n");
+}
+
 static struct kunit_case string_stream_test_cases[] = {
 	KUNIT_CASE(string_stream_init_test),
 	KUNIT_CASE(string_stream_line_add_test),
 	KUNIT_CASE(string_stream_variable_length_line_test),
 	KUNIT_CASE(string_stream_append_test),
 	KUNIT_CASE(string_stream_append_empty_string_test),
+	KUNIT_CASE(string_stream_no_auto_newline_test),
+	KUNIT_CASE(string_stream_auto_newline_test),
 	{}
 };
 
-- 
2.30.2

