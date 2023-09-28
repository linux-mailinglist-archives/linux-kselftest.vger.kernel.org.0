Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7A67B1807
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 12:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjI1KE6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 06:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjI1KE5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 06:04:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF20018F;
        Thu, 28 Sep 2023 03:04:55 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38S80lWv010994;
        Thu, 28 Sep 2023 05:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=i
        Iyz/euTFeo8nmj3vOuQ+QOI6OinJLYiG51sJtcu8dU=; b=RhLKZs2VweWxTPB77
        TPS4TCLNgJkA403UNnPBXbkY89b1KTLbDv/1ltmH325SM+8upyvx+i3mgJtXXUPB
        sjFFA09Yvyu7xRlzlOkch/XlEvEYH2XACnsd0208Aqw/oR6pgksyfeI1TF8wVckg
        9k+agfqULl2SgUYH/ZIt47B8MNJpi28H3iA0HOtPeRcArr+rwUZDEyUB3UHIWEKd
        6nPF9YD4Id1m4pmY6g9bGaAE0AW37OTDpUETAubBEinazivr4oWFHzDp1L4L7Dkj
        HVj0SaQDElfnAOciEVErVhlBYVuYV41WF3yhWa+aeWbH0Y4hnAL6oo0AhFf4+TiW
        HmWFA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t9wdxq9ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 05:04:34 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 28 Sep
 2023 11:04:32 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Thu, 28 Sep 2023 11:04:32 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.13])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 34CC011AB;
        Thu, 28 Sep 2023 10:04:32 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2] kunit: debugfs: Handle errors from alloc_string_stream()
Date:   Thu, 28 Sep 2023 11:04:32 +0100
Message-ID: <20230928100432.3831109-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dwFo2pgjWhloPjvBqQYnewaTWwSV2Xga
X-Proofpoint-GUID: dwFo2pgjWhloPjvBqQYnewaTWwSV2Xga
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In kunit_debugfs_create_suite() give up and skip creating the debugfs
file if any of the alloc_string_stream() calls return an error or NULL.
Only put a value in the log pointer of kunit_suite and kunit_test if it
is a valid pointer to a log.

This prevents the potential invalid dereference reported by smatch:

 lib/kunit/debugfs.c:115 kunit_debugfs_create_suite() error: 'suite->log'
	dereferencing possible ERR_PTR()
 lib/kunit/debugfs.c:119 kunit_debugfs_create_suite() error: 'test_case->log'
	dereferencing possible ERR_PTR()

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 05e2006ce493 ("kunit: Use string_stream for test log")
Reviewed-by: Rae Moar <rmoar@google.com>
---
Changes from V1:
- If the alloc_string_stream() for the suite->log fails
  just return. Nothing has been created at this point so
  there's nothing to clean up.
- Re-word the explanation of why the log pointers are only
  set if they point to a valid log.

As these changes are trivial I've carried Rae Moar's
Reviewed-by from V1.
---
 lib/kunit/debugfs.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 270d185737e6..9d167adfa746 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -109,14 +109,28 @@ static const struct file_operations debugfs_results_fops = {
 void kunit_debugfs_create_suite(struct kunit_suite *suite)
 {
 	struct kunit_case *test_case;
+	struct string_stream *stream;
 
-	/* Allocate logs before creating debugfs representation. */
-	suite->log = alloc_string_stream(GFP_KERNEL);
-	string_stream_set_append_newlines(suite->log, true);
+	/*
+	 * Allocate logs before creating debugfs representation.
+	 * The suite->log and test_case->log pointer are expected to be NULL
+	 * if there isn't a log, so only set it if the log stream was created
+	 * successfully.
+	 */
+	stream = alloc_string_stream(GFP_KERNEL);
+	if (IS_ERR_OR_NULL(stream))
+		return;
+
+	string_stream_set_append_newlines(stream, true);
+	suite->log = stream;
 
 	kunit_suite_for_each_test_case(suite, test_case) {
-		test_case->log = alloc_string_stream(GFP_KERNEL);
-		string_stream_set_append_newlines(test_case->log, true);
+		stream = alloc_string_stream(GFP_KERNEL);
+		if (IS_ERR_OR_NULL(stream))
+			goto err;
+
+		string_stream_set_append_newlines(stream, true);
+		test_case->log = stream;
 	}
 
 	suite->debugfs = debugfs_create_dir(suite->name, debugfs_rootdir);
@@ -124,6 +138,12 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
 	debugfs_create_file(KUNIT_DEBUGFS_RESULTS, S_IFREG | 0444,
 			    suite->debugfs,
 			    suite, &debugfs_results_fops);
+	return;
+
+err:
+	string_stream_destroy(suite->log);
+	kunit_suite_for_each_test_case(suite, test_case)
+		string_stream_destroy(test_case->log);
 }
 
 void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
-- 
2.30.2

