Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939EE787199
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 16:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241628AbjHXOcn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 10:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241641AbjHXOcV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 10:32:21 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D36A1BC7;
        Thu, 24 Aug 2023 07:32:16 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37O7iEx7023063;
        Thu, 24 Aug 2023 09:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=Yupd1q6AJQzOAVgYImPFKGHHJ/t/ka8TMzP1TWn8MIA=; b=
        ge63IAtJhEoq4HWiimJgfScuyFEM9319Ekg+jd5l9ly+rDQ7dSj+jvecLyAhwP/g
        ztTRPesh7VV4ceQNr0HDZ/3sVIBnVB+0vimY3lQysHIV2eZKNjkbES1lf6F/fxQI
        uSRoL1cvsmrIjzdoqSMJf4K/CyfCsFaeZRKKuuqM0E55jSUQlVk9DWmwTHoOwdyy
        7yZWTq0xcavlclNG1JQ5mCOccOjEVOBcFH2Tf6yt1I7XuPxI81A9aPY1BgJTUnD6
        6qU4Dpo6esl3SSN6D1ZJfewfYvxxulyZDNKuAn4HxXzE6f7t8sYSLADB5piCb9mK
        ItP/ssJuaSNyX/lwXEVRZQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sp1rbghkk-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 09:31:34 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 24 Aug
 2023 15:31:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Thu, 24 Aug 2023 15:31:29 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E2C5346B;
        Thu, 24 Aug 2023 14:31:29 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v5 05/10] kunit: Don't use a managed alloc in is_literal()
Date:   Thu, 24 Aug 2023 15:31:24 +0100
Message-ID: <20230824143129.1957914-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230824143129.1957914-1-rf@opensource.cirrus.com>
References: <20230824143129.1957914-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: INGBRGDdMUOMholT83zPVTziwuI2Sy5Y
X-Proofpoint-GUID: INGBRGDdMUOMholT83zPVTziwuI2Sy5Y
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is no need to use a test-managed alloc in is_literal().
The function frees the temporary buffer before returning.

This removes the only use of the test and gfp members of
struct string_stream outside of the string_stream implementation.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 lib/kunit/assert.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 05a09652f5a1..dd1d633d0fe2 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -89,8 +89,7 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
 
 /* Checks if `text` is a literal representing `value`, e.g. "5" and 5 */
-static bool is_literal(struct kunit *test, const char *text, long long value,
-		       gfp_t gfp)
+static bool is_literal(const char *text, long long value)
 {
 	char *buffer;
 	int len;
@@ -100,14 +99,15 @@ static bool is_literal(struct kunit *test, const char *text, long long value,
 	if (strlen(text) != len)
 		return false;
 
-	buffer = kunit_kmalloc(test, len+1, gfp);
+	buffer = kmalloc(len+1, GFP_KERNEL);
 	if (!buffer)
 		return false;
 
 	snprintf(buffer, len+1, "%lld", value);
 	ret = strncmp(buffer, text, len) == 0;
 
-	kunit_kfree(test, buffer);
+	kfree(buffer);
+
 	return ret;
 }
 
@@ -125,14 +125,12 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 			  binary_assert->text->left_text,
 			  binary_assert->text->operation,
 			  binary_assert->text->right_text);
-	if (!is_literal(stream->test, binary_assert->text->left_text,
-			binary_assert->left_value, stream->gfp))
+	if (!is_literal(binary_assert->text->left_text, binary_assert->left_value))
 		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)\n",
 				  binary_assert->text->left_text,
 				  binary_assert->left_value,
 				  binary_assert->left_value);
-	if (!is_literal(stream->test, binary_assert->text->right_text,
-			binary_assert->right_value, stream->gfp))
+	if (!is_literal(binary_assert->text->right_text, binary_assert->right_value))
 		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)",
 				  binary_assert->text->right_text,
 				  binary_assert->right_value,
-- 
2.30.2

