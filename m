Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA687B182E
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 12:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjI1KWq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 06:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjI1KWq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 06:22:46 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9EB126;
        Thu, 28 Sep 2023 03:22:44 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38S80lYA010994;
        Thu, 28 Sep 2023 05:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=9
        sJHJNvpeHCSQtuFmI1rXyyT6mj/StcEuPaBnCXdF3I=; b=fao53BD6QBhib8sGf
        WFHc4DS+atw/TqawFdnjaADQ69YcWZvlpdjSZZXuxwzLo2H1/FuzDNqL4sx/FWkv
        3iGvKUcHzuaGKY8N11levDzrqdE5gqRyN90TprjQpBC59FkQjZDUB56hb+Vn56Ni
        oOvcc9Fq8ICCY2uJE288vjI82eUYa82+0/HzImpXj0u9oAz5Jtu/Z63I99EYyvS9
        PXn+MHRzE+w9xR8H/Wzm3CQExxrlPU3jvE8ASz+CmYfg9NAlQUeKBpYcWSChBQjB
        yf9hThXeRI1lP530GytUE9AJbe7SUpDgWSQyzEqRtyGLTvQ33XwmogYhDSsX1xAo
        B1bEw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t9wdxqa1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 05:22:26 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 28 Sep
 2023 11:22:24 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Thu, 28 Sep 2023 11:22:24 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.13])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6B5A011AB;
        Thu, 28 Sep 2023 10:22:24 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] kunit: string-stream: Allow ERR_PTR to be passed to string_stream_destroy()
Date:   Thu, 28 Sep 2023 11:22:24 +0100
Message-ID: <20230928102224.3842035-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LW8dCchv8JxjJrq8mlPiw3Vo5SDVwOfl
X-Proofpoint-GUID: LW8dCchv8JxjJrq8mlPiw3Vo5SDVwOfl
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Check the stream pointer passed to string_stream_destroy() for
IS_ERR_OR_NULL() instead of only NULL.

Whatever alloc_string_stream() returns should be safe to pass
to string_stream_destroy(), and that will be an ERR_PTR.

It's obviously good practise and generally helpful to also check
for NULL pointers so that client cleanup code can call
string_stream_destroy() unconditionally - which could include
pointers that have never been set to anything and so are NULL.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 lib/kunit/string-stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index a6f3616c2048..54f4fdcbfac8 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -173,7 +173,7 @@ void string_stream_destroy(struct string_stream *stream)
 {
 	KUNIT_STATIC_STUB_REDIRECT(string_stream_destroy, stream);
 
-	if (!stream)
+	if (IS_ERR_OR_NULL(stream))
 		return;
 
 	string_stream_clear(stream);
-- 
2.30.2

