Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B0877B9D2
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 15:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjHNNXx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 09:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjHNNXh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 09:23:37 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0F1E7D;
        Mon, 14 Aug 2023 06:23:36 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37E5t3EM003856;
        Mon, 14 Aug 2023 08:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=Q2vvCFoXKdnxSXdtqWfmyzZJnVFwCZ6PAHSC4clhH3I=; b=
        l499AT/BL3ENUPuVaTvH+4gf2GHrbI+Luvmj90g/26fRm0GIv3Oewue09TkEiGgJ
        qkh8DEMjYLzqPB333JOsXPukn5JlL/K7FQ7T+vxwtZQayVrocXWNi1ZnPDS8n8qD
        G/y25dqtn6UCfWnRsxXmJxzz0CevqSJSxYquuW/p3ND9sGRDVG8YV1oGCH8uiaUO
        qU1G7W9BZeE4OOsvJk3p2p9zdccfIBSrj36i8xfBLJlag+J70vS6AfN01/ESvsQx
        51fht8AXEfchgoTUIASuaxhUd7PbK7DXKaDX1uBw2QbBnmfgzZxzM5a/mGzIrUWv
        k7DYdrIazPHYMYYEw0DGOw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3se8kqt6x8-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 08:23:19 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 14 Aug
 2023 14:23:15 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Mon, 14 Aug 2023 14:23:15 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1DA44458;
        Mon, 14 Aug 2023 13:23:15 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v4 08/10] kunit: string-stream: Add test for freeing resource-managed string_stream
Date:   Mon, 14 Aug 2023 14:23:07 +0100
Message-ID: <20230814132309.32641-9-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230814132309.32641-1-rf@opensource.cirrus.com>
References: <20230814132309.32641-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: c335VR0-Lq_QzjDpmR87PUvY8W8MBqpW
X-Proofpoint-GUID: c335VR0-Lq_QzjDpmR87PUvY8W8MBqpW
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

string_stream_resource_free_test() allocates a resource-managed
string_stream and tests that raw_free_string_stream() is called when
the test resources are cleaned up.

string_stream_init_test() is extended to test allocating a
string_stream that is not resource-managed.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 lib/kunit/string-stream-test.c | 117 ++++++++++++++++++++++++++++++++-
 lib/kunit/string-stream.c      |   3 +
 2 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 437aa4b3179d..05bfade2bd8a 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -6,16 +6,27 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
+#include <kunit/static_stub.h>
 #include <kunit/test.h>
 #include <linux/slab.h>
 
 #include "string-stream.h"
 
+struct string_stream_test_priv {
+	struct string_stream *raw_stream;
+
+	/* For testing resource-managed free */
+	struct string_stream *freed_stream;
+	bool stream_free_again;
+};
+
 /* string_stream object is initialized correctly. */
 static void string_stream_init_test(struct kunit *test)
 {
+	struct string_stream_test_priv *priv = test->priv;
 	struct string_stream *stream;
 
+	/* Resource-managed initialization */
 	stream = alloc_string_stream(test, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
 
@@ -26,6 +37,86 @@ static void string_stream_init_test(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, stream->append_newlines);
 
 	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
+
+	free_string_stream(test, stream);
+
+	/*
+	 * Raw initialization. This allocation is not resource-managed
+	 * so store it in priv->raw_stream to be cleaned up by the
+	 * exit function.
+	 */
+	priv->raw_stream = raw_alloc_string_stream(GFP_KERNEL);
+	stream = priv->raw_stream;
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	KUNIT_EXPECT_EQ(test, stream->length, 0);
+	KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
+	KUNIT_EXPECT_PTR_EQ(test, stream->test, NULL);
+	KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);
+	KUNIT_EXPECT_FALSE(test, stream->append_newlines);
+
+	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
+}
+
+static void string_stream_raw_free_string_stream_stub(struct string_stream *stream)
+{
+	struct kunit *fake_test = kunit_get_current_test();
+	struct string_stream_test_priv *priv = fake_test->priv;
+
+	if (priv->freed_stream)
+		priv->stream_free_again = true;
+
+	priv->freed_stream = stream;
+
+	/*
+	 * Avoid calling deactivate_static_stub() or changing
+	 * current->kunit_test during cleanup. Leave the stream to
+	 * be freed during the test exit.
+	 */
+}
+
+/* string_stream object is freed when test is cleaned up. */
+static void string_stream_resource_free_test(struct kunit *test)
+{
+	struct string_stream_test_priv *priv = test->priv;
+	struct kunit *fake_test;
+	struct string_stream *stream;
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
+	priv->freed_stream = NULL;
+	priv->stream_free_again = false;
+	kunit_activate_static_stub(fake_test,
+				   raw_free_string_stream,
+				   string_stream_raw_free_string_stream_stub);
+
+	stream = alloc_string_stream(fake_test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	/*
+	 * Ensure the stream is freed when this test terminates.
+	 */
+	priv->raw_stream = stream;
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
+	KUNIT_EXPECT_PTR_EQ(test, priv->freed_stream, stream);
+	KUNIT_EXPECT_FALSE(test, priv->stream_free_again);
 }
 
 /*
@@ -279,8 +370,30 @@ static void string_stream_auto_newline_test(struct kunit *test)
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
+static void string_stream_test_exit(struct kunit *test)
+{
+	struct string_stream_test_priv *priv = test->priv;
+
+	if (priv && priv->raw_stream)
+		raw_free_string_stream(priv->raw_stream);
+}
+
 static struct kunit_case string_stream_test_cases[] = {
 	KUNIT_CASE(string_stream_init_test),
+	KUNIT_CASE(string_stream_resource_free_test),
 	KUNIT_CASE(string_stream_line_add_test),
 	KUNIT_CASE(string_stream_variable_length_line_test),
 	KUNIT_CASE(string_stream_append_test),
@@ -292,6 +405,8 @@ static struct kunit_case string_stream_test_cases[] = {
 
 static struct kunit_suite string_stream_test_suite = {
 	.name = "string-stream-test",
-	.test_cases = string_stream_test_cases
+	.test_cases = string_stream_test_cases,
+	.init = string_stream_test_init,
+	.exit = string_stream_test_exit,
 };
 kunit_test_suites(&string_stream_test_suite);
diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index 06104a729b45..1b55ac1be2e5 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -6,6 +6,7 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
+#include <kunit/static_stub.h>
 #include <kunit/test.h>
 #include <linux/list.h>
 #include <linux/slab.h>
@@ -167,6 +168,8 @@ bool string_stream_is_empty(struct string_stream *stream)
 
 void raw_free_string_stream(struct string_stream *stream)
 {
+	KUNIT_STATIC_STUB_REDIRECT(raw_free_string_stream, stream);
+
 	string_stream_clear(stream);
 	kfree(stream);
 }
-- 
2.30.2

