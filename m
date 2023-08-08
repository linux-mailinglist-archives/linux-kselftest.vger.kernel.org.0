Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11170773CAC
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjHHQIr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjHHQG5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:06:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303AB72B9;
        Tue,  8 Aug 2023 08:45:58 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 378CIdoR005342;
        Tue, 8 Aug 2023 07:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=borUz3+VefVCpATITwUMnBd9+od/g4pGsJIfb5Jw47M=; b=
        hH+Rz+iUusN9POr1S0eKxSMvEbeDhEuHhxrjK7B7xgjQN5suVaAVGeS7siU1nJKE
        McdZ00cHUq9YB07sq0DRRf8jqHnJCbJ3iPmnvs0XrBWQdNuBzTaPJ01nCX+DmcvG
        UQiNV+L/yXsqKHGQem3B8capb170IwsXWeNf3s+uxvDN04KGN+6/wwDOUC5WqzK7
        37OSHqKTBmXJeENb3GjW5Ehr12alro+4zvXmJgmGJs3FjNRwYz8NcZ+1xgM6ze0W
        bSXhidfDmoR/RJubB4Z/hDDTPhCZwrkFgFVtDqye87BBlRKJ2x9Y6z47OkaQOvq+
        0tmfwnNy9hz7sPD0Wa9cfg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhtjv4-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 07:35:36 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 13:35:34 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 8 Aug 2023 13:35:34 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 000B015B4;
        Tue,  8 Aug 2023 12:35:33 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 5/6] kunit: kunit-test: Add test of logging only a newline
Date:   Tue, 8 Aug 2023 13:35:28 +0100
Message-ID: <20230808123529.4725-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230808123529.4725-1-rf@opensource.cirrus.com>
References: <20230808123529.4725-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: o_vKgZy7nYdYophLMrm6peb-vY_dkOju
X-Proofpoint-ORIG-GUID: o_vKgZy7nYdYophLMrm6peb-vY_dkOju
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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
index 621acdb5385e..ce80fb42128c 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -613,6 +613,12 @@ static void kunit_log_newline_test(struct kunit *test)
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

