Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D579B7871A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 16:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjHXOdO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 10:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241687AbjHXOdH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 10:33:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B2B1BE;
        Thu, 24 Aug 2023 07:33:05 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37OBiqaS023544;
        Thu, 24 Aug 2023 09:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=1xjNlQgvMbIWeIoyxuN4ZVGso+6Qt57rOZWKNA9UCtM=; b=
        OZgHYql7BOQQi3Q0DXL2IkSaYkch4Wuw5h/BL+z3ZuGEoC97DBSUXcP8UyiK9gX8
        iqKUYjCnPwA4+8H4WBQRNMkcDRrqLaClfbQb/ejPPz+mGwwSNpPd7glH4rxdVyRN
        7kfftjjxT9oNjhd9+JsX+g/ETy0Syhzk+ov0d8woo1NhQu8tcromjpT9H+EN37a9
        CUeCieE7JMLQCHDkwY+4a0RGHrt3PDU+dwEtsXr/4BAaJj7U3h6KJovJAlJoI+Lr
        0LQShogoJmtw+OcjdDf21TX+r30y0xyKrzxodTRSJ+ERZnpg0eu1DSl+hYbS7PNL
        Pr+PZOkKYnmute8K9E0sJg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sp1w8geq3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 09:31:32 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 24 Aug
 2023 15:31:29 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Thu, 24 Aug 2023 15:31:29 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D2D6D357F;
        Thu, 24 Aug 2023 14:31:29 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v5 04/10] kunit: string-stream: Add cases for string_stream newline appending
Date:   Thu, 24 Aug 2023 15:31:23 +0100
Message-ID: <20230824143129.1957914-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230824143129.1957914-1-rf@opensource.cirrus.com>
References: <20230824143129.1957914-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7Inxc0YJarI-TwJ-TnaukUx1dNhyc6yp
X-Proofpoint-ORIG-GUID: 7Inxc0YJarI-TwJ-TnaukUx1dNhyc6yp
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
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

string_stream_append_auto_newline_test() tests appending the
content of one stream to another stream when the target stream
has newline appending enabled.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Changes since V4:
- string_stream_append_auto_newline_test() doesn't clear the destination
  stream_1 between the newline and no-newline case. This is just a
  simplification of the code.
  
- string_stream_no_auto_newline_test() uses the same set of test strings
  as string_stream_auto_newline_test().
---
 lib/kunit/string-stream-test.c | 93 ++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 2b761ba01835..2a9936db1b9f 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -32,6 +32,7 @@ static void string_stream_init_test(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
 	KUNIT_EXPECT_PTR_EQ(test, stream->test, test);
 	KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);
+	KUNIT_EXPECT_FALSE(test, stream->append_newlines);
 
 	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
 }
@@ -214,6 +215,45 @@ static void string_stream_append_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1), stream_2_content);
 }
 
+/* Appending the content of one string stream to one with auto-newlining. */
+static void string_stream_append_auto_newline_test(struct kunit *test)
+{
+	struct string_stream *stream_1, *stream_2;
+
+	/* Stream 1 has newline appending enabled */
+	stream_1 = alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
+	string_stream_set_append_newlines(stream_1, true);
+	KUNIT_EXPECT_TRUE(test, stream_1->append_newlines);
+
+	/* Stream 2 does not append newlines */
+	stream_2 = alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_2);
+
+	/* Appending a stream with a newline should not add another newline */
+	string_stream_add(stream_1, "Original string\n");
+	string_stream_add(stream_2, "Appended content\n");
+	string_stream_add(stream_2, "More stuff\n");
+	string_stream_append(stream_1, stream_2);
+	KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1),
+			   "Original string\nAppended content\nMore stuff\n");
+
+	string_stream_destroy(stream_2);
+	stream_2 = alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_2);
+
+	/*
+	 * Appending a stream without newline should add a final newline.
+	 * The appended string_stream is treated as a single string so newlines
+	 * should not be inserted between fragments.
+	 */
+	string_stream_add(stream_2, "Another");
+	string_stream_add(stream_2, "And again");
+	string_stream_append(stream_1, stream_2);
+	KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1),
+			   "Original string\nAppended content\nMore stuff\nAnotherAnd again\n");
+}
+
 /* Adding an empty string should not create a fragment. */
 static void string_stream_append_empty_string_test(struct kunit *test)
 {
@@ -237,12 +277,65 @@ static void string_stream_append_empty_string_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream), "Add this line");
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
+	 * Add some strings with and without newlines. All formatted newlines
+	 * should be preserved. It should not add any extra newlines.
+	 */
+	string_stream_add(stream, "One");
+	string_stream_add(stream, "Two\n");
+	string_stream_add(stream, "%s\n", "Three");
+	string_stream_add(stream, "%s", "Four\n");
+	string_stream_add(stream, "Five\n%s", "Six");
+	string_stream_add(stream, "Seven\n\n");
+	string_stream_add(stream, "Eight");
+	KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream),
+			   "OneTwo\nThree\nFour\nFive\nSixSeven\n\nEight");
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
+	KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream),
+			   "One\nTwo\nThree\nFour\nFive\nSix\nSeven\n\nEight\n");
+}
+
 static struct kunit_case string_stream_test_cases[] = {
 	KUNIT_CASE(string_stream_init_test),
 	KUNIT_CASE(string_stream_line_add_test),
 	KUNIT_CASE(string_stream_variable_length_line_test),
 	KUNIT_CASE(string_stream_append_test),
+	KUNIT_CASE(string_stream_append_auto_newline_test),
 	KUNIT_CASE(string_stream_append_empty_string_test),
+	KUNIT_CASE(string_stream_no_auto_newline_test),
+	KUNIT_CASE(string_stream_auto_newline_test),
 	{}
 };
 
-- 
2.30.2

