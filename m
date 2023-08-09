Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F9077647B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 17:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjHIPzE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 11:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbjHIPzC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 11:55:02 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF331FF7;
        Wed,  9 Aug 2023 08:55:02 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 379CrDUd002197;
        Wed, 9 Aug 2023 10:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=s7GI22R3yH/vG/yzGrHV/vPELeeEUsf/yheeCZUF8g0=; b=
        VdX++k4bPy2xRwMBr/eJrWj5Qjcocf31cRQrN3ESC/4IWY7EV2wpkjXBrABljzgu
        qNAejUibJFwzwZtpuKElw6Ugf/PfWwgNCjW5Jtbxsf4PPpwJ2W1FoRUMgvVxYGQ2
        HeXHHY6ZhBr+Si98LEphpNaIzhPiV3gA6RJ8gcWCIbUvw7yXOnbiC/L4CxsZacvK
        GdmOFBja6GfEM8BBqTzNcmGUVmdhlfTGI9qxgd1i/fWXJvPIG7SaxvIguG5T0Qn0
        CMFe1m4n6B5jcl42YH5+01gtEDozaKDDX2jFK/NrfsS8slKWV+/bt4VLxqsereCt
        Q9Ig8HUhG3CtoBcUar2Xag==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sb7vtanrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 10:54:50 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 16:54:48 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Wed, 9 Aug 2023 16:54:48 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 01D95475;
        Wed,  9 Aug 2023 15:54:47 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 6/7] kunit: kunit-test: Add test of logging only a newline
Date:   Wed, 9 Aug 2023 16:54:37 +0100
Message-ID: <20230809155438.22470-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230809155438.22470-1-rf@opensource.cirrus.com>
References: <20230809155438.22470-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YMGL8l3INJVl6RSBMdHNKl7pkBt4r9hm
X-Proofpoint-ORIG-GUID: YMGL8l3INJVl6RSBMdHNKl7pkBt4r9hm
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test that logging a string containing only a newline appends
one newline to the log.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 lib/kunit/kunit-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index c079550c3afd..7e710c73c7e5 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -627,6 +627,12 @@ static void kunit_log_newline_test(struct kunit *test)
 		kunit_init_log_frag(frag);
 		list_add_tail(&frag->list, suite.log);
 
+		/* Log only a newline */
+		kunit_log_append(suite.log, "\n");
+		KUNIT_EXPECT_TRUE(test, list_is_singular(suite.log));
+		KUNIT_EXPECT_STREQ(test, frag->buf, "\n");
+		frag->buf[0] = '\0';
+
 		/* String that exactly fills fragment leaving no room for \n */
 		memset(frag->buf, 0, sizeof(frag->buf));
 		memset(frag->buf, 'x', sizeof(frag->buf) - 9);
-- 
2.30.2

