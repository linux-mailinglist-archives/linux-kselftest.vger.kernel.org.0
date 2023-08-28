Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D4C78ACB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 12:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjH1KmE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 06:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjH1Klh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 06:41:37 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04C0119;
        Mon, 28 Aug 2023 03:41:34 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37SABUFw018563;
        Mon, 28 Aug 2023 05:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=VtqyJzlmhyeo6IMIXuB6Vo1smMPZ7UgzIWxHNDjZaMQ=; b=
        ndArB+nzfTj4QJPSSbtxgGtln8IKHO2cJyU4CCUdQBgUWm2YR3El2/KwBUrrmHqq
        Urt1HJdt4V84oluBDgbJCQ5Q63LXsQA2u6OlVXxmbeOr2DAdksWszeCV6c90cPFL
        vMUueVBQaBXm3YxnTmgzCws72f+PY4nx+B95zTnR1A117wnSOHfLfOXr6xR7FXLd
        A4CkMjow1rr7SYcaOI3UsjLyDDGqSp+iHvU16l8V0pHLmxlL3YGafJrad9u9psMX
        XOLn07SYRjjVMtdVOS81GtxIV6Ef7FRNXlogv5UYKrW0E6HmsiRhKFJawkf0eB3P
        Fy6Of0Cxbg+6ZcqQf5Cj+w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesya0ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 05:41:14 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 28 Aug
 2023 11:41:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 28 Aug 2023 11:41:12 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 04DD246B;
        Mon, 28 Aug 2023 10:41:12 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v6 01/10] kunit: string-stream: Don't create a fragment for empty strings
Date:   Mon, 28 Aug 2023 11:41:02 +0100
Message-ID: <20230828104111.2394344-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230828104111.2394344-1-rf@opensource.cirrus.com>
References: <20230828104111.2394344-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QS0wt-dqUX8evyjAJifpW2JVSXWhYBHn
X-Proofpoint-GUID: QS0wt-dqUX8evyjAJifpW2JVSXWhYBHn
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If the result of the formatted string is an empty string just return
instead of creating an empty fragment.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 lib/kunit/string-stream.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index cc32743c1171..ed24d86af9f5 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -50,11 +50,17 @@ int string_stream_vadd(struct string_stream *stream,
 	/* Make a copy because `vsnprintf` could change it */
 	va_copy(args_for_counting, args);
 
-	/* Need space for null byte. */
-	len = vsnprintf(NULL, 0, fmt, args_for_counting) + 1;
+	/* Evaluate length of formatted string */
+	len = vsnprintf(NULL, 0, fmt, args_for_counting);
 
 	va_end(args_for_counting);
 
+	if (len == 0)
+		return 0;
+
+	/* Need space for null byte. */
+	len++;
+
 	frag_container = alloc_string_stream_fragment(stream->test,
 						      len,
 						      stream->gfp);
-- 
2.30.2

