Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C9D77B9D7
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 15:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjHNNXx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 09:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjHNNXg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 09:23:36 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059ED10D1;
        Mon, 14 Aug 2023 06:23:35 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37E5t3EL003856;
        Mon, 14 Aug 2023 08:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=al1pLuyWTCVVGzK5+zU3cBUCCTyiFzzFqmI5+hXtnNw=; b=
        jq6RE8GPt/gZFwo2FszmwZcwujQDej08hJbxiNS2vbPHwV9CPANAxGbMXLPyL6ny
        4BUe9fNyVVd6sGeoI34LnMw2UvWWfMjMGW9Qe6cRHCnV7dJTHV3thSNCEDe2IL2d
        pYbkl4U95QCFGrpHNmIIQMPnMk65pF5G+3Iu3ZvTqf1qaNy/4WeenEy/aE9l+NPy
        eIdbLp0htU99K9KOsXuj9pwZuMnXVkwy0cShPjlWYRL8ZAlu22SF94C6xWw9sn3f
        Dos9wwjrb/q2rz9UBMUCupagLwCwikI/XdFnF16WsG424wV5JHcLhjnwUSnF3q8D
        7cJsRB6YravXV3YbquzsQg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3se8kqt6x8-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 08:23:18 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 14 Aug
 2023 14:23:15 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Mon, 14 Aug 2023 14:23:15 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A4A2F15B4;
        Mon, 14 Aug 2023 13:23:14 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v4 07/10] kunit: string-stream: Decouple string_stream from kunit
Date:   Mon, 14 Aug 2023 14:23:06 +0100
Message-ID: <20230814132309.32641-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230814132309.32641-1-rf@opensource.cirrus.com>
References: <20230814132309.32641-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fVaEWIB1XCtvu2ogE4F64OV8yyuRQERN
X-Proofpoint-GUID: fVaEWIB1XCtvu2ogE4F64OV8yyuRQERN
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Re-work string_stream so that it is not tied to a struct kunit. This is
to allow using it for the log of struct kunit_suite.

Instead of resource-managing individual allocations the whole string_stream
object can be resource-managed as a single object:

    alloc_string_stream() API is unchanged and takes a pointer to a
    struct kunit but it now registers the returned string_stream object to
    be resource-managed.

    raw_alloc_string_stream() is a new function that allocates a
    bare string_stream without any association to a struct kunit.

    free_string_stream() is a new function that frees a resource-managed
    string_stream allocated by alloc_string_stream().

    raw_free_string_stream() is a new function that frees a non-managed
    string_stream allocated by raw_alloc_string_stream().

The confusing function string_stream_destroy() has been removed. This only
called string_stream_clear() but didn't free the struct string_stream.
Instead string_stream_clear() has been exported, and the new functions use
the more conventional naming of "free" as the opposite of "alloc".

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 lib/kunit/string-stream-test.c |  2 +-
 lib/kunit/string-stream.c      | 92 +++++++++++++++++++++++-----------
 lib/kunit/string-stream.h      | 12 ++++-
 lib/kunit/test.c               |  2 +-
 4 files changed, 77 insertions(+), 31 deletions(-)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 8a30bb7d5fb7..437aa4b3179d 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -200,7 +200,7 @@ static void string_stream_append_test(struct kunit *test)
 			   combined_content);
 
 	/* Append content of non-empty stream to empty stream */
