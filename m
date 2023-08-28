Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1337A78AC9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 12:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjH1Klb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 06:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjH1Kla (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 06:41:30 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670EA125;
        Mon, 28 Aug 2023 03:41:27 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37SABuZ7031648;
        Mon, 28 Aug 2023 05:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=9OtwqOhPZr8PO9U1ma88NU4k5foCF9o7cBA7JnYYFTc=; b=
        R+1ihIbNSq6IQlcbt9LCgrW+x5/Pv5UGA2OIsYq0wlAjVhfzJizrUFLXkb39ZeNr
        UGsQn8eX27wVbb5GWZucKDqiRpdqF5vdn+Lz6F6BUVmqt4Yc24Ma/sdSv9sp/FTo
        YFwSe2gnbtlX/xN1T++8HLp0qM+b8IB6Pd/kCBwhDV7Xa8wX3BGLaDvyo6injJUc
        YKsavAUUhq22iqvPN71EiTe+alrGcHqq668WPsDE6nChuwqVcpqaE7n2yDMi1egZ
        RPT5F59AoPHH/a5HT+31fhO19bhO9V7zlRaSTuZzYXX7RpbKqEDpjaZPXtktQDsl
        i8H4LP8cjkSfrTVT7Jrg5A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sqdtj1my9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 05:41:15 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 28 Aug
 2023 11:41:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 28 Aug 2023 11:41:12 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 804B246B;
        Mon, 28 Aug 2023 10:41:12 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v6 07/10] kunit: string-stream: Decouple string_stream from kunit
Date:   Mon, 28 Aug 2023 11:41:08 +0100
Message-ID: <20230828104111.2394344-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230828104111.2394344-1-rf@opensource.cirrus.com>
References: <20230828104111.2394344-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rOnsPD4nr-9qwruXVjMgJTexQSKxy9H1
X-Proofpoint-GUID: rOnsPD4nr-9qwruXVjMgJTexQSKxy9H1
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
can be resource-managed, if required.

    alloc_string_stream() now allocates a string stream that is
    not resource-managed.

    string_stream_destroy() now works on an unmanaged string_stream
    allocated by alloc_string_stream() and frees the entire
    string_stream (previously it only freed the fragments).

    string_stream_clear() has been made public for callers that
    want to free the fragments without destroying the string_stream.

For resource-managed allocations use kunit_alloc_string_stream()
and kunit_free_string_stream().

In addition to this, string_stream_get_string() now returns an
unmanaged buffer that the caller must kfree().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: David Gow <davidgow@google.com>
---
Changes since v5:
- Make string_stream_clear() public (in v5 this was done in patch #8).
- In string-stream-test.c add a wrapper for kfree() to prevent a cast
  warning when calling kunit_add_action().
---
 lib/kunit/string-stream-test.c |  8 ++++-
 lib/kunit/string-stream.c      | 61 ++++++++++++++++++++++------------
 lib/kunit/string-stream.h      |  6 +++-
 lib/kunit/test.c               |  2 +-
 4 files changed, 53 insertions(+), 24 deletions(-)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 46b18e940b73..58ba1ef5207f 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -11,11 +11,18 @@
 
 #include "string-stream.h"
 
+/* This avoids a cast warning if kfree() is passed direct to kunit_add_action(). */
+static void kfree_wrapper(void *p)
+{
+	kfree(p);
+}
+
 static char *get_concatenated_string(struct kunit *test, struct string_stream *stream)
 {
 	char *str = string_stream_get_string(stream);
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
+	kunit_add_action(test, kfree_wrapper, (void *)str);
 
 	return str;
 }
@@ -30,7 +37,6 @@ static void string_stream_init_test(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, stream->length, 0);
 	KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
-	KUNIT_EXPECT_PTR_EQ(test, stream->test, test);
 	KUNIT_EXPECT_TRUE(test, (stream->gfp == GFP_KERNEL));
 	KUNIT_EXPECT_FALSE(test, stream->append_newlines);
 	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index 12ecf15e1f6b..64abceb7b716 100644
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
 
@@ -111,7 +107,7 @@ static void string_stream_clear(struct string_stream *stream)
 				 frag_container_safe,
 				 &stream->fragments,
 				 node) {
-		string_stream_fragment_destroy(stream->test, frag_container);
+		string_stream_fragment_destroy(frag_container);
 	}
 	stream->length = 0;
 	spin_unlock(&stream->lock);
