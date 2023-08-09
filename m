Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD6477647A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 17:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjHIPzF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 11:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjHIPzC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 11:55:02 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C221FF9;
        Wed,  9 Aug 2023 08:55:02 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 379CrDUe002197;
        Wed, 9 Aug 2023 10:54:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=EkcWozHmMlEsGAMvpqTB6x4BhQ+VCXW9AKlqr4C/ae0=; b=
        QUwF7ePHeVV7H0l2vQRS4JY92j3wj/W1O7Xe3tEdSzIIm15kxPQuwXGEs7tnCZan
        RozNdNAZFcuB3YvbSB2jb0ESmoEYM9xwmKFyXnEUzqCwhQbgpFda7JloNbH7cNlD
        TuuCqTbe3CSTZwN1yjlcvoEGAnvwkvktbnoV/Jr88QBuMq0/rnh9z+DluI8Q7df5
        dQd8oXqUYLYxMdpy7yBXbYxOduinSDXacFiIv2pe9pbyHAzcP6/jeq8zlTQyRU1S
        T/xZQpg96BOqh6HzVvp6A1+3lgLn2m589oSxcjNHVlBuLjcR463Fjik0w1Etj/G8
        t1n4YAvd6v+geH5f6haSzw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sb7vtanrr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 10:54:51 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 16:54:48 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Wed, 9 Aug 2023 16:54:48 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 68A0245D;
        Wed,  9 Aug 2023 15:54:48 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 7/7] kunit: Don't waste first attempt to format string in kunit_log_append()
Date:   Wed, 9 Aug 2023 16:54:38 +0100
Message-ID: <20230809155438.22470-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230809155438.22470-1-rf@opensource.cirrus.com>
References: <20230809155438.22470-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YESuJiL3msWuAJAE0qtyL58LJfr7ndi-
X-Proofpoint-ORIG-GUID: YESuJiL3msWuAJAE0qtyL58LJfr7ndi-
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
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
index 28d0048d6171..230ec5e9824f 100644
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

