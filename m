Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C9E78ACB8
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 12:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjH1KmI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 06:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjH1Klj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 06:41:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9B0115;
        Mon, 28 Aug 2023 03:41:36 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37SABUG3018563;
        Mon, 28 Aug 2023 05:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=H7DBADs1tbBK945kUqOgdIIVn1T7TgWLx0folmF96bs=; b=
        YMDXLut+Umgxd/k1mBZS79uZsa8NRZbZBEyOMoQumoYanQC/9dm38PPG+OB0v0pc
        MzMLgrNL8VzULkTARflYDv5/fHmpAkie1/W8IEx5it5oTGbf7921m6fPR2af1fLN
        jXNeAOptZyR5ixvT+exc5fs8gq7ZksO70mtV3ezNG21fGzY81VeUEsFPXOD5JHMO
        xmd7AqRC96ub/0B1R4bITd4MvM3JlvLltLoPhg1jSJii3k6OK46snTQiwzU8QmWb
        AkEyNeCX8P3rcvkbUhD36+iXokI6otf5ydEHsYoga/tUcUJKhI4COgslE9I6uUm8
        YGJ25DfdAQSiVDeGiI5G8g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesya0ma-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 05:41:17 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 28 Aug
 2023 11:41:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 28 Aug 2023 11:41:12 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 67218357D;
        Mon, 28 Aug 2023 10:41:12 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v6 06/10] kunit: string-stream: Add kunit_alloc_string_stream()
Date:   Mon, 28 Aug 2023 11:41:07 +0100
Message-ID: <20230828104111.2394344-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230828104111.2394344-1-rf@opensource.cirrus.com>
References: <20230828104111.2394344-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -_qrISrWRIo-_EhaIhQ74xWoWGeQOBy4
X-Proofpoint-GUID: -_qrISrWRIo-_EhaIhQ74xWoWGeQOBy4
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add function kunit_alloc_string_stream() to do a resource-managed
allocation of a string stream, and corresponding
kunit_free_string_stream() to free the resource-managed stream.

This is preparing for decoupling the string_stream
implementation from struct kunit, to reduce the amount of code
churn when that happens. Currently:
 - kunit_alloc_string_stream() only calls alloc_string_stream().
 - kunit_free_string_stream() takes a struct kunit* which
   isn't used yet.

Callers of the old alloc_string_stream() and
string_stream_destroy() are all requesting a managed allocation
so have been changed to use the new functions.

alloc_string_stream() has been temporarily made static because
its current behavior has been replaced with
kunit_alloc_string_stream().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 lib/kunit/string-stream-test.c | 28 ++++++++++++++--------------
 lib/kunit/string-stream.c      | 12 +++++++++++-
 lib/kunit/string-stream.h      |  3 ++-
 lib/kunit/test.c               |  4 ++--
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index f117c4b7389b..46b18e940b73 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -25,7 +25,7 @@ static void string_stream_init_test(struct kunit *test)
 {
 	struct string_stream *stream;
 
-	stream = alloc_string_stream(test, GFP_KERNEL);
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
 
 	KUNIT_EXPECT_EQ(test, stream->length, 0);
@@ -48,7 +48,7 @@ static void string_stream_line_add_test(struct kunit *test)
 	size_t len, total_len;
 	int num_lines, i;
 
-	stream = alloc_string_stream(test, GFP_KERNEL);
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
 
 	/* Add series of sequence numbered lines */
@@ -104,7 +104,7 @@ static void string_stream_variable_length_line_test(struct kunit *test)
 	size_t offset, total_len;
 	int num_lines, i;
 
-	stream = alloc_string_stream(test, GFP_KERNEL);
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
 
 	/*
@@ -164,10 +164,10 @@ static void string_stream_append_test(struct kunit *test)
 	size_t combined_length;
 	int i;
 
-	stream_1 = alloc_string_stream(test, GFP_KERNEL);
+	stream_1 = kunit_alloc_string_stream(test, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
 
-	stream_2 = alloc_string_stream(test, GFP_KERNEL);
+	stream_2 = kunit_alloc_string_stream(test, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_2);
 
 	/* Append content of empty stream to empty stream */
@@ -207,9 +207,9 @@ static void string_stream_append_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1), combined_content);
 
 	/* Append content of non-empty stream to empty stream */
