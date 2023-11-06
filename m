Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275757E2AEE
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 18:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjKFR0T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 12:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjKFR0S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 12:26:18 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A679D4C;
        Mon,  6 Nov 2023 09:26:15 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A6BpQjA023965;
        Mon, 6 Nov 2023 11:26:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=W
        cST5ABue6IsnqHZV3oTaKyNlMPnd8YrlPpC3JsEA1s=; b=fppnJUVeNOZreU1ns
        nZmlYmeX8N4Sywn/qpHEHAkjLiY7OHuM6gZ/BqrhFf46ms/Zh8LHdWSJvK0TUs/9
        o/lYWjVh0wTQIMzBHkM1VwBWPbaI+cu/K7pdRydqNpXjGH+RsKsfP1LwffccX8DD
        R+pbmSBqxIUS3oSO70zZTQIYmzbq4lRJACDWPR1XZsBCBNCZ8uizajtA6WNKoZwh
        GpSmcj4oyrZIlDlkGTEE9UsmFaFKuBL9SxvDVLEOS3DJndlnvr1+VcEDuCwHLbXl
        cpA7/hDQ9i3rrWETrLOyWvX9JBxLnbVfGRwfzmVYpmeLBKYxiRP3pDGS5h5Qbe8A
        Ji2pw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3u5jcj25x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 11:26:01 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 6 Nov
 2023 17:26:00 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Mon, 6 Nov 2023 17:26:00 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.48])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B9A76B38;
        Mon,  6 Nov 2023 17:25:59 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] kunit: test: Avoid cast warning when adding kfree() as an action
Date:   Mon, 6 Nov 2023 17:25:57 +0000
Message-ID: <20231106172557.2963-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qCaErWCKZ_38yqtY9gdJk2PPOYzLMSZk
X-Proofpoint-ORIG-GUID: qCaErWCKZ_38yqtY9gdJk2PPOYzLMSZk
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In kunit_log_test() pass the kfree_wrapper() function to kunit_add_action()
instead of directly passing kfree().

This prevents a cast warning:

lib/kunit/kunit-test.c:565:25: warning: cast from 'void (*)(const void *)'
to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible
function type [-Wcast-function-type-strict]

   564		full_log = string_stream_get_string(test->log);
 > 565		kunit_add_action(test, (kunit_action_t *)kfree, full_log);

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311070041.kWVYx7YP-lkp@intel.com/
Fixes: 05e2006ce493 ("kunit: Use string_stream for test log")
---
 lib/kunit/kunit-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 99d2a3a528e1..de2113a58fa0 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -562,7 +562,7 @@ static void kunit_log_test(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, test->log->append_newlines);
 
 	full_log = string_stream_get_string(test->log);
-	kunit_add_action(test, (kunit_action_t *)kfree, full_log);
+	kunit_add_action(test, kfree_wrapper, full_log);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
 				     strstr(full_log, "put this in log."));
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-- 
2.30.2

