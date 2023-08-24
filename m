Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB903787193
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 16:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbjHXOcn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 10:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241639AbjHXOcV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 10:32:21 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8EC1BCF;
        Thu, 24 Aug 2023 07:32:15 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37OBiqaU023544;
        Thu, 24 Aug 2023 09:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=1pwt1C/EAB+LiAxAJRYRJzDCa2r6Yh3RhPNpDk9yavo=; b=
        Nrfjq4JIIq4cOe9m1TE+lt+aqpDk3WcngG7I8SA3+Jha2VmDsHRFrA0MVNtN5TOm
        wuZFAwjeJOcdy+qgA1kRftrdJtUiXCR+kMJjjtAedl805kjVSuaMSWJ35dS5Bfqp
        CNu9UIszMtxs+ZdlGyZacz/F5Sx200r/MChOkI7/Cfve4soRrhktBkawlZGnLb2U
        BT8Mg4u33Kqvo20gxARKCfJqC9S9Bz7Zpj3V07SjyZjT9zLzEtO5yKBpU+gOUFyi
        dT9dEScz2vQq6PUOr8M/hXL0eGhCZGAQoamlvI4aSCVeDI2R6bVaLyDrckHrRmX7
        zOTh9yPyMqKR6sootAVbfA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sp1w8geq3-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 09:31:33 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 24 Aug
 2023 15:31:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Thu, 24 Aug 2023 15:31:30 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1491F357D;
        Thu, 24 Aug 2023 14:31:30 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v5 07/10] kunit: string-stream: Decouple string_stream from kunit
Date:   Thu, 24 Aug 2023 15:31:26 +0100
Message-ID: <20230824143129.1957914-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230824143129.1957914-1-rf@opensource.cirrus.com>
References: <20230824143129.1957914-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: j9_cXNhPgm5C1RnydIAPmsBAiKP7aRr8
X-Proofpoint-ORIG-GUID: j9_cXNhPgm5C1RnydIAPmsBAiKP7aRr8
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
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

For resource-managed allocations use kunit_alloc_string_stream()
and kunit_free_string_stream().

In addition to this, string_stream_get_string() now returns an
unmanaged buffer that the caller must kfree().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Changes since V4:
- Adding the kunit_[alloc|free]_string_stream() functions has been split
  out into the previous patch to reduce the amount of code churn in
  this patch.
- string_stream_destroy() has been kept and re-used instead of replacing
  it with a new function.
- string_stream_get_string() now returns an unmanaged buffer. This avoids
  a large code change to string_stream_append().
- Added wrapper function for resource free to prevent the type warning of
  passing string_stream_destroy() directly to kunit_add_action_or_reset().
---
 lib/kunit/string-stream-test.c |  2 +-
 lib/kunit/string-stream.c      | 59 ++++++++++++++++++++++------------
 lib/kunit/string-stream.h      |  4 ++-
 lib/kunit/test.c               |  2 +-
 4 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 89549c237069..45a2d221f1b5 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -16,6 +16,7 @@ static char *get_concatenated_string(struct kunit *test, struct string_stream *s
 	char *str = string_stream_get_string(stream);
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
+	kunit_add_action(test, (kunit_action_t *)kfree, (void *)str);
 
 	return str;
 }
@@ -30,7 +31,6 @@ static void string_stream_init_test(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, stream->length, 0);
 	KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
-	KUNIT_EXPECT_PTR_EQ(test, stream->test, test);
 	KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);
 	KUNIT_EXPECT_FALSE(test, stream->append_newlines);
 
diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index 12ecf15e1f6b..c39f1cba3bcd 100644
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
index 3e70ee9d66e9..c55925a9b67f 100644
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

