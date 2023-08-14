Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70BC77B9CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 15:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjHNNXv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 09:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjHNNX2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 09:23:28 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFE210CE;
        Mon, 14 Aug 2023 06:23:27 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37EBX0QX010808;
        Mon, 14 Aug 2023 08:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=Y+sd3a/o1GUUs4yo0lq87GbdUfS162oRTEWPoq4kVAc=; b=
        ZVtEI+5eCgVZlzSbl5qarpI5rhxxPbLJ0trhaZ2kDUK1ZYBCOu9EHStPMPbNmAaj
        ETReIuRpaqUkNYWVzkTTHkD3AETAmGNncYmPqj6NifJij+9Bzyb/YavL/1cANvRb
        yZHCiUs5iNvVKBjDMLFUO+N8yqLFbp6phjZYlSMmvFh3S84nKrrSLKRJdPJyg0k6
        3WNztbafRj/9EDDdPIjJMX82T3l5plinL0nShGX6Pjh17rtasnmLDoyDgjEmTL67
        Hp2ZHYRdoSCz5GCv8vYIhSzLCTEYxpKgv9L3t/GKQiZfisG4Bvq6XP36Hi1cUD3M
        LoGhQoKIj2RWzo/wsqDxSQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3se6uhhvdp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 08:23:13 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 14 Aug
 2023 14:23:13 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Mon, 14 Aug 2023 14:23:13 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DE07C15B4;
        Mon, 14 Aug 2023 13:23:12 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v4 03/10] kunit: string-stream: Add cases for adding empty strings to a string_stream
Date:   Mon, 14 Aug 2023 14:23:02 +0100
Message-ID: <20230814132309.32641-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230814132309.32641-1-rf@opensource.cirrus.com>
References: <20230814132309.32641-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Cfk9gbhP_noQrxClgFSo0sxdLnZ6YV0t
X-Proofpoint-ORIG-GUID: Cfk9gbhP_noQrxClgFSo0sxdLnZ6YV0t
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adds string_stream_append_empty_string_test() to test that adding an
empty string to a string_stream doesn't create a new empty fragment.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 lib/kunit/string-stream-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 1d46d5f06d2a..efe13e3322b5 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -206,11 +206,32 @@ static void string_stream_append_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream_1), stream_2_content);
 }
 
+/* Adding an empty string should not create a fragment. */
+static void string_stream_append_empty_string_test(struct kunit *test)
+{
+	struct string_stream *stream;
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
+	string_stream_add(stream, "%s", "");
+	KUNIT_EXPECT_EQ(test, list_count_nodes(&stream->fragments), 1);
+	KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream), "Add this line");
+}
+
 static struct kunit_case string_stream_test_cases[] = {
 	KUNIT_CASE(string_stream_init_test),
 	KUNIT_CASE(string_stream_line_add_test),
 	KUNIT_CASE(string_stream_variable_length_line_test),
 	KUNIT_CASE(string_stream_append_test),
+	KUNIT_CASE(string_stream_append_empty_string_test),
 	{}
 };
 
-- 
2.30.2

