Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EA77DB86D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 11:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjJ3Krz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 06:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjJ3Krx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 06:47:53 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9569C9;
        Mon, 30 Oct 2023 03:47:50 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39U612R1032696;
        Mon, 30 Oct 2023 05:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=N
        kjnRUFCqAWqmRd8TZFPGqSu7yQpHb4x+ERWcyrzClg=; b=nRXJPiP7SObKLRdYB
        eAcQTLpPoQLAvXApUAmg9Ij3hAlFXMveCmLforiuwNJIu1i8FyU7GzMzHnG9fWnE
        y5LEkSe558YpQhgdHc5vLvDhXwaK4D6g+nxyKoCiP6HAAbme2/ZJ9v/6XL7TDVr/
        KABrGu0X6xYKWynNr4wwO7hNahpXN6VlWY7eW/Vq+bXT8yuQxLrlborbcjRWJAF7
        ++RE91twPt0j+6YZgdGf4S5AuodbqA3UHvwEeznXw6OJq3IQmLj4fZ2L2nZRQdof
        c2KJN2mb0Ur/+WL006NVSI1LrNme8LD+iDPSwTP41mEVBw6u2Ej2KPzclJ9B8vFg
        UseIw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3u0ypxay6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 05:47:34 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 10:47:32 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Mon, 30 Oct 2023 10:47:32 +0000
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.82])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3621811AB;
        Mon, 30 Oct 2023 10:47:32 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2 RESEND] kunit: debugfs: Handle errors from alloc_string_stream()
Date:   Mon, 30 Oct 2023 10:47:32 +0000
Message-ID: <20231030104732.241339-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 549nZg4elloeUtvQIK1wKsk8q2C8c3if
X-Proofpoint-ORIG-GUID: 549nZg4elloeUtvQIK1wKsk8q2C8c3if
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

