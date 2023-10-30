Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8169F7DB86F
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 11:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjJ3KsE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 06:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjJ3KsD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 06:48:03 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9211E9;
        Mon, 30 Oct 2023 03:47:57 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39U5v5tC004206;
        Mon, 30 Oct 2023 05:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=9
        sJHJNvpeHCSQtuFmI1rXyyT6mj/StcEuPaBnCXdF3I=; b=Eawuq+41XtUvpyLDB
        GocuVetWVTaIapFYEHTYC89ueUP3CLf1mCwBuzwtfyEdPwvgM2yFqekTHztxy3iN
        X2SvFrtV0StqrfpNiu1256DPK1LlrLC6ybxoVmnzUji6o12LCnj3HMeDTAczgDir
        LBc0T6sZTD7R8ejwKGZBwqEmTZJJP91fCcphiBwc1uDNrsMjzvB2c+GZz+l3/HVb
        Uya46OMf3oqMUh10eg/92/PgrfyJdUdTx9PX4TQbZlS34/OL8W8cfjtTwazQe2RS
        HyNFDfjS06YMDdQ7leptlR44E/hiJThwMcSSLQKJTE45DpnhGMWaljfK+SLd/5Ka
        z4jEA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3u0xqhk04v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 05:47:47 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 10:47:46 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Mon, 30 Oct 2023 10:47:46 +0000
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.82])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 09CBD11AB;
        Mon, 30 Oct 2023 10:47:46 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH RESEND] kunit: string-stream: Allow ERR_PTR to be passed to string_stream_destroy()
Date:   Mon, 30 Oct 2023 10:47:46 +0000
Message-ID: <20231030104746.241414-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RMOWkfwHyhs4BOM_r5Gq0jWBQkyDCvTn
X-Proofpoint-GUID: RMOWkfwHyhs4BOM_r5Gq0jWBQkyDCvTn
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
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

