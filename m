Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255645B7EB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 03:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiINBzI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Sep 2022 21:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiINBzG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Sep 2022 21:55:06 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA97822500;
        Tue, 13 Sep 2022 18:55:04 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="67233255"
X-IronPort-AV: E=Sophos;i="5.93,313,1654527600"; 
   d="scan'208";a="67233255"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 14 Sep 2022 10:55:01 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 761CDDA69A;
        Wed, 14 Sep 2022 10:55:00 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id B355DD996F;
        Wed, 14 Sep 2022 10:54:59 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 997BC403DF707;
        Wed, 14 Sep 2022 10:54:59 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH 1/5] selftests/resctrl: Clear unused initalization code in MBM tests
Date:   Wed, 14 Sep 2022 10:51:42 +0900
Message-Id: <20220914015147.3071025-2-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a comment "Set up shemata with 100% allocation on the first run"
in function mbm_setup(), but the condition "num_of_runs == 0" will
never be met and write_schemata() will never be called to set schemata
to 100%.

Since umount/mount resctrl file system is run on each resctrl test,
at the same time the default schemata will also be set to 100%.

Clear unused initialization code in MBM test, such as CMT test.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/mbm_test.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 8392e5c55ed0..38a3b3ad1c76 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -89,24 +89,19 @@ static int check_results(int span)
 static int mbm_setup(int num, ...)
 {
 	struct resctrl_val_param *p;
-	static int num_of_runs;
 	va_list param;
-	int ret = 0;
-
-	/* Run NUM_OF_RUNS times */
-	if (num_of_runs++ >= NUM_OF_RUNS)
-		return -1;
 
 	va_start(param, num);
 	p = va_arg(param, struct resctrl_val_param *);
 	va_end(param);
 
-	/* Set up shemata with 100% allocation on the first run. */
-	if (num_of_runs == 0)
-		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
-				     p->resctrl_val);
+	/* Run NUM_OF_RUNS times */
+	if (p->num_of_runs >= NUM_OF_RUNS)
+		return -1;
+
+	p->num_of_runs++;
 
-	return ret;
+	return 0;
 }
 
 void mbm_test_cleanup(void)
-- 
2.27.0

