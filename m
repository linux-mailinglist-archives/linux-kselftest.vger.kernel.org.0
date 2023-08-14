Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559B077B9D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 15:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjHNNXv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 09:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjHNNXg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 09:23:36 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1324F10C8;
        Mon, 14 Aug 2023 06:23:34 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37E6GnC9000669;
        Mon, 14 Aug 2023 08:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=frY2tHP5jPWkeecF6fp4ApId5IiopIw1YuzZvmkax+w=; b=
        h5MUDuabgjazR/dTBJRqxWN1fGJM7vCCs4AtFhqNBKembGI2AGkGFI1IHvTI+Shi
        nvhye5KRwoUPmWnujvRnwcK9pXFGQxqoeFTiZChch9VcQx3kpNxTLQke6TQq2Oxk
        rydufnoLMx/QNslCpmInlvEpY8psrl+8PjbVD2ixAX6XYtYy7ur9nk2q/guX59Ss
        KlSZK+7HgHsTbjkU/y7Mt2zqtH8d+Eh4ySI0+vjcweSN16TCUoQ71yEPMgk+D9P5
        Oi2aRi7mVsMPUtf/OsTfTshxBmgOnE7dkkX1E9cic2eN8rk2Zl+UuOWKadH/cgvH
        yRsgum83G9tme2TGjEaLcw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3se8kqt6xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 08:23:16 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 14 Aug
 2023 14:23:14 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Mon, 14 Aug 2023 14:23:14 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3E2B9458;
        Mon, 14 Aug 2023 13:23:14 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v4 06/10] kunit: string-stream: Pass struct kunit to string_stream_get_string()
Date:   Mon, 14 Aug 2023 14:23:05 +0100
Message-ID: <20230814132309.32641-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230814132309.32641-1-rf@opensource.cirrus.com>
References: <20230814132309.32641-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RR3FX80xx5g7cOMUOdquvm7NZfTJYnA4
X-Proofpoint-GUID: RR3FX80xx5g7cOMUOdquvm7NZfTJYnA4
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Pass a struct kunit* and gfp_t to string_stream_get_string(). Allocate
the returned buffer using these instead of using the stream->test and
stream->gfp.

This is preparation for removing the dependence of string_stream on
struct kunit, so that string_stream can be used for the debugfs log.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 lib/kunit/string-stream-test.c | 26 +++++++++++++++-----------
 lib/kunit/string-stream.c      |  8 ++++----
 lib/kunit/string-stream.h      |  3 ++-
 lib/kunit/test.c               |  2 +-
 4 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 46c2ac162fe8..8a30bb7d5fb7 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -57,7 +57,7 @@ static void string_stream_line_add_test(struct kunit *test)
 	}
 	num_lines = i;
 
-	concat_string = string_stream_get_string(stream);
+	concat_string = string_stream_get_string(test, stream, GFP_KERNEL);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, concat_string);
 	KUNIT_EXPECT_EQ(test, strlen(concat_string), total_len);
 
@@ -113,7 +113,7 @@ static void string_stream_variable_length_line_test(struct kunit *test)
 	}
 	num_lines = i;
 
-	concat_string = string_stream_get_string(stream);
+	concat_string = string_stream_get_string(test, stream, GFP_KERNEL);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, concat_string);
 	KUNIT_EXPECT_EQ(test, strlen(concat_string), total_len);
 
@@ -165,17 +165,18 @@ static void string_stream_append_test(struct kunit *test)
 
 	/* Append content of empty stream to empty stream */
 	string_stream_append(stream_1, stream_2);
-	KUNIT_EXPECT_EQ(test, strlen(string_stream_get_string(stream_1)), 0);
+	KUNIT_EXPECT_EQ(test, strlen(string_stream_get_string(test, stream_1, GFP_KERNEL)), 0);
 
 	/* Add some data to stream_1 */
 	for (i = 0; i < ARRAY_SIZE(strings_1); ++i)
 		string_stream_add(stream_1, "%s\n", strings_1[i]);
 
-	original_content = string_stream_get_string(stream_1);
+	original_content = string_stream_get_string(test, stream_1, GFP_KERNEL);
 
 	/* Append content of empty stream to non-empty stream */
 	string_stream_append(stream_1, stream_2);
-	KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream_1), original_content);
+	KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream_1, GFP_KERNEL),
+			   original_content);
 
 	/* Add some data to stream_2 */
 	for (i = 0; i < ARRAY_SIZE(strings_2); ++i)