-	string_stream_destroy(stream_1);
+	string_stream_clear(stream_1);
 
 	stream_1 = alloc_string_stream(test, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index eb673d3ea3bd..06104a729b45 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -13,30 +13,28 @@
 #include "string-stream.h"
 
 
-static struct string_stream_fragment *alloc_string_stream_fragment(
-		struct kunit *test, int len, gfp_t gfp)
+static struct string_stream_fragment *alloc_string_stream_fragment(int len, gfp_t gfp)
 {
 	struct string_stream_fragment *frag;
 
-	frag = kunit_kzalloc(test, sizeof(*frag), gfp);
+	frag = kzalloc(sizeof(*frag), gfp);
 	if (!frag)
 		return ERR_PTR(-ENOMEM);
 
-	frag->fragment = kunit_kmalloc(test, len, gfp);
+	frag->fragment = kmalloc(len, gfp);
 	if (!frag->fragment) {
-		kunit_kfree(test, frag);
+		kfree(frag);
 		return ERR_PTR(-ENOMEM);
 	}
 
 	return frag;
 }
 
-static void string_stream_fragment_destroy(struct kunit *test,
-					   struct string_stream_fragment *frag)
+static void string_stream_fragment_destroy(struct string_stream_fragment *frag)
 {
 	list_del(&frag->node);
-	kunit_kfree(test, frag->fragment);
-	kunit_kfree(test, frag);
+	kfree(frag->fragment);
+	kfree(frag);
 }
 
 int string_stream_vadd(struct string_stream *stream,
@@ -65,9 +63,7 @@ int string_stream_vadd(struct string_stream *stream,
 	/* Need space for null byte. */
 	buf_len++;
 
-	frag_container = alloc_string_stream_fragment(stream->test,
-						      buf_len,
-						      stream->gfp);
+	frag_container = alloc_string_stream_fragment(buf_len, stream->gfp);
 	if (IS_ERR(frag_container))
 		return PTR_ERR(frag_container);
 
@@ -102,7 +98,7 @@ int string_stream_add(struct string_stream *stream, const char *fmt, ...)
 	return result;
 }
 
-static void string_stream_clear(struct string_stream *stream)
+void string_stream_clear(struct string_stream *stream)
 {
 	struct string_stream_fragment *frag_container, *frag_container_safe;
 
@@ -111,16 +107,28 @@ static void string_stream_clear(struct string_stream *stream)
 				 frag_container_safe,
 				 &stream->fragments,
 				 node) {
-		string_stream_fragment_destroy(stream->test, frag_container);
+		string_stream_fragment_destroy(frag_container);
 	}
 	stream->length = 0;
 	spin_unlock(&stream->lock);
 }
 
+static void _string_stream_concatenate_to_buf(struct string_stream *stream,
+					      char *buf, size_t buf_len)
+{
+	struct string_stream_fragment *frag_container;
+
+	buf[0] = '\0';
+
+	spin_lock(&stream->lock);
+	list_for_each_entry(frag_container, &stream->fragments, node)
+		strlcat(buf, frag_container->fragment, buf_len);
+	spin_unlock(&stream->lock);
+}
+
 char *string_stream_get_string(struct kunit *test, struct string_stream *stream,
 			       gfp_t gfp)
 {
-	struct string_stream_fragment *frag_container;
 	size_t buf_len = stream->length + 1; /* +1 for null byte. */
 	char *buf;
 
@@ -128,10 +136,7 @@ char *string_stream_get_string(struct kunit *test, struct string_stream *stream,
 	if (!buf)
 		return NULL;
 
-	spin_lock(&stream->lock);
-	list_for_each_entry(frag_container, &stream->fragments, node)
-		strlcat(buf, frag_container->fragment, buf_len);
-	spin_unlock(&stream->lock);
+	_string_stream_concatenate_to_buf(stream, buf, buf_len);
 
 	return buf;
 }
@@ -139,13 +144,20 @@ char *string_stream_get_string(struct kunit *test, struct string_stream *stream,
 int string_stream_append(struct string_stream *stream,
 			 struct string_stream *other)
 {
-	const char *other_content;
+	size_t other_buf_len = other->length + 1; /* +1 for null byte. */
+	char *other_buf;
+	int ret;
 
-	other_content = string_stream_get_string(other->test, other, other->gfp);
-	if (!other_content)
+	other_buf = kmalloc(other_buf_len, GFP_KERNEL);
+	if (!other_buf)
 		return -ENOMEM;
 
-	return string_stream_add(stream, other_content);
+	_string_stream_concatenate_to_buf(other, other_buf, other_buf_len);
+
+	ret = string_stream_add(stream, other_buf);
+	kfree(other_buf);
+
+	return ret;
 }
 
 bool string_stream_is_empty(struct string_stream *stream)
@@ -153,23 +165,47 @@ bool string_stream_is_empty(struct string_stream *stream)
 	return list_empty(&stream->fragments);
 }
 
-struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
+void raw_free_string_stream(struct string_stream *stream)
+{
+	string_stream_clear(stream);
+	kfree(stream);
+}
+
+struct string_stream *raw_alloc_string_stream(gfp_t gfp)
 {
 	struct string_stream *stream;
 
-	stream = kunit_kzalloc(test, sizeof(*stream), gfp);
+	stream = kzalloc(sizeof(*stream), gfp);
 	if (!stream)
 		return ERR_PTR(-ENOMEM);
 
 	stream->gfp = gfp;
-	stream->test = test;
 	INIT_LIST_HEAD(&stream->fragments);
 	spin_lock_init(&stream->lock);
 
 	return stream;
 }
 
-void string_stream_destroy(struct string_stream *stream)
+struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
 {
-	string_stream_clear(stream);
+	struct string_stream *stream;
+
+	stream = raw_alloc_string_stream(gfp);
+	if (IS_ERR(stream))
+		return stream;
+
+	stream->test = test;
+
+	if (kunit_add_action_or_reset(test, (kunit_action_t *)raw_free_string_stream, stream) != 0)
+		return ERR_PTR(-ENOMEM);
+
+	return stream;
+}
+
+void free_string_stream(struct kunit *test, struct string_stream *stream)
+{
+	if (!stream)
+		return;
+
+	kunit_release_action(test, (kunit_action_t *)raw_free_string_stream, (void *)stream);
 }
diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
index 6b4a747881c5..fbeda486382a 100644
--- a/lib/kunit/string-stream.h
+++ b/lib/kunit/string-stream.h
@@ -23,14 +23,24 @@ struct string_stream {
 	struct list_head fragments;
 	/* length and fragments are protected by this lock */
 	spinlock_t lock;
+
+	/*
+	 * Pointer to kunit this stream is associated with, or NULL if
+	 * not associated with a kunit.
+	 */
 	struct kunit *test;
+
 	gfp_t gfp;
 	bool append_newlines;
 };
 
 struct kunit;
 
+struct string_stream *raw_alloc_string_stream(gfp_t gfp);
+void raw_free_string_stream(struct string_stream *stream);
+
 struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp);
+void free_string_stream(struct kunit *test, struct string_stream *stream);
 
 int __printf(2, 3) string_stream_add(struct string_stream *stream,
 				     const char *fmt, ...);
@@ -47,7 +57,7 @@ int string_stream_append(struct string_stream *stream,
 
 bool string_stream_is_empty(struct string_stream *stream);
 
-void string_stream_destroy(struct string_stream *stream);
+void string_stream_clear(struct string_stream *stream);
 
 static inline void string_stream_set_append_newlines(struct string_stream *stream,
 						     bool append_newlines)
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 520e15f49d0d..4b69d12dfc96 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -322,7 +322,7 @@ static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
 
 	kunit_print_string_stream(test, stream);
 
-	string_stream_destroy(stream);
+	free_string_stream(test, stream);
 }
 
 void __noreturn __kunit_abort(struct kunit *test)
-- 
2.30.2