@@ -123,7 +119,7 @@ char *string_stream_get_string(struct string_stream *stream)
 	size_t buf_len = stream->length + 1; /* +1 for null byte. */
 	char *buf;
 
-	buf = kunit_kzalloc(stream->test, buf_len, stream->gfp);
+	buf = kzalloc(buf_len, stream->gfp);
 	if (!buf)
 		return NULL;
 
@@ -139,13 +135,17 @@ int string_stream_append(struct string_stream *stream,
 			 struct string_stream *other)
 {
 	const char *other_content;
+	int ret;
 
 	other_content = string_stream_get_string(other);
 
 	if (!other_content)
 		return -ENOMEM;
 
-	return string_stream_add(stream, other_content);
+	ret = string_stream_add(stream, other_content);
+	kfree(other_content);
+
+	return ret;
 }
 
 bool string_stream_is_empty(struct string_stream *stream)
@@ -153,16 +153,15 @@ bool string_stream_is_empty(struct string_stream *stream)
 	return list_empty(&stream->fragments);
 }
 
-static struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
+struct string_stream *alloc_string_stream(gfp_t gfp)
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
 
@@ -171,15 +170,35 @@ static struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
 
 void string_stream_destroy(struct string_stream *stream)
 {
+	if (!stream)
+		return;
+
 	string_stream_clear(stream);
+	kfree(stream);
+}
+
+static void resource_free_string_stream(void *p)
+{
+	struct string_stream *stream = p;
+
+	string_stream_destroy(stream);
 }
 
 struct string_stream *kunit_alloc_string_stream(struct kunit *test, gfp_t gfp)
 {
-	return alloc_string_stream(test, gfp);
+	struct string_stream *stream;
+
+	stream = alloc_string_stream(gfp);
+	if (IS_ERR(stream))
+		return stream;
+
+	if (kunit_add_action_or_reset(test, resource_free_string_stream, stream) != 0)
+		return ERR_PTR(-ENOMEM);
+
+	return stream;
 }
 
 void kunit_free_string_stream(struct kunit *test, struct string_stream *stream)
 {
-	string_stream_destroy(stream);
+	kunit_release_action(test, resource_free_string_stream, (void *)stream);
 }
diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
index 3e70ee9d66e9..7be2450c7079 100644
--- a/lib/kunit/string-stream.h
+++ b/lib/kunit/string-stream.h
@@ -23,7 +23,6 @@ struct string_stream {
 	struct list_head fragments;
 	/* length and fragments are protected by this lock */
 	spinlock_t lock;
-	struct kunit *test;
 	gfp_t gfp;
 	bool append_newlines;
 };
@@ -33,6 +32,9 @@ struct kunit;
 struct string_stream *kunit_alloc_string_stream(struct kunit *test, gfp_t gfp);
 void kunit_free_string_stream(struct kunit *test, struct string_stream *stream);
 
+struct string_stream *alloc_string_stream(gfp_t gfp);
+void free_string_stream(struct string_stream *stream);
+
 int __printf(2, 3) string_stream_add(struct string_stream *stream,
 				     const char *fmt, ...);
 
@@ -40,6 +42,8 @@ int __printf(2, 0) string_stream_vadd(struct string_stream *stream,
 				      const char *fmt,
 				      va_list args);
 
+void string_stream_clear(struct string_stream *stream);
+
 char *string_stream_get_string(struct string_stream *stream);
 
 int string_stream_append(struct string_stream *stream,
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 93d9225d61e3..2ad45a4ac06a 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -296,7 +296,7 @@ static void kunit_print_string_stream(struct kunit *test,
 		kunit_err(test, "\n");
 	} else {
 		kunit_err(test, "%s", buf);
-		kunit_kfree(test, buf);
+		kfree(buf);
 	}
 }
 
-- 
2.30.2

