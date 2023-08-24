Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D99F787191
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 16:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbjHXOcm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 10:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241635AbjHXOcU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 10:32:20 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD8C1BC9;
        Thu, 24 Aug 2023 07:32:13 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37O7iEx6023063;
        Thu, 24 Aug 2023 09:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=Mm7Qgx8NLVcI+3NteRZk714t1FUGRt8tS4eobqjnGY0=; b=
        OxMNSNnWwWvDEzEyOxR4kEpNGWlZWaGsvEUOzoqXDBr/4OgnbBfyQ+57651axq8B
        ycIjKOnAB+6L0/WAzayDCiFJ0Y4Yuf0zmPg93i3MgjmS+3TY+sRdCDkEUZ7UwBHc
        +dHtrvNUyY02khsAa4XaiyQwdQa1BwYY9+WwncSyCWn+EBglnKqdKWFzxka3qa43
        CZyVOWRKrDaN6Y/m70eekfhgXLppVEo7EtqiKo3pETBJTvDHFfPGXIxvodS0tQBZ
        8rUZVYDGz61j8S6nCjHnc5iDo19YIwj64AWl+vdgG2TGBKU7zGS1jX0vByOb/Nhk
        cPjz7IvI5EWxpHPq4aMGjQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sp1rbghkk-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 09:31:33 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 24 Aug
 2023 15:31:29 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Thu, 24 Aug 2023 15:31:29 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B332D357C;
        Thu, 24 Aug 2023 14:31:29 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v5 02/10] kunit: string-stream: Improve testing of string_stream
Date:   Thu, 24 Aug 2023 15:31:21 +0100
Message-ID: <20230824143129.1957914-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230824143129.1957914-1-rf@opensource.cirrus.com>
References: <20230824143129.1957914-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KbBgKkLvzv9tWHjJYETbEXuaHSvtzrVJ
X-Proofpoint-GUID: KbBgKkLvzv9tWHjJYETbEXuaHSvtzrVJ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace the minimal tests with more-thorough testing.

string_stream_init_test() tests that struct string_stream is
initialized correctly.

string_stream_line_add_test() adds a series of numbered lines and
checks that the resulting string contains all the lines.

string_stream_variable_length_line_test() adds a large number of
lines of varying length to create many fragments, then tests that all
lines are present.

string_stream_append_test() tests various cases of using
string_stream_append() to append the content of one stream to another.

Adds string_stream_append_empty_string_test() to test that adding an
empty string to a string_stream doesn't create a new empty fragment.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Changes since V4:
- Test cases for appending empty strings have been squashed into this
  patch.
- Call to string_stream_get_string() is wrapped in a local function
  get_concatenated_string(). This is to avoid a lot of code churn later
  when string_stream_get_string() is changed to return an unmanaged buffer.
---
 lib/kunit/string-stream-test.c | 232 ++++++++++++++++++++++++++++++---
 1 file changed, 216 insertions(+), 16 deletions(-)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 110f3a993250..2b761ba01835 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -11,38 +11,238 @@
 
 #include "string-stream.h"
 
-static void string_stream_test_empty_on_creation(struct kunit *test)
+static char *get_concatenated_string(struct kunit *test, struct string_stream *stream)
 {
-	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
+	char *str = string_stream_get_string(stream);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
+
+	return str;
+}
+
+/* string_stream object is initialized correctly. */
+static void string_stream_init_test(struct kunit *test)
+{
+	struct string_stream *stream;
+
+	stream = alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	KUNIT_EXPECT_EQ(test, stream->length, 0);
+	KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
+	KUNIT_EXPECT_PTR_EQ(test, stream->test, test);
+	KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);
 
 	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
 }
 
-static void string_stream_test_not_empty_after_add(struct kunit *test)
+/*
+ * Add a series of lines to a string_stream. Check that all lines
+ * appear in the correct order and no characters are dropped.
+ */
+static void string_stream_line_add_test(struct kunit *test)
 {
-	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
+	struct string_stream *stream;
+	char line[60];
+	char *concat_string, *pos, *string_end;
+	size_t len, total_len;
+	int num_lines, i;
 
-	string_stream_add(stream, "Foo");
+	stream = alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
 
-	KUNIT_EXPECT_FALSE(test, string_stream_is_empty(stream));
+	/* Add series of sequence numbered lines */
+	total_len = 0;
+	for (i = 0; i < 100; ++i) {
+		len = snprintf(line, sizeof(line),
+			"The quick brown fox jumps over the lazy penguin %d\n", i);
+
+		/* Sanity-check that our test string isn't truncated */
+		KUNIT_ASSERT_LT(test, len, sizeof(line));
+
+		string_stream_add(stream, line);
+		total_len += len;
+	}
+	num_lines = i;
+
+	concat_string = get_concatenated_string(test, stream);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, concat_string);
+	KUNIT_EXPECT_EQ(test, strlen(concat_string), total_len);
+
+	/*
+	 * Split the concatenated string at the newlines and check that
+	 * all the original added strings are present.
+	 */
+	pos = concat_string;
+	for (i = 0; i < num_lines; ++i) {
+		string_end = strchr(pos, '\n');
+		KUNIT_EXPECT_NOT_NULL(test, string_end);
+
+		/* Convert to NULL-terminated string */
+		*string_end = '\0';
+
+		snprintf(line, sizeof(line),
+			 "The quick brown fox jumps over the lazy penguin %d", i);
+		KUNIT_EXPECT_STREQ(test, pos, line);
+
+		pos = string_end + 1;
+	}
+
+	/* There shouldn't be any more data after this */
+	KUNIT_EXPECT_EQ(test, strlen(pos), 0);
 }
 
