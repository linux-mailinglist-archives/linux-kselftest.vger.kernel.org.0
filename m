Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBEA5B7EDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 04:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiINCSq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Sep 2022 22:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiINCSp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Sep 2022 22:18:45 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3D1558E1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Sep 2022 19:18:44 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="76604944"
X-IronPort-AV: E=Sophos;i="5.93,313,1654527600"; 
   d="scan'208";a="76604944"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 14 Sep 2022 10:55:05 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 14C38ADA71;
        Wed, 14 Sep 2022 10:55:05 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5990EE6478;
        Wed, 14 Sep 2022 10:55:04 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 321E1403E058D;
        Wed, 14 Sep 2022 10:55:04 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH 3/5] selftests/resctrl: Remove duplicate codes that clear each test result file
Date:   Wed, 14 Sep 2022 10:51:45 +0900
Message-Id: <20220914015147.3071025-5-tan.shaopeng@jp.fujitsu.com>
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

Before exiting each test function(run_cmt/cat/mbm/mba_test()),
test results are printed by ksft_print_msg() and then temporary result
files are cleaned by function cmt/cat/mbm/mba_test_cleanup().
However, before running ksft_print_msg(), function
cmt/cat/mbm/mba_test_cleanup()
has been run in each test function as follows:
  cmt_resctrl_val()
  cat_perf_miss_val()
  mba_schemata_change()
  mbm_bw_change()

Remove duplicate codes that clear each test result file.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 1 -
 tools/testing/selftests/resctrl/cmt_test.c | 2 --
 tools/testing/selftests/resctrl/mba_test.c | 2 --
 tools/testing/selftests/resctrl/mbm_test.c | 2 --
 4 files changed, 7 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 1c5e90c63254..d1134f66469f 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -221,7 +221,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		kill(bm_pid, SIGKILL);
 	}
 
-	cat_test_cleanup();
 	if (bm_pid)
 		umount_resctrlfs();
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 8968e36db99d..b3b17fb876f4 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -139,7 +139,5 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	if (ret)
 		return ret;
 
-	cmt_test_cleanup();
-
 	return 0;
 }
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 1a1bdb6180cf..93ffacb416df 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -166,7 +166,5 @@ int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
 	if (ret)
 		return ret;
 
-	mba_test_cleanup();
-
 	return 0;
 }
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 38a3b3ad1c76..a453db4c221f 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -134,7 +134,5 @@ int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
 	if (ret)
 		return ret;
 
-	mbm_test_cleanup();
-
 	return 0;
 }
-- 
2.27.0

