Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C4A773CBC
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjHHQJQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjHHQHQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:07:16 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB9835B0;
        Tue,  8 Aug 2023 08:46:03 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 378CIdoS005342;
        Tue, 8 Aug 2023 07:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=GgFdDnzz+7JAwjRJW8zhNTbwVgS2JIBiaL8XcC78l4c=; b=
        pmIzygmBfsn3qRVVIz4bdaVjtyFst7C1dcTzcU/48cjJB+HasIM7iWvDD7m1e7wC
        z6GhITDLraCZ3f+ZNFrNojdHzykijI0pg860a53NnerHgWrUDMrWbIBc74qV8aux
        6WDtjwqG1EuCoiWxQLFiNL4j/JIJN0rVHt+PV3joHlUFvNYffOyMxgW7WUg+i7te
        ujwHuVmFZ6J+w+4E6xw32cNmmSDWsugrSdL8dU0xGpvAXCFUei8ubaEz3+ZuxgZO
        WfHN92dDYMVQBhTttxc5zge2WuBBxJ7nCha49loe/p/iTDjL2FS2/uquCu48d7y8
        9+IOuXlxNLPanSciy3YUbQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhtjv4-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 07:35:37 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 13:35:34 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 8 Aug 2023 13:35:34 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6EFFF15B7;
        Tue,  8 Aug 2023 12:35:34 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 6/6] kunit: Don't waste first attempt to format string in kunit_log_append()
Date:   Tue, 8 Aug 2023 13:35:29 +0100
Message-ID: <20230808123529.4725-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230808123529.4725-1-rf@opensource.cirrus.com>
References: <20230808123529.4725-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Osq8-YE0_Ig-_LR4re6_Fn4RC4EyohRg
X-Proofpoint-ORIG-GUID: Osq8-YE0_Ig-_LR4re6_Fn4RC4EyohRg
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It's wasteful to call vsnprintf() only to figure out the length of the
string. The string might fit in the available buffer space but we have to
vsnprintf() again to do that.

Instead, attempt to format the string to the available buffer at the same
time as finding the string length. Only if the string didn't fit the
available space is it necessary to extend the log and format the string
again to a new fragment buffer.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 lib/kunit/test.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index b00f077314e3..e7f0a46d184a 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -196,11 +196,21 @@ void kunit_log_append(struct list_head *log, const char *fmt, ...)
 	if (!log)
 		return;
 
-	/* Evaluate length of line to add to log */
+	frag = list_last_entry(log, struct kunit_log_frag, list);
+	log_len = strlen(frag->buf);
+	len_left = sizeof(frag->buf) - log_len - 1;
+
+	/* Attempt to print formatted line to current fragment */
 	va_start(args, fmt);
-	len = vsnprintf(NULL, 0, fmt, args) + 1;
+	len = vsnprintf(frag->buf + log_len, len_left, fmt, args) + 1;
 	va_end(args);
 
+	if (len <= len_left)
+		goto out_newline;
+
+	/* Abandon the truncated result of vsnprintf */
+	frag->buf[log_len] = '\0';
+
 	if (len > sizeof(frag->buf) - 1) {
 		va_start(args, fmt);
 		tmp = kvasprintf(GFP_KERNEL, fmt, args);
@@ -212,24 +222,15 @@ void kunit_log_append(struct list_head *log, const char *fmt, ...)
 		return;
 	}
 
-	frag = list_last_entry(log, struct kunit_log_frag, list);
-	log_len = strlen(frag->buf);
-	len_left = sizeof(frag->buf) - log_len - 1;
-
-	if (len > len_left) {
-		frag = kunit_log_extend(log);
-		if (!frag)
-			return;
-
-		len_left = sizeof(frag->buf) - 1;
-		log_len = 0;
-	}
+	frag = kunit_log_extend(log);
+	if (!frag)
+		return;
 
 	/* Print formatted line to the log */
 	va_start(args, fmt);
-	vsnprintf(frag->buf + log_len, min(len, len_left), fmt, args);
+	vsnprintf(frag->buf, sizeof(frag->buf) - 1, fmt, args);
 	va_end(args);
-
+out_newline:
 	/* Add newline to end of log if not already present. */
 	kunit_log_newline(frag);
 }
-- 
2.30.2

