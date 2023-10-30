Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B017DB871
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 11:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjJ3KsR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 06:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjJ3KsP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 06:48:15 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3164B3;
        Mon, 30 Oct 2023 03:48:05 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39U5NJmt019400;
        Mon, 30 Oct 2023 05:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=p
        tuXmZ2hqF+4cAMHCMtuZ+jtvOIi1tvA4FTQu+eJeZY=; b=d03p7Fq/26I1I7p8x
        +HzGi8+op9McZ9k3gqqazGHw7pTqGGiLgitxeqN0Q+GmJJJRCIv+wInIA37rV44e
        oFIGSAUu3UBzpQmfPUy9sxnFJL4ImLV6jcgxpckmkC2bl3oMBDrH9WTtUkMLKStU
        BgacqS+yyK4Bnv6Vh3Ewzik/KH1RAo0SmLGv9ogal92Myk2ZLB0YG/BZ6y509xdE
        ZQW0egYuKJI908uXoHi1qnf3Apl7z5oM4lcZW9CrzKw3kysoaFXknYkRF43Cy5v2
        5v4WV3k1iLBFYWtPkwet+wqtccqPTAcXd8/H4NcXZDO0Q/iXIn8NdDkjkCXN9Vf4
        oc9Kw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3u0ypxay71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 05:48:00 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 10:47:58 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Mon, 30 Oct 2023 10:47:58 +0000
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.82])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4580911AB;
        Mon, 30 Oct 2023 10:47:58 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH RESEND] kunit: debugfs: Fix unchecked dereference in debugfs_print_results()
Date:   Mon, 30 Oct 2023 10:47:58 +0000
Message-ID: <20231030104758.241472-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: e-QvDM-tsvIRroqT8mU1PgWB9N0O7hQW
X-Proofpoint-ORIG-GUID: e-QvDM-tsvIRroqT8mU1PgWB9N0O7hQW
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Move the call to kunit_suite_has_succeeded() after the check that
the kunit_suite pointer is valid.

This was found by smatch:

 lib/kunit/debugfs.c:66 debugfs_print_results() warn: variable
 dereferenced before check 'suite' (see line 63)

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 38289a26e1b8 ("kunit: fix debugfs code to use enum kunit_status, not bool")
---
 lib/kunit/debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 9d167adfa746..382706dfb47d 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -60,12 +60,14 @@ static void debugfs_print_result(struct seq_file *seq, struct string_stream *log
 static int debugfs_print_results(struct seq_file *seq, void *v)
 {
 	struct kunit_suite *suite = (struct kunit_suite *)seq->private;
-	enum kunit_status success = kunit_suite_has_succeeded(suite);
+	enum kunit_status success;
 	struct kunit_case *test_case;
 
 	if (!suite)
 		return 0;
 
+	success = kunit_suite_has_succeeded(suite);
+
 	/* Print KTAP header so the debugfs log can be parsed as valid KTAP. */
 	seq_puts(seq, "KTAP version 1\n");
 	seq_puts(seq, "1..1\n");
-- 
2.30.2

