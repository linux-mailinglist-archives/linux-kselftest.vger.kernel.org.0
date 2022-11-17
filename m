Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489D162D06E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 02:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbiKQBLr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 20:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbiKQBLl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 20:11:41 -0500
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EE91DF11;
        Wed, 16 Nov 2022 17:11:39 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="75835688"
X-IronPort-AV: E=Sophos;i="5.96,169,1665414000"; 
   d="scan'208";a="75835688"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 17 Nov 2022 10:11:36 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id C8AE5C68E4;
        Thu, 17 Nov 2022 10:11:35 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2D62CD9693;
        Thu, 17 Nov 2022 10:11:35 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id 0A7C540089710;
        Thu, 17 Nov 2022 10:11:35 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com, Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v4 3/5] selftests/resctrl: Flush stdout file buffer before executing fork()
Date:   Thu, 17 Nov 2022 10:05:39 +0900
Message-Id: <20221117010541.1014481-4-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com>
References: <20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com>
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

