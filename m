Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BDB787190
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 16:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241558AbjHXOcm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 10:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241638AbjHXOcV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 10:32:21 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0A61BCD;
        Thu, 24 Aug 2023 07:32:14 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37OBiqaW023544;
        Thu, 24 Aug 2023 09:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=apFZUiv/LQzmZkIh3gfQBJPkTCIxnb28cnxmeLVv+vw=; b=
        RoNtxWD/zyQM8qwDHHr1VnJKPao4zmbL6IAyVpRU3x0YrcEGtp3WT6cp+o3EImaP
        wL+ADEzakbiT8JxiqrFjdLN56jpYU2C+D/fTbPVU3BpkyofS0wcX4SdSytdrrOKQ
        VH8Mp2Pw9+FjoclJXiVkoC5xGaVcWx6/m9jytLmn52vxAeuSOh1GZEHG85W/jHL8
        l2t/nM0JgZm+ze3hw95Cii0aCe8Gc1FahALMnJxh4scXwzs9YvEaPz5nE1OExCoB
        h1t1KGq/p39au+D06BavXoWGNFN0XPKF9e5e9mM/N7v3br3eWk6po27QmsxYRFhm
        PZuT7hLRFqLgBscdjNQBHA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sp1w8geq3-6
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
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 49695357D;
        Thu, 24 Aug 2023 14:31:30 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v5 10/10] kunit: string-stream: Test performance of string_stream
Date:   Thu, 24 Aug 2023 15:31:29 +0100
Message-ID: <20230824143129.1957914-11-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230824143129.1957914-1-rf@opensource.cirrus.com>
References: <20230824143129.1957914-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: n0zQEES2T07w8f8pVv8BnxNVrpXHaODx
X-Proofpoint-ORIG-GUID: n0zQEES2T07w8f8pVv8BnxNVrpXHaODx
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
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
---
 lib/kunit/string-stream-test.c | 54 ++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 6897c57e0db7..7d81d139b8f8 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -8,7 +8,9 @@
 
 #include <kunit/static_stub.h>
 #include <kunit/test.h>
+#include <linux/ktime.h>
 #include <linux/slab.h>
+#include <linux/timekeeping.h>
 
 #include "string-stream.h"
 
@@ -437,6 +439,57 @@ static void string_stream_auto_newline_test(struct kunit *test)
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
@@ -462,6 +515,7 @@ static struct kunit_case string_stream_test_cases[] = {
 	KUNIT_CASE(string_stream_append_empty_string_test),
 	KUNIT_CASE(string_stream_no_auto_newline_test),
 	KUNIT_CASE(string_stream_auto_newline_test),
+	KUNIT_CASE(string_stream_performance_test),
 	{}
 };
 
-- 
2.30.2