-	string_stream_destroy(stream_1);
+	kunit_free_string_stream(test, stream_1);
 
-	stream_1 = alloc_string_stream(test, GFP_KERNEL);
+	stream_1 = kunit_alloc_string_stream(test, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
 
 	string_stream_append(stream_1, stream_2);
@@ -222,13 +222,13 @@ static void string_stream_append_auto_newline_test(struct kunit *test)
 	struct string_stream *stream_1, *stream_2;
 
 	/* Stream 1 has newline appending enabled */
-	stream_1 = alloc_string_stream(test, GFP_KERNEL);
+	stream_1 = kunit_alloc_string_stream(test, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
 	string_stream_set_append_newlines(stream_1, true);
 	KUNIT_EXPECT_TRUE(test, stream_1->append_newlines);
 
 	/* Stream 2 does not append newlines */
-	stream_2 = alloc_string_stream(test, GFP_KERNEL);
+	stream_2 = kunit_alloc_string_stream(test, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_2);
 
 	/* Appending a stream with a newline should not add another newline */
@@ -239,8 +239,8 @@ static void string_stream_append_auto_newline_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1),
 			   "Original string\nAppended content\nMore stuff\n");
 
-	string_stream_destroy(stream_2);
-	stream_2 = alloc_string_stream(test, GFP_KERNEL);
+	kunit_free_string_stream(test, stream_2);
+	stream_2 = kunit_alloc_string_stream(test, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_2);
 
 	/*
@@ -261,7 +261,7 @@ static void string_stream_append_empty_string_test(struct kunit *test)
 	struct string_stream *stream;
 	int original_frag_count;
 
-	stream = alloc_string_stream(test, GFP_KERNEL);
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
 
 	/* Formatted empty string */
@@ -283,7 +283,7 @@ static void string_stream_no_auto_newline_test(struct kunit *test)
 {
 	struct string_stream *stream;
 
-	stream = alloc_string_stream(test, GFP_KERNEL);
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
 
 	/*
@@ -306,7 +306,7 @@ static void string_stream_auto_newline_test(struct kunit *test)
 {
 	struct string_stream *stream;
 
-	stream = alloc_string_stream(test, GFP_KERNEL);
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
 
 	string_stream_set_append_newlines(stream, true);
diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index 1dcf6513b692..12ecf15e1f6b 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -153,7 +153,7 @@ bool string_stream_is_empty(struct string_stream *stream)
 	return list_empty(&stream->fragments);
 }
 
-struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
+static struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
 {
 	struct string_stream *stream;
 
@@ -173,3 +173,13 @@ void string_stream_destroy(struct string_stream *stream)
 {
 	string_stream_clear(stream);
 }
+
+struct string_stream *kunit_alloc_string_stream(struct kunit *test, gfp_t gfp)
+{
+	return alloc_string_stream(test, gfp);
+}
+
+void kunit_free_string_stream(struct kunit *test, struct string_stream *stream)
+{
+	string_stream_destroy(stream);
+}
diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
index 048930bf97f0..3e70ee9d66e9 100644
--- a/lib/kunit/string-stream.h
+++ b/lib/kunit/string-stream.h
@@ -30,7 +30,8 @@ struct string_stream {
 
 struct kunit;
 
-struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp);
+struct string_stream *kunit_alloc_string_stream(struct kunit *test, gfp_t gfp);
+void kunit_free_string_stream(struct kunit *test, struct string_stream *stream);
 
 int __printf(2, 3) string_stream_add(struct string_stream *stream,
 				     const char *fmt, ...);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 49698a168437..93d9225d61e3 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -308,7 +308,7 @@ static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
 
 	kunit_set_failure(test);
 
-	stream = alloc_string_stream(test, GFP_KERNEL);
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
 	if (IS_ERR(stream)) {
 		WARN(true,
 		     "Could not allocate stream to print failed assertion in %s:%d\n",
@@ -322,7 +322,7 @@ static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
 
 	kunit_print_string_stream(test, stream);
 
-	string_stream_destroy(stream);
+	kunit_free_string_stream(test, stream);
 }
 
 void __noreturn __kunit_abort(struct kunit *test)
-- 
2.30.2

