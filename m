Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEC578ACBC
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 12:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjH1KmJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 06:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjH1Klj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 06:41:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A981CB9;
        Mon, 28 Aug 2023 03:41:35 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37SABUG1018563;
        Mon, 28 Aug 2023 05:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=MruAHJU2cpboKux7PAcM0znPrqfaNXl6UI4/jH4wtCs=; b=
        cCCZKS9vW11uQFoQrr5EFNGm1Mx/tYxY7iXrVsB2hO4XCiI6Zq8hdusLdlQR9xS8
        q/sQggYqlIbIZl1riZJXvK3viSWcDaYrHDVph+YYv/SZ6egPcvnUDT7rXbfPNmRT
        cq+BJJbZG1IWHO7/cFj/L6q0y+2yYDUt0jvpmIRgKtoDQTHsn2lZknd7lxD+bNeQ
        QsmuUVdfwyRWa8+f6coc+g+TBOl6gvFai1wqUiKNMxHUeJ7Qes5odVjiEmI4Ikqb
        YX2WXeg9Do0t284viDWRplzN9X2zdiP/DVnbH6WR/ykkU5ola2FS96EUIrTFoBVF
        GRPsYrKxuabilNXgxKZw1A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesya0ma-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 05:41:16 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 28 Aug
 2023 11:41:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 28 Aug 2023 11:41:12 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 53D3111AA;
        Mon, 28 Aug 2023 10:41:12 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v6 05/10] kunit: Don't use a managed alloc in is_literal()
Date:   Mon, 28 Aug 2023 11:41:06 +0100
Message-ID: <20230828104111.2394344-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230828104111.2394344-1-rf@opensource.cirrus.com>
References: <20230828104111.2394344-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: udxFeyF1CwLIV4ZzE7QIvD9nWV4sgIfe
X-Proofpoint-GUID: udxFeyF1CwLIV4ZzE7QIvD9nWV4sgIfe
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
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
Reviewed-by: David Gow <davidgow@google.com>
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

