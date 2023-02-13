Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E25693E4B
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 07:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjBMG2q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 01:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjBMG2o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 01:28:44 -0500
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD29C1117D;
        Sun, 12 Feb 2023 22:28:33 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="94675138"
X-IronPort-AV: E=Sophos;i="5.97,293,1669042800"; 
   d="scan'208";a="94675138"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 15:28:31 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id D2C55E4459;
        Mon, 13 Feb 2023 15:28:28 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 393EDD3F06;
        Mon, 13 Feb 2023 15:28:28 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 0B0D7404AF893;
        Mon, 13 Feb 2023 15:28:28 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com, Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v7 3/6] selftests/resctrl: Flush stdout file buffer before executing fork()
Date:   Mon, 13 Feb 2023 15:24:25 +0900
Message-Id: <20230213062428.1721572-4-tan.shaopeng@jp.fujitsu.com>
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