@@ -188,14 +189,15 @@ static void string_stream_append_test(struct kunit *test)
 	 * End result should be the original content of stream_1 plus
 	 * the content of stream_2.
 	 */
-	stream_2_content = string_stream_get_string(stream_2);
+	stream_2_content = string_stream_get_string(test, stream_2, GFP_KERNEL);
 	combined_length = strlen(original_content) + strlen(stream_2_content);
 	combined_length++; /* for terminating \0 */
 	combined_content = kunit_kmalloc(test, combined_length, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, combined_content);
 	snprintf(combined_content, combined_length, "%s%s", original_content, stream_2_content);
 
-	KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream_1), combined_content);
+	KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream_1, GFP_KERNEL),
+			   combined_content);
 
 	/* Append content of non-empty stream to empty stream */
 	string_stream_destroy(stream_1);
@@ -204,7 +206,8 @@ static void string_stream_append_test(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
 
 	string_stream_append(stream_1, stream_2);
-	KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream_1), stream_2_content);
+	KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream_1, GFP_KERNEL),
+			   stream_2_content);
 }
 
 /* Adding an empty string should not create a fragment. */
@@ -224,7 +227,8 @@ static void string_stream_append_empty_string_test(struct kunit *test)
 	string_stream_add(stream, "Add this line");
 	string_stream_add(stream, "%s", "");
 	KUNIT_EXPECT_EQ(test, list_count_nodes(&stream->fragments), 1);
-	KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream), "Add this line");
+	KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream, GFP_KERNEL),
+			   "Add this line");
 }
 
 /* Adding strings without automatic newline appending */
@@ -244,7 +248,7 @@ static void string_stream_no_auto_newline_test(struct kunit *test)
 	string_stream_add(stream, "Two\n");
 	string_stream_add(stream, "%s\n", "Three");
 	string_stream_add(stream, "Four");
-	KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream),
+	KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream, GFP_KERNEL),
 			   "OneTwo\nThree\nFour");
 }
 
@@ -271,7 +275,7 @@ static void string_stream_auto_newline_test(struct kunit *test)
 	string_stream_add(stream, "Five\n%s", "Six");
 	string_stream_add(stream, "Seven\n\n");
 	string_stream_add(stream, "Eight");
-	KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream),
+	KUNIT_EXPECT_STREQ(test, string_stream_get_string(test, stream, GFP_KERNEL),
 			   "One\nTwo\nThree\nFour\nFive\nSix\nSeven\n\nEight\n");
 }
 
diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index 1dcf6513b692..eb673d3ea3bd 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -117,13 +117,14 @@ static void string_stream_clear(struct string_stream *stream)
 	spin_unlock(&stream->lock);
 }
 
-char *string_stream_get_string(struct string_stream *stream)
+char *string_stream_get_string(struct kunit *test, struct string_stream *stream,
+			       gfp_t gfp)
 {
 	struct string_stream_fragment *frag_container;
 	size_t buf_len = stream->length + 1; /* +1 for null byte. */
 	char *buf;
 
-	buf = kunit_kzalloc(stream->test, buf_len, stream->gfp);
+	buf = kunit_kzalloc(test, buf_len, gfp);
 	if (!buf)
 		return NULL;
 
@@ -140,8 +141,7 @@ int string_stream_append(struct string_stream *stream,
 {
 	const char *other_content;
 
-	other_content = string_stream_get_string(other);
-
+	other_content = string_stream_get_string(other->test, other, other->gfp);
 	if (!other_content)
 		return -ENOMEM;
 
diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
index 048930bf97f0..6b4a747881c5 100644
--- a/lib/kunit/string-stream.h
+++ b/lib/kunit/string-stream.h
@@ -39,7 +39,8 @@ int __printf(2, 0) string_stream_vadd(struct string_stream *stream,
 				      const char *fmt,
 				      va_list args);
 
-char *string_stream_get_string(struct string_stream *stream);
+char *string_stream_get_string(struct kunit *test, struct string_stream *stream,
+			       gfp_t gfp);
 
 int string_stream_append(struct string_stream *stream,
 			 struct string_stream *other);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 49698a168437..520e15f49d0d 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -286,7 +286,7 @@ static void kunit_print_string_stream(struct kunit *test,
 	if (string_stream_is_empty(stream))
 		return;
 
-	buf = string_stream_get_string(stream);
+	buf = string_stream_get_string(test, stream, GFP_KERNEL);
 	if (!buf) {
 		kunit_err(test,
 			  "Could not allocate buffer, dumping stream:\n");
-- 
2.30.2

