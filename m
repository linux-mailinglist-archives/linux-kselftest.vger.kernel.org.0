Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDA378ACBE
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 12:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjH1KmK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 06:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjH1Klo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 06:41:44 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D98E125;
        Mon, 28 Aug 2023 03:41:41 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37SABUG4018563;
        Mon, 28 Aug 2023 05:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=2BeZdx0R5mjwkTKHjS/B8TSLJ4ce9zQ2GwfW/Ob+iNs=; b=
        pLxQn4ANzgFjpvekhCfymBXh4j0FIuTGiCpXdl4mVHFLUMASvhwvns6WTQF8BK+m
        QMZ8wUC+i00e1AM8XzZaBFFoS4n666FEhxMQNj3BB2tZs4zI+93pzLR3fNO6UKDn
        V2FoHdwa7hQCursIqiM4XAN0h5LFWoS1FkApZ3zIDJw/VTL1vp/T1BC2zb76wtXW
        UClNnwwMsimOX9so0kvKZk8OtGJPKID2/o4f6Y3wVMnOLxRF6BnzDCvdq90lFO3R
        ooqKkX9HOe1sM8/r9hsadPQqtIt3ztfRgszMQrXo//xhqbpBTLf313jUt3vGpnvy
        RikmZI4IADXLIsCvCGtryg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesya0ma-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 05:41:18 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 28 Aug
 2023 11:41:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 28 Aug 2023 11:41:12 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9123911AA;
        Mon, 28 Aug 2023 10:41:12 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v6 08/10] kunit: string-stream: Add tests for freeing resource-managed string_stream
Date:   Mon, 28 Aug 2023 11:41:09 +0100
Message-ID: <20230828104111.2394344-9-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230828104111.2394344-1-rf@opensource.cirrus.com>
References: <20230828104111.2394344-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HIb2PW5LhgA9JrP-1QxGM-brbI1hoRbC
X-Proofpoint-GUID: HIb2PW5LhgA9JrP-1QxGM-brbI1hoRbC
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

string_stream_managed_free_test() allocates a resource-managed
string_stream and tests that kunit_free_string_stream() calls
string_stream_destroy().

string_stream_resource_free_test() allocates a resource-managed
string_stream and tests that string_stream_destroy() is called
when the test resources are cleaned up.

The old string_stream_init_test() has been split into two tests,
one for kunit_alloc_string_stream() and the other for
alloc_string_stream().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Changes since v5:
- Fix memory leak when calling the redirected string_stream_destroy_stub().
---
 lib/kunit/string-stream-test.c | 147 +++++++++++++++++++++++++++++++--
 lib/kunit/string-stream.c      |   3 +
 2 files changed, 145 insertions(+), 5 deletions(-)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 58ba1ef5207f..b759974d9cec 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -6,17 +6,33 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
+#include <kunit/static_stub.h>
 #include <kunit/test.h>
 #include <linux/slab.h>
 
 #include "string-stream.h"
 
-/* This avoids a cast warning if kfree() is passed direct to kunit_add_action(). */
+struct string_stream_test_priv {
+	/* For testing resource-managed free. */
+	struct string_stream *expected_free_stream;
+	bool stream_was_freed;
+	bool stream_free_again;
+};
+
+/* Avoids a cast warning if kfree() is passed direct to kunit_add_action(). */
 static void kfree_wrapper(void *p)
 {
 	kfree(p);
 }
 
