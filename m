Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F40F6655AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jan 2023 09:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbjAKIDu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Jan 2023 03:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbjAKIDK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Jan 2023 03:03:10 -0500
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 Jan 2023 00:02:43 PST
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B31D5FF1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jan 2023 00:02:42 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="102257766"
X-IronPort-AV: E=Sophos;i="5.96,315,1665414000"; 
   d="scan'208";a="102257766"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Jan 2023 16:59:30 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5DC1CD66A0;
        Wed, 11 Jan 2023 16:59:29 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id BB47C16E53;
        Wed, 11 Jan 2023 16:59:28 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 940854007B0E5;
        Wed, 11 Jan 2023 16:59:28 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com, Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v5 3/5] selftests/resctrl: Flush stdout file buffer before executing fork()
Date:   Wed, 11 Jan 2023 16:58:00 +0900
Message-Id: <20230111075802.3556803-4-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230111075802.3556803-1-tan.shaopeng@jp.fujitsu.com>
References: <20230111075802.3556803-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When a process has buffered output, a child process created by fork()
will also copy buffered output. When using kselftest framework,
the output (resctrl test result message) will be printed multiple times.

Add fflush() to flush out the buffered output before executing fork().

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/cat_test.c    | 1 +
 tools/testing/selftests/resctrl/resctrl_val.c | 1 +
 tools/testing/selftests/resctrl/resctrlfs.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 1c5e90c63254..6a8306b0a109 100644
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
index 8546bc9f1786..d95688298469 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -678,6 +678,7 @@ int filter_dmesg(void)
 		perror("pipe");
 		return ret;
 	}
+	fflush(stdout);
 	pid = fork();
 	if (pid == 0) {
 		close(pipefds[0]);
-- 
2.27.0

