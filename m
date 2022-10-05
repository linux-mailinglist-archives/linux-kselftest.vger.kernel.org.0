Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A775F4D74
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 03:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJEBno (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Oct 2022 21:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiJEBnn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Oct 2022 21:43:43 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4DC564FD;
        Tue,  4 Oct 2022 18:43:41 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="79241595"
X-IronPort-AV: E=Sophos;i="5.95,159,1661785200"; 
   d="scan'208";a="79241595"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 05 Oct 2022 10:43:39 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6295BD63BE;
        Wed,  5 Oct 2022 10:43:38 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 98AC4D9495;
        Wed,  5 Oct 2022 10:43:37 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 62ECD405D4705;
        Wed,  5 Oct 2022 10:43:37 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v2 1/4] selftests/resctrl: Fix set up shemata with 100% allocation on first run in MBM test.
Date:   Wed,  5 Oct 2022 10:39:30 +0900
Message-Id: <20221005013933.1486054-2-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221005013933.1486054-1-tan.shaopeng@jp.fujitsu.com>
References: <20221005013933.1486054-1-tan.shaopeng@jp.fujitsu.com>
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
called to set schemata to 100%. This is currently fine because
resctl_val_parm->num_resctrlfs is always 1 and umount/mount will be run
in each test to set the schemata to 100%.

To make mbm_setup() future code-change proof, fix to call
write-schemata() properly when the function is called for the first time.

Also, remove static local variable 'num_of_runs' because this is not
needed as there is resctl_val_param->num_of_runs which should be used
instead like in cat_setup().

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/mbm_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 8392e5c55ed0..4a54be314402 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -89,12 +89,11 @@ static int check_results(int span)
 static int mbm_setup(int num, ...)
 {
 	struct resctrl_val_param *p;
-	static int num_of_runs;
 	va_list param;
 	int ret = 0;
 
 	/* Run NUM_OF_RUNS times */
-	if (num_of_runs++ >= NUM_OF_RUNS)
+	if (p->num_of_runs >= NUM_OF_RUNS)
 		return -1;
 
 	va_start(param, num);
@@ -102,9 +101,10 @@ static int mbm_setup(int num, ...)
 	va_end(param);
 
 	/* Set up shemata with 100% allocation on the first run. */
-	if (num_of_runs == 0)
+	if (p->num_of_runs == 0)
 		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
 				     p->resctrl_val);
+	p->num_of_runs++;
 
 	return ret;
 }
-- 
2.27.0

