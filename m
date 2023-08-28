Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A852D78ACB7
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 12:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjH1KmH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 06:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjH1Klh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 06:41:37 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFAA115;
        Mon, 28 Aug 2023 03:41:34 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37SABUG0018563;
        Mon, 28 Aug 2023 05:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=IsHcCogZc9nE42h+SI2xzyi4lTBdJGLSQUlVKBv73fs=; b=
        WToMHWgPd4AyrJRaj7ZCeF0zVt9k/GDSrVDzmnKw2ITdLjsg71CUugcoR59w72x5
        HRqp0KFrJwpwrpMtCF/++/F9MDfxF2iYsgvqscF59/nC0fb4qf8Th4kE8rUaMybw
        a0DNNi9Oxhh+vaWHwW8zwhVtoA/MJmBlrt+rbtuN0JVZMe/bZNrpD9vtwrXy1MNt
        POprDI8h3Go8t8NqL9Qy3uzLG3BOhecg1dmhABW1FqIDdpH0Zj2Vx7a+dFsUuutS
        8fzGch14p4zlI/3GwiQz4x0VUc9LTWSb1KUV/bdZKnfNBkzdXqvO2/BLsFPSbNhq
        DcNkbb2CuiquTDZv3Q1imQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesya0ma-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 05:41:15 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 28 Aug
 2023 11:41:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 28 Aug 2023 11:41:12 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 29A86357C;
        Mon, 28 Aug 2023 10:41:12 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v6 03/10] kunit: string-stream: Add option to make all lines end with newline
Date:   Mon, 28 Aug 2023 11:41:04 +0100
Message-ID: <20230828104111.2394344-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230828104111.2394344-1-rf@opensource.cirrus.com>
References: <20230828104111.2394344-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: t6JTTp5vQFjgRnY7pKLnr4HSlagLmyCM
X-Proofpoint-GUID: t6JTTp5vQFjgRnY7pKLnr4HSlagLmyCM
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add an optional feature to string_stream that will append a newline to
any added string that does not already end with a newline. The purpose
of this is so that string_stream can be used to collect log lines.

This is enabled/disabled by calling string_stream_set_append_newlines().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 lib/kunit/string-stream.c | 28 +++++++++++++++++++++-------
 lib/kunit/string-stream.h |  7 +++++++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index ed24d86af9f5..1dcf6513b692 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -44,32 +44,46 @@ int string_stream_vadd(struct string_stream *stream,
 		       va_list args)
 {
 	struct string_stream_fragment *frag_container;
-	int len;
+	int buf_len, result_len;
 	va_list args_for_counting;
 
 	/* Make a copy because `vsnprintf` could change it */
 	va_copy(args_for_counting, args);
 
 	/* Evaluate length of formatted string */
-	len = vsnprintf(NULL, 0, fmt, args_for_counting);
+	buf_len = vsnprintf(NULL, 0, fmt, args_for_counting);
 
 	va_end(args_for_counting);
 
-	if (len == 0)
+	if (buf_len == 0)
 		return 0;
 
+	/* Reserve one extra for possible appended newline. */
+	if (stream->append_newlines)
+		buf_len++;
+
 	/* Need space for null byte. */
-	len++;
+	buf_len++;
 
 	frag_container = alloc_string_stream_fragment(stream->test,
-						      len,
+						      buf_len,
 						      stream->gfp);
 	if (IS_ERR(frag_container))
 		return PTR_ERR(frag_container);
 
-	len = vsnprintf(frag_container->fragment, len, fmt, args);
+	if (stream->append_newlines) {
+		/* Don't include reserved newline byte in writeable length. */
+		result_len = vsnprintf(frag_container->fragment, buf_len - 1, fmt, args);
+
+		/* Append newline if necessary. */
+		if (frag_container->fragment[result_len - 1] != '\n')
+			result_len = strlcat(frag_container->fragment, "\n", buf_len);
+	} else {
+		result_len = vsnprintf(frag_container->fragment, buf_len, fmt, args);
+	}
+
 	spin_lock(&stream->lock);
-	stream->length += len;
+	stream->length += result_len;
 	list_add_tail(&frag_container->node, &stream->fragments);
 	spin_unlock(&stream->lock);
 
diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
index b669f9a75a94..048930bf97f0 100644
--- a/lib/kunit/string-stream.h
+++ b/lib/kunit/string-stream.h
@@ -25,6 +25,7 @@ struct string_stream {
 	spinlock_t lock;
 	struct kunit *test;
 	gfp_t gfp;
+	bool append_newlines;
 };
 
 struct kunit;
@@ -47,4 +48,10 @@ bool string_stream_is_empty(struct string_stream *stream);
 
 void string_stream_destroy(struct string_stream *stream);
 
+static inline void string_stream_set_append_newlines(struct string_stream *stream,
+						     bool append_newlines)
+{
+	stream->append_newlines = append_newlines;
+}
+
 #endif /* _KUNIT_STRING_STREAM_H */
-- 
2.30.2

