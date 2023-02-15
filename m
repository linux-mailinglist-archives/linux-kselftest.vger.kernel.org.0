Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16AD697850
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 09:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjBOIgr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 03:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbjBOIgp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 03:36:45 -0500
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274AA25B9C;
        Wed, 15 Feb 2023 00:36:42 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="107664990"
X-IronPort-AV: E=Sophos;i="5.97,299,1669042800"; 
   d="scan'208";a="107664990"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 17:36:40 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 42986D6246;
        Wed, 15 Feb 2023 17:36:38 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 90B46D3F21;
        Wed, 15 Feb 2023 17:36:37 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 69252400C0299;
        Wed, 15 Feb 2023 17:36:37 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v8 4/6] selftests/resctrl: Cleanup properly when an error occurs in CAT test
Date:   Wed, 15 Feb 2023 17:32:28 +0900
Message-Id: <20230215083230.3155897-5-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230215083230.3155897-1-tan.shaopeng@jp.fujitsu.com>
References: <20230215083230.3155897-1-tan.shaopeng@jp.fujitsu.com>
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

After creating a child process with fork() in CAT test, if an error
occurs when parent process runs cat_val() or check_results(), the child
process will not be killed and also resctrlfs is not unmounted. Also if
an error occurs when child process runs cat_val() or check_results(),
the parent process will wait for the pipe message from the child process
which will never be sent by the child process and the parent process
cannot proceed to unmount resctrlfs.

Synchronize the exits between the parent and child. An error could
occur whether in parent process or child process. The parent process
always kills the child process and runs umount_resctrlfs(). The
child process always waits to be killed by the parent process.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 6a8306b0a109..477b62dac546 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -186,23 +186,20 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	remove(param.filename);
 
 	ret = cat_val(&param);
-	if (ret)
-		return ret;
-
-	ret = check_results(&param);
-	if (ret)
-		return ret;
+	if (ret == 0)
+		ret = check_results(&param);
 
 	if (bm_pid == 0) {
 		/* Tell parent that child is ready */
 		close(pipefd[0]);
 		pipe_message = 1;
 		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
-		    sizeof(pipe_message)) {
-			close(pipefd[1]);
+		    sizeof(pipe_message))
+			/*
+			 * Just print the error message.
+			 * Let while(1) run and wait for itself to be killed.
+			 */
 			perror("# failed signaling parent process");
-			return errno;
-		}
 
 		close(pipefd[1]);
 		while (1)
@@ -226,5 +223,5 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	if (bm_pid)
 		umount_resctrlfs();
 
-	return 0;
+	return ret;
 }
-- 
2.27.0

