Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF6E7B0AA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjI0QvQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 12:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0QvP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 12:51:15 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28EF9C;
        Wed, 27 Sep 2023 09:51:13 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38RGf4a4009144;
        Wed, 27 Sep 2023 11:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=6
        6YwtrVPB63m73rzfrkXNgTtu4wVWf9hd6q5sRDERfc=; b=qXvYGkq/xQtDPr0ut
        UyCW1PJVEAA5IoA7TwFPqD80tzMyREgOIAMDqm5qL7EKlvbIE9UzD3hBQypP59+Y
        cnTPids4PNVEbe4QxCXM0KDPMHIuGYYNDJAOjVce3TFLqfBKRhstOgipajcPzJhs
        Iuqi0QBHmqxvfmkVNK8hS/XSJpH14GJyP4BfC0EokLKyK0XZ9TtxXMgTllemtJ+X
        MZ+yw9c3+wEcwxIrxOVqMFRuo6jrGXqOrGxMe3rhs6AJG0DXnY16LQA2nQyqb499
        WHatROUrqOJS3r3cy9I+Si4PRuCRxa1smBII/gUKSO3gWpM92ZQ/VJu+sgWnrXRn
        GnQFw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t9vejd1ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 11:51:03 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 27 Sep
 2023 17:51:01 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 27 Sep 2023 17:51:01 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.112])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5998E15B9;
        Wed, 27 Sep 2023 16:51:01 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] kunit: debugfs: Handle errors from alloc_string_stream()
Date:   Wed, 27 Sep 2023 17:50:58 +0100
Message-ID: <20230927165058.29484-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RA6cTYiBvohA6WeMlQ8Tn2N_krYxb87g
X-Proofpoint-ORIG-GUID: RA6cTYiBvohA6WeMlQ8Tn2N_krYxb87g
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
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
---
 lib/kunit/debugfs.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 270d185737e6..73075ca6e88c 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -109,14 +109,27 @@ static const struct file_operations debugfs_results_fops = {
 void kunit_debugfs_create_suite(struct kunit_suite *suite)
 {
 	struct kunit_case *test_case;
+	struct string_stream *stream;
 
-	/* Allocate logs before creating debugfs representation. */
-	suite->log = alloc_string_stream(GFP_KERNEL);
-	string_stream_set_append_newlines(suite->log, true);
+	/*
+	 * Allocate logs before creating debugfs representation.
+	 * The log pointer must be NULL if there isn't a log so only
+	 * set it if the log stream was created successfully.
+	 */
+	stream = alloc_string_stream(GFP_KERNEL);
+	if (IS_ERR_OR_NULL(stream))
+		goto err;
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
@@ -124,6 +137,12 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
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

