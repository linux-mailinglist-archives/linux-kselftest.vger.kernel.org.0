Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD56878ACC0
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 12:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjH1KmM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 06:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjH1Klp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 06:41:45 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930D8129;
        Mon, 28 Aug 2023 03:41:42 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37SABUG5018563;
        Mon, 28 Aug 2023 05:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=KmV5S8qj6Tc2ww0hbmelZFHm8B9ZWDJTwvDRPAsLDzE=; b=
        R0NOu2ONi20AxMtbH0MxHgRzJ6AQB5vsvKNhWNzzip/OTw4NJuqNc7rPBwugg/hy
        HpLmi7z7pwWp5WYVnAXKXlHBZH/UfKRcSsqrAWjhKQkJrzW1MkVaWOYcCF0VEABG
        FoLZyLC5HDK024NyFcF7pYziuJaxgXCoX58wekfnwpLCbLG5xe34a0wQDCvcOdo1
        IFGiUpCa+c117WPO64lzmTFpo8EOibqgrgfuCgtXQZ7Wu6BY1SrGqdZfjzdvVKsN
        z6MxjG2CU6Eq7/vdl+0jUoDIKRrihjYK/p4jLAeFziSbchAwxyxpBpsw8LGE3CW5
        tppt9qiVSbO/zJNbPx/3bA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesya0ma-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 05:41:19 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 28 Aug
 2023 11:41:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 28 Aug 2023 11:41:12 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B28EA46B;
        Mon, 28 Aug 2023 10:41:12 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v6 10/10] kunit: string-stream: Test performance of string_stream
Date:   Mon, 28 Aug 2023 11:41:11 +0100
Message-ID: <20230828104111.2394344-11-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230828104111.2394344-1-rf@opensource.cirrus.com>
References: <20230828104111.2394344-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tWHCraKBcov5GvPimHJoSSGYn2B8nEND
X-Proofpoint-GUID: tWHCraKBcov5GvPimHJoSSGYn2B8nEND
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test of the speed and memory use of string_stream.

string_stream_performance_test() doesn't actually "test" anything (it
cannot fail unless the system has run out of allocatable memory) but it
measures the speed and memory consumption of the string_stream and reports
the result.

This allows changes in the string_stream implementation to be compared.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 lib/kunit/string-stream-test.c | 54 ++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index b759974d9cec..06822766f29a 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -8,7 +8,9 @@
 
 #include <kunit/static_stub.h>
 #include <kunit/test.h>
+#include <linux/ktime.h>
 #include <linux/slab.h>
+#include <linux/timekeeping.h>
 
 #include "string-stream.h"
 
@@ -454,6 +456,57 @@ static void string_stream_auto_newline_test(struct kunit *test)
 			   "One\nTwo\nThree\nFour\nFive\nSix\nSeven\n\nEight\n");
 }
 
+/*
+ * This doesn't actually "test" anything. It reports time taken
+ * and memory used for logging a large number of lines.
+ */
+static void string_stream_performance_test(struct kunit *test)
+{
+	struct string_stream_fragment *frag_container;
+	struct string_stream *stream;
+	char test_line[101];
+	ktime_t start_time, end_time;
+	size_t len, bytes_requested, actual_bytes_used, total_string_length;
+	int offset, i;
+
+	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	memset(test_line, 'x', sizeof(test_line) - 1);
+	test_line[sizeof(test_line) - 1] = '\0';
+
+	start_time = ktime_get();
+	for (i = 0; i < 10000; i++) {
+		offset = i % (sizeof(test_line) - 1);
+		string_stream_add(stream, "%s: %d\n", &test_line[offset], i);
+	}
+	end_time = ktime_get();
+
+	/*
+	 * Calculate memory used. This doesn't include invisible
+	 * overhead due to kernel allocator fragment size rounding.
+	 */
+	bytes_requested = sizeof(*stream);
+	actual_bytes_used = ksize(stream);
+	total_string_length = 0;
+
+	list_for_each_entry(frag_container, &stream->fragments, node) {
+		bytes_requested += sizeof(*frag_container);
+		actual_bytes_used += ksize(frag_container);
+
+		len = strlen(frag_container->fragment);
+		total_string_length += len;
+		bytes_requested += len + 1; /* +1 for '\0' */
+		actual_bytes_used += ksize(frag_container->fragment);
+	}
+
+	kunit_info(test, "Time elapsed:           %lld us\n",
+		   ktime_us_delta(end_time, start_time));
+	kunit_info(test, "Total string length:    %zu\n", total_string_length);
+	kunit_info(test, "Bytes requested:        %zu\n", bytes_requested);
+	kunit_info(test, "Actual bytes allocated: %zu\n", actual_bytes_used);
+}
+
 static int string_stream_test_init(struct kunit *test)
 {
 	struct string_stream_test_priv *priv;
@@ -479,6 +532,7 @@ static struct kunit_case string_stream_test_cases[] = {
 	KUNIT_CASE(string_stream_append_empty_string_test),
 	KUNIT_CASE(string_stream_no_auto_newline_test),
 	KUNIT_CASE(string_stream_auto_newline_test),
+	KUNIT_CASE(string_stream_performance_test),
 	{}
 };
 
-- 
2.30.2

