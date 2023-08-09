Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85901776474
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 17:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjHIPzB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 11:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHIPy7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 11:54:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC37C1FF7;
        Wed,  9 Aug 2023 08:54:58 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 379EvsGM002928;
        Wed, 9 Aug 2023 10:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=DDCtGnfmnKq7ILJAU5g3N9JLIdMJV17LdpZOS4jquIw=; b=
        B03avQJTuJfS7ZeT+c2bndSNYO2fKXdJ8OhjBgY1Jo49oKvVZXBqRRm+xgsVAySI
        OffwD8LZrDMo51pJpOq8Apv3zCIbDZogaFXVtpmOhSC1QSg/XMaMKCo206t4cDYk
        wm4UgwYUPu9G3t9KPLgtt3igK5pjquD+IV63vuxDd+J34H5GeS7W/nm5+JA51IOk
        MsDSHhRzzZIiRHFaGw4gDzH4N0QXojzZ9Yd7wQNNKI5kkYamX70GgGvzdGlRmyGF
        iq0HfVgID0XCl13N2fj5s0D935i3jPwbA6V19dZm5uAzC047RHUeyBQxm8oOd1/I
        mTSjJE+jL2ioVkcUQQapow==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhuvg7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 10:54:49 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 16:54:47 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Wed, 9 Aug 2023 16:54:47 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9C5DA475;
        Wed,  9 Aug 2023 15:54:46 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 3/7] kunit: Handle logging of lines longer than the fragment buffer size
Date:   Wed, 9 Aug 2023 16:54:34 +0100
Message-ID: <20230809155438.22470-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230809155438.22470-1-rf@opensource.cirrus.com>
References: <20230809155438.22470-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: x29uRc4_XgSSpCXH0mU_RayOJCfp_0a6
X-Proofpoint-ORIG-GUID: x29uRc4_XgSSpCXH0mU_RayOJCfp_0a6
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add handling to kunit_log_append() for log messages that are longer than
a single buffer fragment.

The initial implementation of fragmented buffers did not change the logic
of the original kunit_log_append(). A consequence was that it still had
the original assumption that a log line will fit into one buffer.

This patch checks for log messages that are larger than one fragment
buffer. In that case, kvasprintf() is used to format it into a temporary
buffer and that content is then split across as many fragments as
necessary.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 lib/kunit/test.c | 65 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index dfe51bc2b387..28d0048d6171 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -140,25 +140,82 @@ static struct kunit_log_frag *kunit_log_extend(struct list_head *log)
 	return frag;
 }
 
+static void kunit_log_append_string(struct list_head *log, const char *src)
+{
+	struct kunit_log_frag *frag, *new_frag;
+	int log_len, bytes_left;
+	ssize_t written;
+	char *p;
+
+	frag = list_last_entry(log, struct kunit_log_frag, list);
+	log_len = strlen(frag->buf);
+	bytes_left = sizeof(frag->buf) - log_len;
+
+	written = strscpy(frag->buf + log_len, src, bytes_left);
+	if (written != -E2BIG)
+		goto newline;
+
+	src += bytes_left - 1;
+	do {
+		new_frag = kunit_log_extend(log);
+		if (!new_frag)
+			goto newline;
+
+		frag = new_frag;
+		written = strscpy(frag->buf, src, sizeof(frag->buf));
+		src += sizeof(frag->buf) - 1;
+	} while (written == -E2BIG);
+
+newline:
+	if (written == -E2BIG)
+		written = strlen(frag->buf);
+
+	p = &frag->buf[written - 1];
+	if (*p != '\n') {
+		if (strlcat(frag->buf, "\n", sizeof(frag->buf)) >= sizeof(frag->buf)) {
+			frag = kunit_log_extend(log);
+			if (!frag) {
+				*p = '\n';
+				return;
+			}
+
+			frag->buf[0] = '\n';
+			frag->buf[1] = '\0';
+		}
+	}
+}
+
 /* Append formatted message to log, extending the log buffer if necessary. */
 void kunit_log_append(struct list_head *log, const char *fmt, ...)
 {
 	va_list args;
 	struct kunit_log_frag *frag;
 	int len, log_len, len_left;
+	char *tmp = NULL;
 
 	if (!log)
 		return;
 
-	frag = list_last_entry(log, struct kunit_log_frag, list);
-	log_len = strlen(frag->buf);
-	len_left = sizeof(frag->buf) - log_len - 1;
-
 	/* Evaluate length of line to add to log */
 	va_start(args, fmt);
 	len = vsnprintf(NULL, 0, fmt, args) + 1;
 	va_end(args);
 
+	if (len > sizeof(frag->buf) - 1) {
+		va_start(args, fmt);
+		tmp = kvasprintf(GFP_KERNEL, fmt, args);
+		va_end(args);
+
+		kunit_log_append_string(log, tmp);
+		kfree(tmp);
+
+		return;
+	}
+
+	frag = list_last_entry(log, struct kunit_log_frag, list);
+	log_len = strlen(frag->buf);
+	len_left = sizeof(frag->buf) - log_len - 1;
+
 	if (len > len_left) {
 		frag = kunit_log_extend(log);
 		if (!frag)
-- 
2.30.2

