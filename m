Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F7E5B7EC4
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 03:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiINB6S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Sep 2022 21:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiINB6R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Sep 2022 21:58:17 -0400
X-Greylist: delayed 130 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Sep 2022 18:58:16 PDT
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8463A4B8
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Sep 2022 18:58:16 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="76247790"
X-IronPort-AV: E=Sophos;i="5.93,313,1654527600"; 
   d="scan'208";a="76247790"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 14 Sep 2022 10:55:05 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 107B7B63B4;
        Wed, 14 Sep 2022 10:55:04 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4EF9AE6751;
        Wed, 14 Sep 2022 10:55:03 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 24203403E058D;
        Wed, 14 Sep 2022 10:55:03 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH 2/5] selftests/resctrl: Clear unused common codes called by CAT/MBA tests
Date:   Wed, 14 Sep 2022 10:51:44 +0900
Message-Id: <20220914015147.3071025-4-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In CAT/MBA(allocation) tests, function write_schemata() is used to
change the percentage of schemata.
In CMT/MBM(monitoring) tests schemata only need to be set 100% once,
and the default value of schemata is 100% which is set by executing
mount/umout resctrl filesystem.
In addition, write_schemata() was not currently called from CMT.

Clean up unused CMT-related processing in function write_schemata().

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 6f543e470ad4..349dce00472f 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -498,8 +498,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	FILE *fp;
 
 	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
-	    strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) &&
-	    strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
+	    strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
 		return -ENOENT;
 
 	if (!schemata) {
@@ -520,8 +519,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	else
 		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
 
-	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
-	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
+	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
 		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
 	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)))
 		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
-- 
2.27.0

