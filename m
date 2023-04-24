Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E136E07A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 09:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDMHXG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 03:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDMHXF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 03:23:05 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0668B1BE6;
        Thu, 13 Apr 2023 00:23:03 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="114304608"
X-IronPort-AV: E=Sophos;i="5.98,339,1673881200"; 
   d="scan'208";a="114304608"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 16:23:02 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 09185DE50D;
        Thu, 13 Apr 2023 16:22:59 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 533FFD35F5;
        Thu, 13 Apr 2023 16:22:58 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 1E4FC40007204;
        Thu, 13 Apr 2023 16:22:58 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v9 1/6] selftests/resctrl: Fix set up schemata with 100% allocation on first run in MBM test
Date:   Thu, 13 Apr 2023 16:22:54 +0900
Message-Id: <20230413072259.2089348-2-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230413072259.2089348-1-tan.shaopeng@jp.fujitsu.com>
References: <20230413072259.2089348-1-tan.shaopeng@jp.fujitsu.com>
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
index c9dfa54af42f..9b591c35310f 100644
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
-		return END_OF_TESTS;
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
index cc6cf49e3129..b31b1d9e41d1 100644
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