+/* Avoids a cast warning if string_stream_destroy() is passed direct to kunit_add_action(). */
+static void cleanup_raw_stream(void *p)
+{
+	struct string_stream *stream = p;
+
+	string_stream_destroy(stream);
+}
+
 static char *get_concatenated_string(struct kunit *test, struct string_stream *stream)
 {
 	char *str = string_stream_get_string(stream);
@@ -27,11 +43,12 @@ static char *get_concatenated_string(struct kunit *test, struct string_stream *s
 	return str;
 }
 
-/* string_stream object is initialized correctly. */
-static void string_stream_init_test(struct kunit *test)
+/* Managed string_stream object is initialized correctly. */
+static void string_stream_managed_init_test(struct kunit *test)
 {
 	struct string_stream *stream;
 
+	/* Resource-managed initialization. */
 	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
 
@@ -42,6 +59,109 @@ static void string_stream_init_test(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
 }
 
+/* Unmanaged string_stream object is initialized correctly. */
+static void string_stream_unmanaged_init_test(struct kunit *test)
+{
+	struct string_stream *stream;
+
+	stream = alloc_string_stream(GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+	kunit_add_action(test, cleanup_raw_stream, stream);
+
+	KUNIT_EXPECT_EQ(test, stream->length, 0);
+	KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
+	KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);
+	KUNIT_EXPECT_FALSE(test, stream->append_newlines);
+
+	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
+}
+
+static void string_stream_destroy_stub(struct string_stream *stream)
+{
+	struct kunit *fake_test = kunit_get_current_test();
+	struct string_stream_test_priv *priv = fake_test->priv;
+
+	/* The kunit could own string_streams other than the one we are testing. */
+	if (stream == priv->expected_free_stream) {
+		if (priv->stream_was_freed)
+			priv->stream_free_again = true;
+		else
+			priv->stream_was_freed = true;
+	}
+
+	/*
+	 * Calling string_stream_destroy() will only call this function again
+	 * because the redirection stub is still active.
+	 * Avoid calling deactivate_static_stub() or changing current->kunit_test
+	 * during cleanup.
+	 */
+	string_stream_clear(stream);
+	kfree(stream);
+}
+
+/* kunit_free_string_stream() calls string_stream_desrtoy() */
+static void string_stream_managed_free_test(struct kunit *test)
+{
+	struct string_stream_test_priv *priv = test->priv;
+
+	priv->expected_free_stream = NULL;
+	priv->stream_was_freed = false;
+	priv->stream_free_again = false;
+
+	kunit_activate_static_stub(test,
+				   string_stream_destroy,
+				   string_stream_destroy_stub);
+
+	priv->expected_free_stream = kunit_alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->expected_free_stream);
+
+	/* This should call the stub function. */
+	kunit_free_string_stream(test, priv->expected_free_stream);
+
+	KUNIT_EXPECT_TRUE(test, priv->stream_was_freed);
+	KUNIT_EXPECT_FALSE(test, priv->stream_free_again);
+}
+
+/* string_stream object is freed when test is cleaned up. */
+static void string_stream_resource_free_test(struct kunit *test)
+{
+	struct string_stream_test_priv *priv = test->priv;
+	struct kunit *fake_test;
+
+	fake_test = kunit_kzalloc(test, sizeof(*fake_test), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fake_test);
+
+	kunit_init_test(fake_test, "string_stream_fake_test", NULL);
+	fake_test->priv = priv;
+
+	/*
+	 * Activate stub before creating string_stream so the
+	 * string_stream will be cleaned up first.
+	 */
+	priv->expected_free_stream = NULL;
+	priv->stream_was_freed = false;
+	priv->stream_free_again = false;
+
+	kunit_activate_static_stub(fake_test,
+				   string_stream_destroy,
+				   string_stream_destroy_stub);
+
+	priv->expected_free_stream = kunit_alloc_string_stream(fake_test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->expected_free_stream);
+
+	/* Set current->kunit_test to fake_test so the static stub will be called. */
+	current->kunit_test = fake_test;
+
+	/* Cleanup test - the stub function should be called */
+	kunit_cleanup(fake_test);
+
+	/* Set current->kunit_test back to current test. */
+	current->kunit_test = test;
+
+	KUNIT_EXPECT_TRUE(test, priv->stream_was_freed);
+	KUNIT_EXPECT_FALSE(test, priv->stream_free_again);
+}
+
 /*
  * Add a series of lines to a string_stream. Check that all lines
  * appear in the correct order and no characters are dropped.
@@ -334,8 +454,24 @@ static void string_stream_auto_newline_test(struct kunit *test)
 			   "One\nTwo\nThree\nFour\nFive\nSix\nSeven\n\nEight\n");
 }
 
+static int string_stream_test_init(struct kunit *test)
+{
+	struct string_stream_test_priv *priv;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	test->priv = priv;
+
+	return 0;
+}
+
 static struct kunit_case string_stream_test_cases[] = {
-	KUNIT_CASE(string_stream_init_test),
+	KUNIT_CASE(string_stream_managed_init_test),
+	KUNIT_CASE(string_stream_unmanaged_init_test),
+	KUNIT_CASE(string_stream_managed_free_test),
+	KUNIT_CASE(string_stream_resource_free_test),
 	KUNIT_CASE(string_stream_line_add_test),
 	KUNIT_CASE(string_stream_variable_length_line_test),
 	KUNIT_CASE(string_stream_append_test),
@@ -348,6 +484,7 @@ static struct kunit_case string_stream_test_cases[] = {
 
 static struct kunit_suite string_stream_test_suite = {
 	.name = "string-stream-test",
-	.test_cases = string_stream_test_cases
+	.test_cases = string_stream_test_cases,
+	.init = string_stream_test_init,
 };
 kunit_test_suites(&string_stream_test_suite);
diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index 64abceb7b716..a6f3616c2048 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -6,6 +6,7 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
+#include <kunit/static_stub.h>
 #include <kunit/test.h>
 #include <linux/list.h>
 #include <linux/slab.h>
@@ -170,6 +171,8 @@ struct string_stream *alloc_string_stream(gfp_t gfp)
 
 void string_stream_destroy(struct string_stream *stream)
 {
+	KUNIT_STATIC_STUB_REDIRECT(string_stream_destroy, stream);
+
 	if (!stream)
 		return;
 
-- 
2.30.2

