Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29535B7EC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 03:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiINB6U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Sep 2022 21:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiINB6T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Sep 2022 21:58:19 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EA13A4B8
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Sep 2022 18:58:17 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="76247799"
X-IronPort-AV: E=Sophos;i="5.93,313,1654527600"; 
   d="scan'208";a="76247799"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 14 Sep 2022 10:55:08 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id DA91EDAFCF;
        Wed, 14 Sep 2022 10:55:07 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 38326D214B;
        Wed, 14 Sep 2022 10:55:07 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 1157D403E058D;
        Wed, 14 Sep 2022 10:55:07 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH 5/5] selftests/resctrl: Flush stdout file buffer before executing fork()
Date:   Wed, 14 Sep 2022 10:51:47 +0900
Message-Id: <20220914015147.3071025-7-tan.shaopeng@jp.fujitsu.com>
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

When a process has buffered output, a child process created by fork()
will also copy buffered output. When using kselftest framework,
the output (resctrl test result message) will be printed multiple times.

Add fflush() to flush out the buffered output before executing fork().

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/cat_test.c    | 1 +
 tools/testing/selftests/resctrl/resctrl_val.c | 1 +
 tools/testing/selftests/resctrl/resctrlfs.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index f62da445acbb..69d17f5f4606 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -167,6 +167,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		return errno;
 	}
 
+	fflush(stdout);
 	bm_pid = fork();
 
 	/* Set param values for child thread which will be allocated bitmask
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index b32b96356ec7..6948843bf995 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -629,6 +629,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 	 * Fork to start benchmark, save child's pid so that it can be killed
 	 * when needed
 	 */
+	fflush(stdout);
 	bm_pid = fork();
 	if (bm_pid == -1) {
 		perror("# Unable to fork");
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 349dce00472f..a8cea64de65e 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -674,6 +674,7 @@ int filter_dmesg(void)
 		perror("pipe");
 		return ret;
 	}
+	fflush(stdout);
 	pid = fork();
 	if (pid == 0) {
 		close(pipefds[0]);
-- 
2.27.0