-static void string_stream_test_get_string(struct kunit *test)
+/* Add a series of lines of variable length to a string_stream. */
+static void string_stream_variable_length_line_test(struct kunit *test)
 {
-	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
-	char *output;
+	static const char line[] =
+		"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
+		" 0123456789!$%^&*()_-+={}[]:;@'~#<>,.?/|";
+	struct string_stream *stream;
+	struct rnd_state rnd;
+	char *concat_string, *pos, *string_end;
+	size_t offset, total_len;
+	int num_lines, i;
 
-	string_stream_add(stream, "Foo");
-	string_stream_add(stream, " %s", "bar");
+	stream = alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
 
-	output = string_stream_get_string(stream);
-	KUNIT_ASSERT_STREQ(test, output, "Foo bar");
+	/*
+	 * Log many lines of varying lengths until we have created
+	 * many fragments.
+	 * The "randomness" must be repeatable.
+	 */
+	prandom_seed_state(&rnd, 3141592653589793238ULL);
+	total_len = 0;
+	for (i = 0; i < 100; ++i) {
+		offset = prandom_u32_state(&rnd) % (sizeof(line) - 1);
+		string_stream_add(stream, "%s\n", &line[offset]);
+		total_len += sizeof(line) - offset;
+	}
+	num_lines = i;
+
+	concat_string = get_concatenated_string(test, stream);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, concat_string);
+	KUNIT_EXPECT_EQ(test, strlen(concat_string), total_len);
+
+	/*
+	 * Split the concatenated string at the newlines and check that
+	 * all the original added strings are present.
+	 */
+	prandom_seed_state(&rnd, 3141592653589793238ULL);
+	pos = concat_string;
+	for (i = 0; i < num_lines; ++i) {
+		string_end = strchr(pos, '\n');
+		KUNIT_EXPECT_NOT_NULL(test, string_end);
+
+		/* Convert to NULL-terminated string */
+		*string_end = '\0';
+
+		offset = prandom_u32_state(&rnd) % (sizeof(line) - 1);
+		KUNIT_EXPECT_STREQ(test, pos, &line[offset]);
+
+		pos = string_end + 1;
+	}
+
+	/* There shouldn't be any more data after this */
+	KUNIT_EXPECT_EQ(test, strlen(pos), 0);
+}
+
+/* Appending the content of one string stream to another. */
+static void string_stream_append_test(struct kunit *test)
+{
+	static const char * const strings_1[] = {
+		"one", "two", "three", "four", "five", "six",
+		"seven", "eight", "nine", "ten",
+	};
+	static const char * const strings_2[] = {
+		"Apple", "Pear", "Orange", "Banana", "Grape", "Apricot",
+	};
+	struct string_stream *stream_1, *stream_2;
+	const char *original_content, *stream_2_content;
+	char *combined_content;
+	size_t combined_length;
+	int i;
+
+	stream_1 = alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
+
+	stream_2 = alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_2);
+
+	/* Append content of empty stream to empty stream */
+	string_stream_append(stream_1, stream_2);
+	KUNIT_EXPECT_EQ(test, strlen(get_concatenated_string(test, stream_1)), 0);
+
+	/* Add some data to stream_1 */
+	for (i = 0; i < ARRAY_SIZE(strings_1); ++i)
+		string_stream_add(stream_1, "%s\n", strings_1[i]);
+
+	original_content = get_concatenated_string(test, stream_1);
+
+	/* Append content of empty stream to non-empty stream */
+	string_stream_append(stream_1, stream_2);
+	KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1), original_content);
+
+	/* Add some data to stream_2 */
+	for (i = 0; i < ARRAY_SIZE(strings_2); ++i)
+		string_stream_add(stream_2, "%s\n", strings_2[i]);
+
+	/* Append content of non-empty stream to non-empty stream */
+	string_stream_append(stream_1, stream_2);
+
+	/*
+	 * End result should be the original content of stream_1 plus
+	 * the content of stream_2.
+	 */
+	stream_2_content = get_concatenated_string(test, stream_2);
+	combined_length = strlen(original_content) + strlen(stream_2_content);
+	combined_length++; /* for terminating \0 */
+	combined_content = kunit_kmalloc(test, combined_length, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, combined_content);
+	snprintf(combined_content, combined_length, "%s%s", original_content, stream_2_content);
+
+	KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1), combined_content);
+
+	/* Append content of non-empty stream to empty stream */
+	string_stream_destroy(stream_1);
+
+	stream_1 = alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
+
+	string_stream_append(stream_1, stream_2);
+	KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1), stream_2_content);
+}
+
+/* Adding an empty string should not create a fragment. */
+static void string_stream_append_empty_string_test(struct kunit *test)
+{
+	struct string_stream *stream;
+	int original_frag_count;
+
+	stream = alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	/* Formatted empty string */
+	string_stream_add(stream, "%s", "");
+	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
+	KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
+
+	/* Adding an empty string to a non-empty stream */
+	string_stream_add(stream, "Add this line");
+	original_frag_count = list_count_nodes(&stream->fragments);
+
+	string_stream_add(stream, "%s", "");
+	KUNIT_EXPECT_EQ(test, list_count_nodes(&stream->fragments), original_frag_count);
+	KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream), "Add this line");
 }
 
 static struct kunit_case string_stream_test_cases[] = {
-	KUNIT_CASE(string_stream_test_empty_on_creation),
-	KUNIT_CASE(string_stream_test_not_empty_after_add),
-	KUNIT_CASE(string_stream_test_get_string),
+	KUNIT_CASE(string_stream_init_test),
+	KUNIT_CASE(string_stream_line_add_test),
+	KUNIT_CASE(string_stream_variable_length_line_test),
+	KUNIT_CASE(string_stream_append_test),
+	KUNIT_CASE(string_stream_append_empty_string_test),
 	{}
 };
 
-- 
2.30.2

