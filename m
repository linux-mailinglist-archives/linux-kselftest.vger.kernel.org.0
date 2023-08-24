Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089847871A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 16:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbjHXOdp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 10:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240251AbjHXOdP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 10:33:15 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483271BE;
        Thu, 24 Aug 2023 07:33:13 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37OBiqaV023544;
        Thu, 24 Aug 2023 09:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=1ecAzTTgRFxOlByV7wi+Nk1UaCCQVNJNqnvAOANu3Pc=; b=
        luc97vUigU33Ncepo/uD6U+21wRb+YDbW2MP8lk29vhEmuuAenHaOSTnHf6IBTdr
        J1VPfAFf0rDTV6MJRX+GxDes1NRRbSaR+aRQ8mDn9BlfRVGkvCcYY9u+MpdfgRkA
        bi9ZdEU99p7hdmQqRESRboxzVmPl0ZEWGj1bplCI/gQb4yIbH1DMAb2Zj7JFS4zJ
        v2luCSKHp9zUaRXEdv0F3C1VXtOwg+MLjoEEBwtMl77rA1R36k/yfLVW4xwHkFaJ
        ER1+GX3MvfwhVQ1TAF/0oMEV6J9lnPeXOQYaPGPd9vsI8zuWAa5lnch0KNQieVfJ
        +4Nd/Bw1MPsSGsDOWk4SUQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sp1w8geq3-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 09:31:34 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 24 Aug
 2023 15:31:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Thu, 24 Aug 2023 15:31:30 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2B7FF46B;
        Thu, 24 Aug 2023 14:31:30 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v5 08/10] kunit: string-stream: Add tests for freeing resource-managed string_stream
Date:   Thu, 24 Aug 2023 15:31:27 +0100
Message-ID: <20230824143129.1957914-9-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230824143129.1957914-1-rf@opensource.cirrus.com>
References: <20230824143129.1957914-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mTKF2H5FQLoUs9yJM53hlDVgCVMV2QKm
X-Proofpoint-ORIG-GUID: mTKF2H5FQLoUs9yJM53hlDVgCVMV2QKm
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
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
Changes since V4:
- Added test case for kunit_free_string_stream().
- Split the initialization test into separate tests for managed and
  unmanaged allocations.
---
 lib/kunit/string-stream-test.c | 135 ++++++++++++++++++++++++++++++++-
 lib/kunit/string-stream.c      |   3 +
 2 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 45a2d221f1b5..6897c57e0db7 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -6,11 +6,25 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
+#include <kunit/static_stub.h>
 #include <kunit/test.h>
 #include <linux/slab.h>
 
 #include "string-stream.h"
 
+struct string_stream_test_priv {
+	/* For testing resource-managed free. */
+	struct string_stream *freed_stream;
+	bool stream_free_again;
+};
+
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
@@ -21,11 +35,12 @@ static char *get_concatenated_string(struct kunit *test, struct string_stream *s
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
 
@@ -37,6 +52,101 @@ static void string_stream_init_test(struct kunit *test)
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
+/* kunit_free_string_stream() calls string_stream_desrtoy() */
+static void string_stream_managed_free_test(struct kunit *test)
+{
+	struct string_stream_test_priv *priv = test->priv;
+	struct string_stream *stream;
+
+	priv->freed_stream = NULL;
+	priv->stream_free_again = false;
+	kunit_activate_static_stub(test,
+				   string_stream_destroy,
+				   string_stream_destroy_stub);
+
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	/* This should call the stub function. */
+	kunit_free_string_stream(test, stream);
+
+	KUNIT_EXPECT_PTR_EQ(test, priv->freed_stream, stream);
+	KUNIT_EXPECT_FALSE(test, priv->stream_free_again);
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
+				   string_stream_destroy,
+				   string_stream_destroy_stub);
+
+	stream = kunit_alloc_string_stream(fake_test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
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
+}
+
 /*
  * Add a series of lines to a string_stream. Check that all lines
  * appear in the correct order and no characters are dropped.
@@ -327,8 +437,24 @@ static void string_stream_auto_newline_test(struct kunit *test)
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
@@ -341,6 +467,7 @@ static struct kunit_case string_stream_test_cases[] = {
 
 static struct kunit_suite string_stream_test_suite = {
 	.name = "string-stream-test",
-	.test_cases = string_stream_test_cases
+	.test_cases = string_stream_test_cases,
+	.init = string_stream_test_init,
 };
 kunit_test_suites(&string_stream_test_suite);
diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index c39f1cba3bcd..d2ded5207e9e 100644
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

