Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3839693E49
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 07:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjBMG2p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 01:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjBMG2o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 01:28:44 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921FFEB42;
        Sun, 12 Feb 2023 22:28:34 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="106341812"
X-IronPort-AV: E=Sophos;i="5.97,293,1669042800"; 
   d="scan'208";a="106341812"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 15:28:32 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id E9E18DF10F;
        Mon, 13 Feb 2023 15:28:29 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 35179D88B4;
        Mon, 13 Feb 2023 15:28:29 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 007D6404AF8A3;
        Mon, 13 Feb 2023 15:28:28 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v7 4/6] selftests/resctrl: Cleanup properly when an error occurs in CAT test
Date:   Mon, 13 Feb 2023 15:24:26 +0900
Message-Id: <20230213062428.1721572-5-tan.shaopeng@jp.fujitsu.com>
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

After creating a child process with fork() in CAT test, if an error
occurs when parent process runs cat_val() or check_results(), the child
process will not be killed and also resctrlfs is not unmounted. Also if
an error occurs when child process runs cat_val() or check_results(),
the child process is returned, but the parent process will wait pipe
message from child.

Synchronize the exits between the parent and child. An error occurs
whether in parents process or child process, the parents process
always kills child process and runs umount_resctrlfs(), and the
child process always waits to be killed by the parent process.

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

