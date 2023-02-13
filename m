Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68105693E47
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 07:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBMG2g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 01:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBMG2g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 01:28:36 -0500
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5384C10418;
        Sun, 12 Feb 2023 22:28:31 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="106380955"
X-IronPort-AV: E=Sophos;i="5.97,293,1669042800"; 
   d="scan'208";a="106380955"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 15:28:29 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id D21B4DE50C;
        Mon, 13 Feb 2023 15:28:26 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3A4BCCFBA3;
        Mon, 13 Feb 2023 15:28:26 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 16F2E40418617;
        Mon, 13 Feb 2023 15:28:26 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v7 1/6] selftests/resctrl: Fix set up schemata with 100% allocation on first run in MBM test
Date:   Mon, 13 Feb 2023 15:24:23 +0900
Message-Id: <20230213062428.1721572-2-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230213062428.1721572-1-tan.shaopeng@jp.fujitsu.com>
References: <20230213062428.1721572-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a comment "Set up shemata with 100% allocation on the first run"
in function mbm_setup(), but there is an increment bug and the condition
"num_of_runs == 0" will never be met and write_schemata() will never be
called to set schemata to 100%. Even if write_schemata() is called in MBM
test, since it is not supported for MBM test it does not set the schemata.
This is currently fine because resctrl_val_parm->mum_resctrlfs is always 1
and umount/mount will be run in each test to set the schemata to 100%.

To support the usage when MBM test does not unmount/remount resctrl
filesystem before the test starts, fix to call write_schemata() and
set schemata properly when the function is called for the first time.

Also, remove static local variable 'num_of_runs' because this is not
needed as there is resctrl_val_param->num_of_runs which should be used
instead like in cat_setup().

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/mbm_test.c  | 13 +++++++------
 tools/testing/selftests/resctrl/resctrlfs.c |  4 +++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 8392e5c55ed0..6d550f012829 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -89,23 +89,24 @@ static int check_results(int span)
 static int mbm_setup(int num, ...)
 {
 	struct resctrl_val_param *p;
-	static int num_of_runs;
 	va_list param;
 	int ret = 0;
 
-	/* Run NUM_OF_RUNS times */
-	if (num_of_runs++ >= NUM_OF_RUNS)
-		return -1;
-
 	va_start(param, num);
 	p = va_arg(param, struct resctrl_val_param *);
 	va_end(param);
 
+	/* Run NUM_OF_RUNS times */
+	if (p->num_of_runs >= NUM_OF_RUNS)
+		return -1;
+
 	/* Set up shemata with 100% allocation on the first run. */
-	if (num_of_runs == 0)
+	if (p->num_of_runs == 0)
 		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
 				     p->resctrl_val);
 
+	p->num_of_runs++;
+
 	return ret;
 }
 
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 6f543e470ad4..8546bc9f1786 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -498,6 +498,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	FILE *fp;
 
 	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
+	    strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) &&
 	    strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) &&
 	    strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
 		return -ENOENT;
@@ -523,7 +524,8 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
 	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
 		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
-	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)))
+	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
+	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
 		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
 
 	fp = fopen(controlgroup, "w");
-- 
2.27.0

